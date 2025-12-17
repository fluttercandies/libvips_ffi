---
sidebar_position: 4
---

# 异步处理

学习如何在 Flutter 应用中异步处理图像。

## 问题

图像处理是 CPU 密集型的。在主线程运行会：

- 阻塞 UI，导致动画卡顿
- 在 Android 上触发 ANR（应用无响应）
- 让应用感觉不流畅

此外，Dart isolate 有一个基本限制：**闭包无法在 isolate 之间传递**。这意味着你不能将 `VipsPipeline` 对象发送到另一个 isolate。

## 解决方案：PipelineSpec + VipsPipelineCompute

`PipelineSpec` 是图像处理操作的**可序列化**表示。它可以安全地传输到任何 isolate，然后在那里执行。

`VipsPipelineCompute` 使用 Flutter 的 `compute()` 函数在单独的 isolate 中运行 spec。

```dart
import 'package:libvips_ffi/libvips_ffi.dart';

Future<Uint8List> processImage(String inputPath) async {
  final spec = PipelineSpec()
    .input(inputPath)
    .resize(0.5)
    .outputJpeg(85);
  
  return await VipsPipelineCompute.execute(spec);
}
```

## PipelineSpec

`PipelineSpec` 是解决 isolate 闭包限制的可序列化操作描述。

### 创建 Spec

```dart
// 从文件路径
final spec = PipelineSpec()
  .input('/path/to/image.jpg');

// 从字节 (Uint8List)
final spec = PipelineSpec()
  .inputBuffer(imageBytes);
```

### 添加操作

操作通过链式调用：

```dart
final spec = PipelineSpec()
  .input('input.jpg')
  .resize(0.5)           // 缩放到 50%
  .blur(1.5)             // 高斯模糊
  .brightness(1.1)       // +10% 亮度
  .outputJpeg(85);       // 输出为 JPEG 质量 85
```

### 输出格式

```dart
// JPEG 带质量 (默认: 75)
spec.outputJpeg(85)

// PNG 带压缩 (默认: 6)
spec.outputPng(9)

// WebP
spec.outputWebp(quality: 80, lossless: false)
```

### 运行 Spec

```dart
// 在 isolate 中异步执行（推荐用于 Flutter）
final result = await VipsPipelineCompute.execute(spec);

// 同步执行（用于 Dart 控制台应用）
final result = spec.execute();
```

## 可用操作

```dart
PipelineSpec()
  .input(path)              // 从文件加载
  .inputBuffer(bytes)       // 从内存加载
  
  // 重采样
  .resize(0.5)              // 按比例缩放
  .thumbnail(200)           // 创建缩略图（宽度）
  .rotate(90)               // 旋转角度
  
  // 几何变换
  .crop(0, 0, 200, 200)     // left, top, width, height
  .smartCrop(300, 300)      // 智能裁剪到尺寸
  .flipHorizontal()         // 水平镜像
  .flipVertical()           // 垂直翻转
  
  // 卷积
  .blur(2.0)                // 高斯模糊 (sigma)
  .sharpen()                // 锐化
  
  // 颜色
  .brightness(1.2)          // 调整亮度
  .contrast(1.3)            // 调整对比度
  .grayscale()              // 转换为灰度
  .invert()                 // 反色
  
  // 其他
  .autoRotate()             // 基于 EXIF 旋转
  
  // 输出
  .outputJpeg(85)           // JPEG 质量
  .outputPng(6)             // PNG 压缩
  .outputWebp()             // WebP
```

## 完整示例

```dart
import 'package:flutter/material.dart';
import 'package:libvips_ffi/libvips_ffi.dart';

class ImageProcessor extends StatefulWidget {
  @override
  _ImageProcessorState createState() => _ImageProcessorState();
}

class _ImageProcessorState extends State<ImageProcessor> {
  Uint8List? processedImage;
  bool isProcessing = false;

  Future<void> processImage(String path) async {
    setState(() => isProcessing = true);
    
    try {
      final spec = PipelineSpec()
        .input(path)
        .thumbnail(400)
        .outputJpeg(85);
      
      final result = await VipsPipelineCompute.execute(spec);
      setState(() => processedImage = result);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('错误: $e')),
      );
    } finally {
      setState(() => isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isProcessing)
          CircularProgressIndicator()
        else if (processedImage != null)
          Image.memory(processedImage!),
        ElevatedButton(
          onPressed: () => processImage('/path/to/image.jpg'),
          child: Text('处理图像'),
        ),
      ],
    );
  }
}
```

## 批量处理

并发处理多张图像：

```dart
Future<List<Uint8List>> processImages(List<String> paths) async {
  return Future.wait(
    paths.map((path) => VipsPipelineCompute.execute(
      PipelineSpec()
        .input(path)
        .thumbnail(200)
        .outputJpeg(80),
    )),
  );
}
```

## 对比：VipsPipeline vs PipelineSpec

| 特性 | VipsPipeline | PipelineSpec |
|------|--------------|--------------|
| 跨 isolate | ❌ | ✅ |
| 立即执行 | ✅ | ❌ (延迟) |
| 直接图像访问 | ✅ | ❌ |
| 可序列化 | ❌ | ✅ |
| 使用场景 | 单 isolate, 同步 | 多 isolate, 异步 |

## 何时使用什么

| 场景 | API |
|------|-----|
| Flutter UI 线程 | `PipelineSpec` + `VipsPipelineCompute` |
| Dart 控制台应用 | `VipsPipeline` 或 `PipelineSpec.execute()` |
| 快速单次操作 | `VipsPipeline` |
| 复杂工作流 | `PipelineSpec` + `VipsPipelineCompute` |

## 性能提示

1. **处理一次，多次显示**：缓存处理结果
2. **先调整大小**：在应用效果前先缩放
3. **使用缩略图**：预览时使用 `thumbnail()` 而非 `resize()`
4. **合理批处理**：不要创建太多并发 isolate
