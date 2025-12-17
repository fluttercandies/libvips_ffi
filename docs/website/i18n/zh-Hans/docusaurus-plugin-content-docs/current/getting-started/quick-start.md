---
sidebar_position: 2
---

# 快速开始

学习使用 libvips_ffi 处理你的第一张图片。

## 初始化 libvips

在使用任何 libvips 函数之前，必须初始化库：

```dart
import 'package:libvips_ffi/libvips_ffi.dart';

void main() {
  // 初始化 libvips
  VipsCore.init();
  
  // 你的图像处理代码
  
  // 完成后清理
  VipsCore.shutdown();
}
```

## 基本图像处理

### 加载和保存

```dart
// 从文件加载
final pipeline = VipsPipeline.fromFile('input.jpg');

// 处理并保存为字节
final bytes = pipeline.toJpeg(quality: 85);

// 写入文件
File('output.jpg').writeAsBytesSync(bytes);
```

### 缩放

```dart
final result = VipsPipeline.fromFile('input.jpg')
  .resize(width: 800)  // 缩放到 800px 宽，保持宽高比
  .toJpeg();
```

### 缩略图

```dart
// 创建 200x200 的智能裁剪缩略图
final result = VipsPipeline.fromFile('input.jpg')
  .thumbnail(width: 200, height: 200, crop: VipsCrop.attention)
  .toJpeg();
```

### 应用效果

```dart
final result = VipsPipeline.fromFile('input.jpg')
  .gaussianBlur(sigma: 2.0)  // 模糊
  .sharpen()                  // 锐化
  .grayscale()               // 转换为灰度
  .toJpeg();
```

## 链式操作

Pipeline API 支持方法链式调用进行复杂变换：

```dart
final result = VipsPipeline.fromFile('input.jpg')
  .autoRotate()                    // 修复 EXIF 方向
  .resize(width: 1920)             // 缩放到 1920px 宽
  .crop(x: 100, y: 100, width: 800, height: 600)  // 裁剪区域
  .rotate(angle: 45)               // 旋转 45 度
  .brightness(factor: 1.2)         // 增加亮度
  .contrast(factor: 1.1)           // 增加对比度
  .gaussianBlur(sigma: 0.5)        // 轻微模糊
  .toWebp(quality: 90);            // 导出为 WebP
```

## 异步处理

在 Flutter 应用中，使用 `VipsPipelineCompute` 在 isolate 中处理图像：

```dart
import 'package:libvips_ffi/libvips_ffi.dart';

Future<Uint8List> processImage(String inputPath) async {
  return await VipsPipelineCompute.run(
    PipelineSpec.fromFile(inputPath)
      .resize(width: 800)
      .toJpeg(quality: 85),
  );
}
```

## 下一步

- [Pipeline API](../guide/pipeline) - 深入了解 Pipeline API
- [输出格式](../guide/formats) - 了解支持的格式
- [操作](../guide/operations) - 所有可用操作
