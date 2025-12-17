---
sidebar_position: 4
---

# Async Processing

Learn how to process images asynchronously in Flutter applications.

## The Problem

Image processing is CPU-intensive. Running it on the main thread will:
- Block the UI, causing janky animations
- Trigger ANR (Application Not Responding) on Android
- Make the app feel unresponsive

## The Solution: VipsPipelineCompute

`VipsPipelineCompute` runs image processing in a separate isolate using Flutter's `compute()` function.

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

`PipelineSpec` is a serializable representation of a pipeline that can be passed to an isolate.

### Creating a Spec

```dart
// From file
final spec = PipelineSpec.fromFile('/path/to/image.jpg');

// From bytes
final spec = PipelineSpec.fromBuffer(imageBytes);
```

### Adding Operations

```dart
final spec = PipelineSpec.fromFile('input.jpg')
  .resize(width: 800)
  .gaussianBlur(sigma: 1.5)
  .brightness(factor: 1.1)
  .toJpeg(quality: 85);
```

### Running the Spec

```dart
// Async (recommended for Flutter)
final result = await VipsPipelineCompute.run(spec);

// Sync (for Dart console apps)
final result = spec.execute();
```

## Complete Example

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
        SnackBar(content: Text('Error: $e')),
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
          child: Text('Process Image'),
        ),
      ],
    );
  }
}
```

## Batch Processing

Process multiple images concurrently:

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

## When to Use What

| Scenario | API |
|----------|-----|
| Flutter UI thread | `VipsPipelineCompute` |
| Dart console app | `VipsPipeline` or `PipelineSpec.execute()` |
| Quick single operation | `VipsPipeline` |
| Complex workflow | `PipelineSpec` + `VipsPipelineCompute` |

## Performance Tips

1. **Process once, display many**: Cache processed results
2. **Right-size first**: Resize before applying effects
3. **Use thumbnails**: For previews, use `thumbnail()` instead of `resize()`
4. **Batch wisely**: Don't spawn too many concurrent isolates
