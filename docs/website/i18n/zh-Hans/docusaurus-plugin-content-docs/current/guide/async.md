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

## 解决方案：VipsPipelineCompute

`VipsPipelineCompute` 使用 Flutter 的 `compute()` 函数在单独的 isolate 中运行图像处理。

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

## PipelineSpec

`PipelineSpec` 是可传递到 isolate 的可序列化 pipeline 表示。

### 创建 Spec

```dart
// 从文件
final spec = PipelineSpec.fromFile('/path/to/image.jpg');

// 从字节
final spec = PipelineSpec.fromBuffer(imageBytes);
```

### 添加操作

```dart
final spec = PipelineSpec.fromFile('input.jpg')
  .resize(width: 800)
  .gaussianBlur(sigma: 1.5)
  .brightness(factor: 1.1)
  .toJpeg(quality: 85);
```

### 运行 Spec

```dart
// 异步（推荐用于 Flutter）
final result = await VipsPipelineCompute.run(spec);

// 同步（用于 Dart 控制台应用）
final result = spec.execute();
```

## 完整示例

```dart
import 'dart:io';
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
      final result = await VipsPipelineCompute.run(
        PipelineSpec.fromFile(path)
          .thumbnail(width: 400, height: 400)
          .toJpeg(quality: 85),
      );
      
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
    paths.map((path) => VipsPipelineCompute.run(
      PipelineSpec.fromFile(path)
        .thumbnail(width: 200, height: 200)
        .toJpeg(quality: 80),
    )),
  );
}
```

## 何时使用什么

| 场景 | API |
|------|-----|
| Flutter UI 线程 | `VipsPipelineCompute` |
| Dart 控制台应用 | `VipsPipeline` 或 `PipelineSpec.execute()` |
| 快速单次操作 | `VipsPipeline` |
| 复杂工作流 | `PipelineSpec` + `VipsPipelineCompute` |

## 性能提示

1. **处理一次，多次显示**：缓存处理结果
2. **先调整大小**：在应用效果前先缩放
3. **使用缩略图**：预览时使用 `thumbnail()` 而非 `resize()`
4. **合理批处理**：不要创建太多并发 isolate
