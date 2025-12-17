# libvips_ffi_core

Pure Dart FFI bindings for [libvips](https://www.libvips.org/) image processing library. No Flutter dependency.

📖 **[Documentation](https://fluttercandies.github.io/libvips_ffi/)** | 📖 **[中文文档](https://fluttercandies.github.io/libvips_ffi/zh-Hans/)**

## Features

- Pure Dart implementation (no Flutter required)
- Image loading/saving (JPEG, PNG, WebP, TIFF, etc.)
- Image transformations (resize, rotate, crop, flip)
- Image filters (blur, sharpen, invert)
- Color space conversions
- Uses VarArgs for variadic function calls (Dart 3.0+)

## Requirements

- Dart SDK >= 3.5.0
- libvips library installed on the system

## Usage

```dart
import 'dart:ffi';
import 'package:libvips_ffi_core/libvips_ffi_core.dart';

void main() {
  // Initialize with system library
  initVipsSystem();
  
  // Or initialize with a pre-loaded library
  // initVipsWithLibrary(DynamicLibrary.open('libvips.dylib'));
  
  // Load and process image with VipsPipeline (from libvips_ffi_api)
  final pipeline = VipsPipeline.fromFile('input.jpg');
  pipeline.resize(0.5);
  pipeline.toFile('output.jpg');
  pipeline.dispose();
  
  // Cleanup
  shutdownVips();
}
```

## Related Packages

- [libvips_ffi](https://pub.dev/packages/libvips_ffi) - Flutter mobile support
- [libvips_ffi_desktop](https://pub.dev/packages/libvips_ffi_desktop) - Desktop meta package
- [libvips_ffi_system](https://pub.dev/packages/libvips_ffi_system) - System package manager loader
