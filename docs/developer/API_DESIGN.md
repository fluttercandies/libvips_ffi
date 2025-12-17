# libvips_ffi_api 包设计方案

> 本文档记录 `libvips_ffi_api` 包的设计决策和实施计划。

## 1. 设计目标

- **仅依赖 core**：不负责库加载，由上层（Flutter 包或用户代码）处理
- **Pipeline 链式 API**：参考 sharp (Node.js) 的设计风格
- **高性能**：内部使用 VipsImg 封装，避免中间编解码开销
- **模块化**：使用 Extension 按功能分文件，单文件建议 400 行内（特殊需求最多 700 行）
- **Flutter 兼容**：考虑 compute/isolate 调用便利性
- **独立的高级封装**：api 包有自己的 VipsImg 封装类
- **libvips 操作完整覆盖**：完整覆盖 libvips 操作，而不仅仅是 core 中的封装，它是全量的 vips 重实现。

## 1.1 关键设计决策

### API 包定位

**api 包是完全独立的高级封装包**：

- 依赖 core 包的：
  - `vips_bindings_generated.dart`（ffigen 生成的基础绑定）
  - `DynamicLibrary`（已加载的库实例）
  - 基础 FFI 类型定义
- api 包有**自己的图像封装类**（VipsImg）
- api 包有**自己的 variadic bindings 实现**（ffigen 无法处理 variadic 函数）
- api 包有**自己的类型定义和封装类**（VipsImage、Pipeline 等）
- **api 包不负责库加载**，由上层（Flutter 包、loader 包、用户代码）处理
- **外部调用时不需要考虑 C 指针、内存管理等问题**
- 所有 FFI 细节对用户透明

### 覆盖策略

**完整覆盖 - 预留所有 libvips 操作位置**：

- libvips 共有约 300+ 个操作函数
- api 包设计时预留所有操作的位置（文件结构、模块划分）
- **api 包自己实现所有 variadic bindings**
- 渐进式实现，优先实现常用操作

### 文件组织原则

- 单文件建议 400 行内
- 根据模块具体分析，如某类型过大则进一步细分
- 例如：Colour 模块有 20+ 操作，可拆分为 `colour_convert.dart` 和 `colour_profile.dart`

## 2. 核心 API 设计

### 2.1 VipsPipeline 类

核心链式处理类，内部持有 `VipsImg`：

```dart
/// 链式图像处理管道
/// 内部持有 VipsImg，只在输出时转换为 buffer
class VipsPipeline {
  VipsImg _image;
  
  // ======= 构造方法 =======
  
  VipsPipeline._(this._image);
  
  /// 从文件创建
  factory VipsPipeline.fromFile(String path) {
    return VipsPipeline._(VipsImg.fromFile(path));
  }
  
  /// 从 buffer 创建
  factory VipsPipeline.fromBuffer(Uint8List data) {
    return VipsPipeline._(VipsImg.fromBuffer(data));
  }
  
  /// 从现有 VipsImg 创建
  factory VipsPipeline.fromImage(VipsImg image) {
    return VipsPipeline._(image);
  }
  
  // ======= 链式操作（由 Extension 提供）=======
  // 每个操作：执行 -> 释放旧对象 -> 更新 _image -> 返回 this
  
  // ======= 输出方法 =======
  
  /// 输出为 buffer（触发编码）
  Uint8List toBuffer({String format = '.png'}) {
    final data = _image.writeToBuffer(format);
    dispose();
    return data;
  }
  
  /// 写入文件
  void toFile(String path) {
    _image.writeToFile(path);
    dispose();
  }
  
  /// 获取当前图像（调用者负责释放）
  VipsImg get image => _image;
  
  /// 创建检查点（返回当前状态的 buffer，可用于分支）
  Uint8List checkpoint({String format = '.png'}) {
    return _image.writeToBuffer(format);
  }
  
  /// 释放资源
  void dispose() {
    if (!_image.isDisposed) {
      _image.dispose();
    }
  }
  
  // ======= 属性 =======
  int get width => _image.width;
  int get height => _image.height;
  int get bands => _image.bands;
  bool get isDisposed => _image.isDisposed;
}
```

### 2.2 内存管理策略

采用**立即释放**策略（方案 A）：

```dart
extension VipsResampleExtension on VipsPipeline {
  VipsPipeline resize(double scale) {
    final old = _image;
    _image = old.resize(scale);
    old.dispose();  // 立即释放旧对象
    return this;
  }
}
```

**设计理由**：

- libvips 使用延迟求值，中间 VipsImage 对象很小（只是操作描述）
- libvips 引用计数机制确保依赖数据不会被过早释放
- 内存压力最小
- 如需分支，使用 `checkpoint()` 或 `toBuffer()` 保存状态

### 2.3 分支处理

用户可通过 buffer 还原状态实现分支：

```dart
// 创建检查点
final checkpoint = VipsPipeline.fromFile('input.jpg')
    .resize(0.5)
    .checkpoint();  // 返回 Uint8List，不释放 pipeline

// 从检查点创建新分支
final version1 = VipsPipeline.fromBuffer(checkpoint)
    .blur(1.0)
    .toFile('v1.jpg');

final version2 = VipsPipeline.fromBuffer(checkpoint)
    .sharpen()
    .toFile('v2.jpg');
```

## 3. 文件结构

```text
packages/libvips_ffi_api/
├── lib/
│   ├── libvips_ffi_api.dart              # 主入口，导出所有公开 API
│   └── src/
│       ├── bindings/                     # api 包自己的 FFI 绑定
│       │   ├── vips_ffi_types.dart       # FFI 类型定义（VarArgs 等）
│       │   └── vips_bindings.dart        # variadic 函数绑定
│       ├── image/
│       │   └── vips_image.dart           # VipsImage 封装类
│       ├── pipeline/
│       │   ├── vips_pipeline.dart        # 核心 Pipeline 类
│       │   └── extensions/               # Pipeline 扩展方法
│       │       ├── resample_ext.dart     # resize, thumbnail, rotate...
│       │       ├── geometry_ext.dart     # crop, embed, smartCrop...
│       │       ├── convolution_ext.dart  # blur, sharpen...
│       │       ├── colour_ext.dart       # colourspace, brightness...
│       │       ├── conversion_ext.dart   # flatten, cast, bandjoin...
│       │       ├── composite_ext.dart    # insert, join, arrayjoin...
│       │       ├── foreign_ext.dart      # toFile, toBuffer...
│       │       └── create_ext.dart       # black, text, noise...
│       ├── spec/                         # Flutter compute 支持
│       │   ├── pipeline_spec.dart        # 可序列化的操作描述
│       │   └── operation_spec.dart       # 单个操作规格
│       └── types/
│           ├── save_options.dart         # JpegOptions, PngOptions 等
│           └── enums.dart                # 补充枚举类型
├── pubspec.yaml
├── CHANGELOG.md
└── README.md
```

**预估总行数**: ~1500 行，每个文件 50-200 行，符合 400 行限制。

## 4. Extension 模块划分

按 libvips 官方分类组织（完整覆盖 300+ 操作）：

### 4.1 核心模块（优先实现）

| Extension 文件 | 操作类别 | 主要操作 |
|---------------|---------|---------|
| `resample_ext.dart` | Resample | resize, thumbnail, rotate, reduce, shrink, affine, mapim |
| `geometry_ext.dart` | Geometry | crop, embed, extractArea, smartCrop, zoom, gravity, flip |
| `convolution_ext.dart` | Convolution | gaussblur, sharpen, sobel, canny, conv, convsep |
| `colour_ext.dart` | Colour (基础) | colourspace, brightness, contrast, linear |
| `conversion_ext.dart` | Conversion | flatten, cast, copy, bandjoin, bandmean, addalpha |
| `composite_ext.dart` | Composite | insert, join, arrayjoin, composite, ifthenelse |
| `foreign_ext.dart` | Foreign (I/O) | writeToFile, writeToBuffer (已在 core) |
| `create_ext.dart` | Create | black, text, gaussnoise, xyz, grey, eye, zone |

### 4.2 扩展模块（按需实现）

| Extension 文件 | 操作类别 | 主要操作 |
|---------------|---------|---------|
| `arithmetic_ext.dart` | Arithmetic | add, subtract, multiply, divide, abs, sign, math, round |
| `relational_ext.dart` | Relational | equal, notequal, less, more, lesseq, moreeq |
| `boolean_ext.dart` | Boolean | and, or, eor, lshift, rshift |
| `colour_convert_ext.dart` | Colour (转换) | Lab2XYZ, XYZ2Lab, HSV2sRGB, CMYK2XYZ 等 20+ |
| `colour_profile_ext.dart` | Colour (ICC) | icc_import, icc_export, icc_transform |
| `histogram_ext.dart` | Histogram | hist_find, hist_cum, hist_norm, hist_equal, hist_match |
| `morphology_ext.dart` | Morphology | rank, median, dilate, erode, countlines |
| `frequency_ext.dart` | Frequency | fwfft, invfft, freqmult, phasecor, spectrum |
| `draw_ext.dart` | Draw | draw_circle, draw_rect, draw_line, draw_flood, draw_smudge |
| `statistics_ext.dart` | Statistics | avg, deviate, min, max, stats, getpoint |

### 4.3 文件组织说明

- 每个 Extension 文件控制在 **400 行内**
- 如某模块操作过多（如 Colour 有 20+ 转换），拆分为多个文件
- 优先实现核心模块，扩展模块按需添加
- api 包自己实现对应的 variadic 绑定

## 5. Flutter compute 兼容

### 5.1 直接在 isolate 内使用

```dart
// Flutter 层示例
import 'package:flutter/foundation.dart';
import 'package:libvips_ffi/libvips_ffi.dart';

Future<Uint8List> processImage(String path, double scale) {
  return compute((params) {
    initVips();  // isolate 内初始化
    return VipsPipeline.fromFile(params['path'])
        .resize(params['scale'])
        .toBuffer();
  }, {'path': path, 'scale': scale});
}
```

### 5.2 使用 PipelineSpec（可序列化描述）

```dart
/// 可序列化的管道规格（用于跨 isolate 传递）
class PipelineSpec {
  final String? inputPath;
  final Uint8List? inputBuffer;
  final List<OperationSpec> operations;
  final OutputSpec output;
  
  /// 构建管道描述（不执行）
  PipelineSpec input(String path) => ...;
  PipelineSpec inputBuffer(Uint8List data) => ...;
  PipelineSpec resize(double scale) => ...;
  PipelineSpec blur(double sigma) => ...;
  PipelineSpec outputAs(String format) => ...;
  
  /// 在当前 isolate 执行
  Uint8List execute() {
    initVips();  // 确保已初始化
    var pipeline = inputPath != null 
        ? VipsPipeline.fromFile(inputPath!)
        : VipsPipeline.fromBuffer(inputBuffer!);
    
    for (final op in operations) {
      pipeline = op.apply(pipeline);
    }
    
    return pipeline.toBuffer(format: output.format);
  }
}

/// 单个操作规格
class OperationSpec {
  final String name;
  final Map<String, dynamic> params;
  
  VipsPipeline apply(VipsPipeline pipeline) {
    switch (name) {
      case 'resize': return pipeline.resize(params['scale']);
      case 'blur': return pipeline.blur(params['sigma']);
      // ...
    }
  }
}
```

### 5.3 Flutter 包集成

`libvips_ffi` 包会 re-export api 并提供便捷方法：

```dart
// libvips_ffi/lib/libvips_ffi.dart
export 'package:libvips_ffi_api/libvips_ffi_api.dart';

// libvips_ffi/lib/src/compute_helpers.dart
class VipsCompute {
  /// 使用 PipelineSpec 在后台处理
  static Future<Uint8List> execute(PipelineSpec spec) {
    return compute((_) => spec.execute(), null);
  }
  
  /// 便捷方法：调整大小
  static Future<Uint8List> resizeFile(String path, double scale) {
    return execute(PipelineSpec()
        .input(path)
        .resize(scale)
        .outputAs('.png'));
  }
}
```

## 6. 依赖关系

```yaml
# packages/libvips_ffi_api/pubspec.yaml
name: libvips_ffi_api
description: High-level API for libvips image processing
version: 0.1.0

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  libvips_ffi_core: ^0.1.0
```

## 7. 使用示例

### 7.1 纯 Dart 使用

```dart
import 'package:libvips_ffi_core/libvips_ffi_core.dart';
import 'package:libvips_ffi_api/libvips_ffi_api.dart';

void main() {
  initVipsSystem();  // 用户负责初始化
  
  // 链式处理
  final result = VipsPipeline.fromFile('input.jpg')
      .resize(0.5)
      .blur(1.0)
      .sharpen()
      .toBuffer(format: '.jpg');
  
  // 直接写文件
  VipsPipeline.fromFile('input.jpg')
      .thumbnail(200)
      .toFile('thumb.jpg');
  
  // 分支处理
  final base = VipsPipeline.fromFile('input.jpg')
      .resize(0.5)
      .checkpoint();
  
  VipsPipeline.fromBuffer(base).blur(2.0).toFile('blurred.jpg');
  VipsPipeline.fromBuffer(base).sharpen().toFile('sharp.jpg');
  
  shutdownVips();
}
```

### 7.2 Flutter 使用

```dart
import 'package:libvips_ffi/libvips_ffi.dart';

Future<void> processImages() async {
  initVips();  // Flutter 包自动选择正确的库
  
  // 同步处理（主线程，小图像）
  final thumb = VipsPipeline.fromFile('small.jpg')
      .thumbnail(100)
      .toBuffer();
  
  // 异步处理（后台 isolate，大图像）
  final result = await VipsCompute.execute(
    PipelineSpec()
        .input('large.jpg')
        .resize(0.25)
        .blur(1.5)
        .outputAs('.webp'),
  );
}
```

## 8. 实施计划

### Phase 1：核心框架

1. 创建 `libvips_ffi_api` 包结构
2. 实现 `VipsPipeline` 核心类
3. 实现基础 Extension：resample, convolution

### Phase 2：完善操作

1. 实现 colour, conversion, composite Extension
2. 实现 create Extension（静态工厂方法）

### Phase 3：Flutter 集成

1. 实现 PipelineSpec 可序列化描述
2. 在 libvips_ffi 包中集成 api
3. 更新 VipsCompute 使用新 API

### Phase 4：文档和测试

1. 完善 README 和 API 文档
2. 添加单元测试

## 9. 版本号

遵循项目版本号策略：
- `libvips_ffi_api`: `0.1.0`（纯 Dart 代码包，不含预编译库）

---

*文档创建时间：2024-12-16*
*状态：待确认*
