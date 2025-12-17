---
sidebar_position: 3
---

# libvips_ffi_api

High-level Dart API for libvips image processing.

## Installation

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0+8.16.0
```

:::note
This package does not include libvips binaries. You also need a loader package (`libvips_ffi`, `libvips_ffi_desktop`, or `libvips_ffi_system`).
:::

## Features

- `VipsPipeline` - Fluent chainable API
- `PipelineSpec` - Serializable pipeline definitions
- Complete FFI bindings for libvips operations
- Type-safe operation parameters

## Core Classes

### VipsPipeline

The main class for image processing with a fluent API.

```dart
final result = VipsPipeline.fromFile('input.jpg')
  .resize(width: 800)
  .gaussianBlur(sigma: 1.5)
  .toJpeg(quality: 85);
```

### PipelineSpec

A serializable specification for pipeline operations.

```dart
final spec = PipelineSpec.fromFile('input.jpg')
  .resize(width: 800)
  .toJpeg(quality: 85);

// Execute synchronously
final result = spec.execute();

// Or save for later / send to isolate
final json = spec.toJson();
```

### VipsImg

Low-level image wrapper for direct FFI operations.

```dart
final img = VipsImg.fromFile('input.jpg');
try {
  // Direct access to image properties
  print('Width: ${img.width}');
  print('Height: ${img.height}');
  print('Bands: ${img.bands}');
} finally {
  img.dispose();
}
```

## Bindings

The package includes complete FFI bindings organized by category:

| Module | Operations |
|--------|------------|
| `ArithmeticBindings` | add, subtract, multiply, divide, clamp, etc. |
| `ColourBindings` | colourspace, icc_import, icc_export, etc. |
| `ConversionBindings` | cast, flip, rot, embed, extract, etc. |
| `ConvolutionBindings` | conv, sharpen, gaussblur, etc. |
| `CreateBindings` | black, xyz, text, gaussnoise, etc. |
| `DrawBindings` | draw_rect, draw_circle, draw_line, etc. |
| `IoBindings` | load, save (jpeg, png, webp, etc.) |
| `ResampleBindings` | resize, thumbnail, affine, etc. |

## Extension Methods

Operations are organized as extension methods on `VipsPipeline`:

```dart
// Arithmetic extensions
pipeline.add(value)
pipeline.multiply(factor)
pipeline.clamp(min, max)

// Colour extensions
pipeline.grayscale()
pipeline.colourspace(VipsInterpretation.sRGB)

// Geometry extensions
pipeline.resize(width: 800)
pipeline.rotate(angle: 45)
pipeline.crop(x: 0, y: 0, width: 100, height: 100)

// Filter extensions
pipeline.gaussianBlur(sigma: 2.0)
pipeline.sharpen()
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
