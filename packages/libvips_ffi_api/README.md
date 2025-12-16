# libvips_ffi_api

High-level Dart API for libvips image processing library.

## Features

- **Pipeline-style API**: Chainable operations inspired by sharp (Node.js)
- **High performance**: Internal VipsImage handling, encoding only on output
- **Complete coverage**: Designed to cover all 300+ libvips operations
- **Flutter compatible**: Works with Flutter's compute/isolate

## Usage

```dart
import 'package:libvips_ffi_api/libvips_ffi_api.dart';

// Chain operations
final result = VipsPipeline.fromFile('input.jpg')
    .resize(0.5)
    .blur(1.0)
    .sharpen()
    .toBuffer(format: '.jpg');

// Or write directly to file
VipsPipeline.fromFile('input.jpg')
    .thumbnail(200)
    .toFile('thumb.jpg');
```

## Note

This package does not handle library loading. Use with:
- `libvips_ffi` (Flutter mobile)
- `libvips_ffi_macos/windows/linux` (Desktop)
- `libvips_ffi_loader` (Dynamic download)
- `libvips_ffi_system` (System package manager)
