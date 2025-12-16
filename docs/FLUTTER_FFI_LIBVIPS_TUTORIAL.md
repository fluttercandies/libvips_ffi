# Flutter FFI libvips 使用教程

本文档提供 libvips_ffi 系列包的使用教程和 FFI 兼容性分析。

## 目录

1. [Flutter FFI 兼容性报告](#flutter-ffi-兼容性报告)
2. [快速开始](#快速开始)
3. [API 使用指南](#api-使用指南)
4. [平台集成指南](#平台集成指南)
5. [最佳实践](#最佳实践)

---

## Flutter FFI 兼容性报告

### 概述

`dart:ffi` 是 Dart 的外部函数接口库，允许 Dart 代码调用原生 C 库。

### Dart FFI 版本演进

| Dart 版本 | Flutter 版本 | FFI 关键特性 |
|-----------|-------------|-------------|
| Dart 2.12 | Flutter 2.0 | `dart:ffi` 正式稳定版、空安全支持 |
| Dart 2.13 | Flutter 2.2 | `Array` 类型、`Union` 支持 |
| Dart 3.0 | Flutter 3.10 | `NativeCallable`、`VarArgs` 支持 |
| Dart 3.4 | Flutter 3.22 | Native Assets 正式支持 |

### 最低推荐版本

| 需求级别 | Flutter 版本 | Dart 版本 | 理由 |
|----------|-------------|-----------|------|
| **最低可用** | Flutter 3.10+ | Dart 3.0+ | `VarArgs` 支持（variadic 函数必需） |
| **推荐** | Flutter 3.16+ | Dart 3.2+ | 更好的性能和稳定性 |

### 平台支持

| 平台 | 支持状态 | 库加载方式 |
|------|---------|-----------|
| Android | ✅ 完全支持 | `DynamicLibrary.open()` |
| iOS | ✅ 完全支持 | `DynamicLibrary.process()` (静态链接) |
| macOS | ✅ 完全支持 | `DynamicLibrary.open()` |
| Linux | ✅ 完全支持 | `DynamicLibrary.open()` |
| Windows | ✅ 完全支持 | `DynamicLibrary.open()` |
| Web | ❌ 不支持 | N/A |

---

## 快速开始

### Flutter 移动端 (Android/iOS)

```yaml
# pubspec.yaml
dependencies:
  libvips_ffi: ^0.0.1
```

```dart
import 'package:libvips_ffi/libvips_ffi.dart';

void main() {
  // 初始化
  initVips();
  
  // 同步 API - VipsPipeline
  final pipeline = VipsPipeline.fromFile('input.jpg');
  pipeline
    .resize(0.5)
    .blur(2.0)
    .sharpen();
  pipeline.toFile('output.jpg');
  pipeline.dispose();
  
  // 异步 API - VipsPipelineCompute (推荐用于 Flutter UI)
  final result = await VipsPipelineCompute.processFile(
    'input.jpg',
    (p) => p.resize(0.5).blur(2.0),
  );
  // result.data 包含处理后的图像字节
  
  shutdownVips();
}
```

### Flutter 桌面端

```yaml
# pubspec.yaml
dependencies:
  libvips_ffi: ^0.0.1
  libvips_ffi_macos: ^0.1.0   # macOS
  # libvips_ffi_windows: ^0.1.0  # Windows
  # libvips_ffi_linux: ^0.1.0    # Linux
```

### 纯 Dart (CLI/Server)

```yaml
# pubspec.yaml
dependencies:
  libvips_ffi_core: ^0.1.0
  libvips_ffi_api: ^0.1.0
```

```dart
import 'package:libvips_ffi_core/libvips_ffi_core.dart';
import 'package:libvips_ffi_api/libvips_ffi_api.dart';

void main() {
  // 使用系统安装的 libvips
  // macOS: brew install vips
  // Linux: apt install libvips-dev
  initVipsSystem();
  
  final pipeline = VipsPipeline.fromFile('input.jpg');
  pipeline.resize(0.5);
  pipeline.toFile('output.jpg');
  pipeline.dispose();
  
  shutdownVips();
}
```

---

## API 使用指南

### VipsPipeline - 同步链式 API

`VipsPipeline` 提供流畅的链式 API，内部自动管理中间图像的内存：

```dart
// 创建 Pipeline
final pipeline = VipsPipeline.fromFile('input.jpg');
// 或从内存创建
// final pipeline = VipsPipeline.fromBuffer(imageBytes);

// 链式操作
pipeline
  .resize(0.5)                              // 缩放 50%
  .thumbnail(200)                           // 缩略图 200px 宽
  .rotate(90)                               // 旋转 90 度
  .crop(100, 100, 200, 200)                 // 裁剪区域
  .flip(VipsDirection.horizontal)           // 水平翻转
  .blur(5.0)                                // 高斯模糊
  .sharpen()                                // 锐化
  .linear(1.3, 0)                           // 亮度调整
  .colourspace(VipsInterpretation.bw)       // 转灰度
  .smartCrop(300, 300)                      // 智能裁剪
  .autoRotate();                            // 根据 EXIF 自动旋转

// 输出
pipeline.toFile('output.jpg');
// 或输出到内存
// final bytes = pipeline.toBuffer(format: '.png');

// 释放资源
pipeline.dispose();
```

### VipsPipelineCompute - 异步 API

在 Flutter 应用中，使用 `VipsPipelineCompute` 避免阻塞 UI 线程：

```dart
import 'package:libvips_ffi/libvips_ffi.dart';

// 从文件处理
final result = await VipsPipelineCompute.processFile(
  'input.jpg',
  (pipeline) => pipeline
    .resize(0.5)
    .blur(2.0)
    .colourspace(VipsInterpretation.srgb),
  outputFormat: '.webp',
);

// result.data - 处理后的图像字节
// result.width, result.height - 图像尺寸

// 显示结果
Image.memory(result.data);
```

### PipelineSpec - 可序列化的操作描述

`PipelineSpec` 允许预定义处理流程，适合跨 isolate 传递：

```dart
// 定义处理规格
final spec = PipelineSpec()
  .input('input.jpg')
  .resize(0.5)
  .blur(2.0)
  .outputAs('.png');

// 执行
final result = spec.execute();
```

### 常用操作速查

| 操作 | 方法 | 示例 |
|------|------|------|
| 缩放 | `resize(scale)` | `pipeline.resize(0.5)` |
| 缩略图 | `thumbnail(width)` | `pipeline.thumbnail(200)` |
| 旋转 | `rotate(angle)` | `pipeline.rotate(90)` |
| 裁剪 | `crop(left, top, w, h)` | `pipeline.crop(0, 0, 100, 100)` |
| 翻转 | `flip(direction)` | `pipeline.flip(VipsDirection.horizontal)` |
| 模糊 | `blur(sigma)` | `pipeline.blur(5.0)` |
| 锐化 | `sharpen()` | `pipeline.sharpen()` |
| 亮度 | `linear(a, b)` | `pipeline.linear(1.2, 0)` |
| 灰度 | `colourspace(interp)` | `pipeline.colourspace(VipsInterpretation.bw)` |
| 智能裁剪 | `smartCrop(w, h)` | `pipeline.smartCrop(300, 300)` |
| 自动旋转 | `autoRotate()` | `pipeline.autoRotate()` |
| 反色 | `invert()` | `pipeline.invert()` |

---

## 平台集成指南

### Android

预编译库已包含在 `libvips_ffi` 包中，支持：
- `arm64-v8a`
- `armeabi-v7a`  
- `x86_64`

所有 64 位库已 16KB 对齐，兼容 Android 15+。

### iOS

预编译库已包含在 `libvips_ffi` 包中，支持：
- `arm64` (设备)
- `arm64` (Apple Silicon 模拟器)

最低 iOS 版本：12.0

### macOS

使用 `libvips_ffi_macos` 包获取预编译库，或使用系统库：

```bash
brew install vips
```

### Windows

使用 `libvips_ffi_windows` 包获取预编译库。

### Linux

使用 `libvips_ffi_linux` 包或系统库：

```bash
# Ubuntu/Debian
apt install libvips-dev

# Fedora
dnf install vips-devel
```

---

## 最佳实践

### 1. 内存管理

```dart
// VipsPipeline 自动管理中间图像
final pipeline = VipsPipeline.fromFile('input.jpg');
try {
  pipeline.resize(0.5).blur(2.0);
  pipeline.toFile('output.jpg');
} finally {
  pipeline.dispose();  // 确保释放资源
}

// 开发时检查内存泄漏
if (VipsPointerManager.instance.hasLeaks) {
  print(VipsPointerManager.instance.getLeakReport());
}
```

### 2. Flutter UI 中使用异步 API

```dart
class ImageProcessor extends StatefulWidget {
  @override
  State<ImageProcessor> createState() => _ImageProcessorState();
}

class _ImageProcessorState extends State<ImageProcessor> {
  Uint8List? _processedImage;
  bool _isProcessing = false;

  Future<void> _processImage(String path) async {
    setState(() => _isProcessing = true);
    
    try {
      final result = await VipsPipelineCompute.processFile(
        path,
        (p) => p.resize(0.5).blur(2.0),
      );
      setState(() => _processedImage = result.data);
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isProcessing) {
      return CircularProgressIndicator();
    }
    if (_processedImage != null) {
      return Image.memory(_processedImage!);
    }
    return Text('No image');
  }
}
```

### 3. 错误处理

```dart
try {
  final pipeline = VipsPipeline.fromFile('input.jpg');
  pipeline.resize(0.5);
  pipeline.toFile('output.jpg');
  pipeline.dispose();
} on VipsApiException catch (e) {
  print('Vips error: ${e.message}');
} catch (e) {
  print('Unexpected error: $e');
}
```

### 4. 批量处理

```dart
Future<void> batchProcess(List<String> files) async {
  for (final file in files) {
    final result = await VipsPipelineCompute.processFile(
      file,
      (p) => p.thumbnail(200),
      outputFormat: '.webp',
    );
    
    final outputPath = file.replaceAll('.jpg', '_thumb.webp');
    await File(outputPath).writeAsBytes(result.data);
  }
}
```

---

## 包结构

| 包名 | 说明 | 依赖 Flutter |
|------|------|-------------|
| `libvips_ffi_core` | 底层 FFI 绑定 | ❌ |
| `libvips_ffi_api` | 高级 API (VipsPipeline) | ❌ |
| `libvips_ffi` | Flutter 移动端包 | ✅ |
| `libvips_ffi_desktop` | 桌面端元包 | ❌ |
| `libvips_ffi_macos` | macOS 预编译库 | ❌ |
| `libvips_ffi_windows` | Windows 预编译库 | ❌ |
| `libvips_ffi_linux` | Linux 预编译库 | ❌ |
| `libvips_ffi_system` | 系统库加载 | ❌ |
| `libvips_ffi_loader` | 动态下载加载 | ❌ |

---

## 参考资源

- [libvips 官方文档](https://www.libvips.org/API/current/)
- [Dart FFI 官方文档](https://dart.dev/guides/libraries/c-interop)
- [Flutter 平台集成](https://docs.flutter.dev/platform-integration/android/c-interop)

---

*文档更新时间: 2025-01*
