---
sidebar_position: 3
---

# libvips_ffi_api

用于 libvips 图像处理的高级 Dart API。

## 安装

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0+8.16.0
```

:::note
此包不包含 libvips 二进制文件。你还需要一个加载器包 (`libvips_ffi`、`libvips_ffi_desktop` 或 `libvips_ffi_system`)。
:::

## 特性

- `VipsPipeline` - 流畅的链式 API
- `PipelineSpec` - 可序列化的 pipeline 定义
- libvips 操作的完整 FFI 绑定
- 类型安全的操作参数

## 核心类

### VipsPipeline

带有流畅 API 的图像处理主类。

```dart
final result = VipsPipeline.fromFile('input.jpg')
  .resize(width: 800)
  .gaussianBlur(sigma: 1.5)
  .toJpeg(quality: 85);
```

### PipelineSpec

可序列化的 pipeline 操作规范。

```dart
final spec = PipelineSpec.fromFile('input.jpg')
  .resize(width: 800)
  .toJpeg(quality: 85);

// 同步执行
final result = spec.execute();

// 或保存以供后续使用 / 发送到 isolate
final json = spec.toJson();
```

### VipsImg

直接 FFI 操作的底层图像包装器。

```dart
final img = VipsImg.fromFile('input.jpg');
try {
  // 直接访问图像属性
  print('宽度: ${img.width}');
  print('高度: ${img.height}');
  print('通道: ${img.bands}');
} finally {
  img.dispose();
}
```

## 绑定

此包包含按类别组织的完整 FFI 绑定：

| 模块 | 操作 |
|------|------|
| `ArithmeticBindings` | add, subtract, multiply, divide, clamp 等 |
| `ColourBindings` | colourspace, icc_import, icc_export 等 |
| `ConversionBindings` | cast, flip, rot, embed, extract 等 |
| `ConvolutionBindings` | conv, sharpen, gaussblur 等 |
| `CreateBindings` | black, xyz, text, gaussnoise 等 |
| `DrawBindings` | draw_rect, draw_circle, draw_line 等 |
| `IoBindings` | load, save (jpeg, png, webp 等) |
| `ResampleBindings` | resize, thumbnail, affine 等 |

## 扩展方法

操作组织为 `VipsPipeline` 上的扩展方法：

```dart
// 算术扩展
pipeline.add(value)
pipeline.multiply(factor)
pipeline.clamp(min, max)

// 颜色扩展
pipeline.grayscale()
pipeline.colourspace(VipsInterpretation.sRGB)

// 几何扩展
pipeline.resize(width: 800)
pipeline.rotate(angle: 45)
pipeline.crop(x: 0, y: 0, width: 100, height: 100)

// 滤镜扩展
pipeline.gaussianBlur(sigma: 2.0)
pipeline.sharpen()
```

## 错误处理

```dart
try {
  final result = VipsPipeline.fromFile('input.jpg')
    .resize(width: 800)
    .toJpeg();
} on VipsApiException catch (e) {
  print('libvips 错误: ${e.message}');
}
```
