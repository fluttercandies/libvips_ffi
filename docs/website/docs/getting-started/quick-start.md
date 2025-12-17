---
sidebar_position: 2
---

# Quick Start

Learn to process your first image with libvips_ffi.

## Initialize libvips

Before using any libvips functions, you must initialize the library:

```dart
import 'package:libvips_ffi/libvips_ffi.dart';

void main() {
  // Initialize libvips
  VipsCore.init();
  
  // Your image processing code here
  
  // Cleanup when done
  VipsCore.shutdown();
}
```

## Basic Image Processing

### Load and Save

```dart
// Load from file
final pipeline = VipsPipeline.fromFile('input.jpg');

// Process and save to bytes
final bytes = pipeline.toJpeg(quality: 85);

// Write to file
File('output.jpg').writeAsBytesSync(bytes);
```

### Resize

```dart
final result = VipsPipeline.fromFile('input.jpg')
  .resize(width: 800)  // Resize to 800px width, maintain aspect ratio
  .toJpeg();
```

### Thumbnail

```dart
// Create a 200x200 thumbnail with smart cropping
final result = VipsPipeline.fromFile('input.jpg')
  .thumbnail(width: 200, height: 200, crop: VipsCrop.attention)
  .toJpeg();
```

### Apply Effects

```dart
final result = VipsPipeline.fromFile('input.jpg')
  .gaussianBlur(sigma: 2.0)  // Blur
  .sharpen()                  // Sharpen
  .grayscale()               // Convert to grayscale
  .toJpeg();
```

## Chaining Operations

The Pipeline API supports method chaining for complex transformations:

```dart
final result = VipsPipeline.fromFile('input.jpg')
  .autoRotate()                    // Fix EXIF orientation
  .resize(width: 1920)             // Resize to 1920px width
  .crop(x: 100, y: 100, width: 800, height: 600)  // Crop region
  .rotate(angle: 45)               // Rotate 45 degrees
  .brightness(factor: 1.2)         // Increase brightness
  .contrast(factor: 1.1)           // Increase contrast
  .gaussianBlur(sigma: 0.5)        // Slight blur
  .toWebp(quality: 90);            // Export as WebP
```

## Async Processing

For Flutter applications, use `VipsPipelineCompute` to process images in an isolate:

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

## Next Steps

- [Pipeline API](../guide/pipeline) - Deep dive into the Pipeline API
- [Output Formats](../guide/formats) - Learn about supported formats
- [Operations](../guide/operations) - All available operations
