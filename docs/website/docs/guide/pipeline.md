---
sidebar_position: 1
---

# Pipeline API

The Pipeline API is the primary way to process images with libvips_ffi.

## Overview

`VipsPipeline` provides a fluent, chainable interface for image operations:

```dart
final result = VipsPipeline.fromFile('input.jpg')
  .operation1()
  .operation2()
  .operation3()
  .toFormat();
```

## Creating a Pipeline

### From File

```dart
final pipeline = VipsPipeline.fromFile('/path/to/image.jpg');
```

### From Memory

```dart
final bytes = await File('image.jpg').readAsBytes();
final pipeline = VipsPipeline.fromBuffer(bytes);
```

### From Another Image

```dart
final source = VipsPipeline.fromFile('input.jpg');
final copy = VipsPipeline.fromImage(source.image);
```

## Output Methods

### To Bytes

```dart
// JPEG
final jpegBytes = pipeline.toJpeg(quality: 85);

// PNG
final pngBytes = pipeline.toPng(compression: 6);

// WebP
final webpBytes = pipeline.toWebp(quality: 90);

// Auto-detect from extension
final bytes = pipeline.toBuffer(format: 'jpg');
```

### To File

```dart
pipeline.toFile('output.jpg');
```

## Common Operations

### Resizing

```dart
// By width (maintain aspect ratio)
pipeline.resize(width: 800)

// By height (maintain aspect ratio)
pipeline.resize(height: 600)

// By both (may change aspect ratio)
pipeline.resize(width: 800, height: 600)

// By scale factor
pipeline.resize(scale: 0.5)  // 50% size
```

### Thumbnail

Smart cropping for thumbnails:

```dart
pipeline.thumbnail(
  width: 200,
  height: 200,
  crop: VipsCrop.attention,  // Focus on interesting areas
)
```

### Cropping

```dart
// Extract a region
pipeline.crop(x: 100, y: 100, width: 400, height: 300)

// Smart crop
pipeline.smartCrop(width: 400, height: 300, interesting: VipsInteresting.attention)
```

### Rotation

```dart
// Rotate by angle
pipeline.rotate(angle: 90)

// Auto-rotate based on EXIF
pipeline.autoRotate()
```

### Color Adjustments

```dart
pipeline
  .brightness(factor: 1.2)   // 20% brighter
  .contrast(factor: 1.1)     // 10% more contrast
  .saturation(factor: 0.8)   // 20% less saturation
  .grayscale()               // Convert to grayscale
```

### Filters

```dart
pipeline
  .gaussianBlur(sigma: 2.0)  // Gaussian blur
  .sharpen()                  // Sharpen
  .invert()                   // Invert colors
```

## Error Handling

```dart
try {
  final result = VipsPipeline.fromFile('input.jpg')
    .resize(width: 800)
    .toJpeg();
} on VipsApiException catch (e) {
  print('libvips error: ${e.message}');
}
```

## Memory Management

The Pipeline manages memory automatically. The internal VipsImage is released when:

1. The pipeline goes out of scope
2. You call `dispose()` explicitly

```dart
final pipeline = VipsPipeline.fromFile('input.jpg');
try {
  // Use pipeline
  final result = pipeline.resize(width: 800).toJpeg();
  return result;
} finally {
  pipeline.dispose();  // Optional but recommended for large images
}
```

## Next Steps

- [Operations Reference](./operations) - All available operations
- [Output Formats](./formats) - Supported output formats
- [Async Processing](./async) - Processing in isolates
