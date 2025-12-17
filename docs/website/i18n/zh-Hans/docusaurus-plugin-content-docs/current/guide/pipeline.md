---
sidebar_position: 1
---

# Pipeline API

Pipeline API 是使用 libvips_ffi 处理图像的主要方式。

## 概述

`VipsPipeline` 提供流畅的链式接口进行图像操作：

```dart
final result = VipsPipeline.fromFile('input.jpg')
  .operation1()
  .operation2()
  .operation3()
  .toFormat();
```

## 创建 Pipeline

### 从文件

```dart
final pipeline = VipsPipeline.fromFile('/path/to/image.jpg');
```

### 从内存

```dart
final bytes = await File('image.jpg').readAsBytes();
final pipeline = VipsPipeline.fromBuffer(bytes);
```

### 从另一个图像

```dart
final source = VipsPipeline.fromFile('input.jpg');
final copy = VipsPipeline.fromImage(source.image);
```

## 输出方法

### 转为字节

```dart
// JPEG
final jpegBytes = pipeline.toJpeg(quality: 85);

// PNG
final pngBytes = pipeline.toPng(compression: 6);

// WebP
final webpBytes = pipeline.toWebp(quality: 90);

// 从扩展名自动检测
final bytes = pipeline.toBuffer(format: 'jpg');
```

### 保存到文件

```dart
pipeline.toFile('output.jpg');
```

## 常用操作

### 缩放

```dart
// 按宽度（保持宽高比）
pipeline.resize(width: 800)

// 按高度（保持宽高比）
pipeline.resize(height: 600)

// 同时指定（可能改变宽高比）
pipeline.resize(width: 800, height: 600)

// 按比例
pipeline.resize(scale: 0.5)  // 50% 大小
```

### 缩略图

智能裁剪的缩略图：

```dart
pipeline.thumbnail(
  width: 200,
  height: 200,
  crop: VipsCrop.attention,  // 聚焦于有趣区域
)
```

### 裁剪

```dart
// 提取区域
pipeline.crop(x: 100, y: 100, width: 400, height: 300)

// 智能裁剪
pipeline.smartCrop(width: 400, height: 300, interesting: VipsInteresting.attention)
```

### 旋转

```dart
// 按角度旋转
pipeline.rotate(angle: 90)

// 根据 EXIF 自动旋转
pipeline.autoRotate()
```

### 颜色调整

```dart
pipeline
  .brightness(factor: 1.2)   // 增加 20% 亮度
  .contrast(factor: 1.1)     // 增加 10% 对比度
  .saturation(factor: 0.8)   // 降低 20% 饱和度
  .grayscale()               // 转为灰度
```

### 滤镜

```dart
pipeline
  .gaussianBlur(sigma: 2.0)  // 高斯模糊
  .sharpen()                  // 锐化
  .invert()                   // 反色
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

## 内存管理

Pipeline 自动管理内存。内部 VipsImage 在以下情况释放：

1. Pipeline 超出作用域
2. 显式调用 `dispose()`

```dart
final pipeline = VipsPipeline.fromFile('input.jpg');
try {
  // 使用 pipeline
  final result = pipeline.resize(width: 800).toJpeg();
  return result;
} finally {
  pipeline.dispose();  // 可选但推荐用于大图像
}
```

## 下一步

- [操作参考](./operations) - 所有可用操作
- [输出格式](./formats) - 支持的输出格式
- [异步处理](./async) - 在 isolate 中处理
