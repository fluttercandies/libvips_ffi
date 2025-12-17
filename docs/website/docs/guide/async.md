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

Additionally, Dart isolates have a fundamental limitation: **closures cannot be passed between isolates**. This means you cannot send a `VipsPipeline` object to another isolate.

## The Solution: PipelineSpec + VipsPipelineCompute

`PipelineSpec` is a **serializable** representation of image processing operations. It can be safely transferred to any isolate, then executed there.

`VipsPipelineCompute` runs the spec in a separate isolate using Flutter's `compute()` function.

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

`PipelineSpec` is a serializable description of operations that solves the isolate closure limitation.

### Creating a Spec

```dart
// From file path
final spec = PipelineSpec()
  .input('/path/to/image.jpg');

// From bytes (Uint8List)
final spec = PipelineSpec()
  .inputBuffer(imageBytes);
```

### Adding Operations

Operations are chained fluently:

```dart
final spec = PipelineSpec()
  .input('input.jpg')
  .resize(0.5)           // Scale to 50%
  .blur(1.5)             // Gaussian blur
  .brightness(1.1)       // +10% brightness
  .outputJpeg(85);       // Output as JPEG quality 85
```

### Output Formats

```dart
// JPEG with quality (default: 75)
spec.outputJpeg(85)

// PNG with compression (default: 6)
spec.outputPng(9)

// WebP
spec.outputWebp(quality: 80, lossless: false)
```

### Running the Spec

```dart
// Async in isolate (recommended for Flutter)
final result = await VipsPipelineCompute.execute(spec);

// Sync execution (for Dart console apps)
final result = spec.execute();
```

## Available Operations

```dart
PipelineSpec()
  .input(path)              // Load from file
  .inputBuffer(bytes)       // Load from memory
  
  // Resample
  .resize(0.5)              // Scale by factor
  .thumbnail(200)           // Create thumbnail (width)
  .rotate(90)               // Rotate degrees
  
  // Geometry
  .crop(0, 0, 200, 200)     // left, top, width, height
  .smartCrop(300, 300)      // Smart crop to size
  .flipHorizontal()         // Mirror horizontally
  .flipVertical()           // Flip vertically
  
  // Convolution
  .blur(2.0)                // Gaussian blur (sigma)
  .sharpen()                // Sharpen
  
  // Color
  .brightness(1.2)          // Adjust brightness
  .contrast(1.3)            // Adjust contrast
  .grayscale()              // Convert to grayscale
  .invert()                 // Invert colors
  
  // Other
  .autoRotate()             // EXIF-based rotation
  
  // Output
  .outputJpeg(85)           // JPEG quality
  .outputPng(6)             // PNG compression
  .outputWebp()             // WebP
```

## Complete Example

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
    paths.map((path) => VipsPipelineCompute.execute(
      PipelineSpec()
        .input(path)
        .thumbnail(200)
        .outputJpeg(80),
    )),
  );
}
```

## Comparison: VipsPipeline vs PipelineSpec

| Feature | VipsPipeline | PipelineSpec |
|---------|--------------|--------------|
| Cross-isolate | ❌ | ✅ |
| Immediate execution | ✅ | ❌ (deferred) |
| Direct image access | ✅ | ❌ |
| Serializable | ❌ | ✅ |
| Use case | Single isolate, sync | Multi-isolate, async |

## When to Use What

| Scenario | API |
|----------|-----|
| Flutter UI thread | `PipelineSpec` + `VipsPipelineCompute` |
| Dart console app | `VipsPipeline` or `PipelineSpec.execute()` |
| Quick single operation | `VipsPipeline` |
| Complex workflow | `PipelineSpec` + `VipsPipelineCompute` |

## Performance Tips

1. **Process once, display many**: Cache processed results
2. **Right-size first**: Resize before applying effects
3. **Use thumbnails**: For previews, use `thumbnail()` instead of `resize()`
4. **Batch wisely**: Don't spawn too many concurrent isolates
