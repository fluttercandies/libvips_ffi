---
sidebar_position: 1
slug: /
---

# libvips_ffi

High-performance image processing for Flutter and Dart.

:::warning Disclaimer
This is a **third-party** language binding for libvips, **not an official libvips project**. It is maintained independently by [FlutterCandies](https://github.com/fluttercandies). The libvips team does not provide support for this package. For issues and questions, please use [GitHub Issues](https://github.com/fluttercandies/libvips_ffi/issues).
:::

Powered by [libvips](https://www.libvips.org/).

## Why libvips_ffi?

- **High Performance**: libvips is one of the fastest image processing libraries, using streaming and caching to minimize memory usage
- **Rich Features**: Supports resize, crop, rotate, blur, sharpen, color conversion, and 300+ other operations
- **Cross-Platform**: Works on Android, iOS, macOS, Windows, and Linux
- **Easy to Use**: Pipeline-style chainable API for intuitive image processing
- **Pure Dart FFI**: No platform channels, direct native library calls

## Quick Start

### Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  libvips_ffi: ^0.1.0
```

### Basic Usage

```dart
import 'package:libvips_ffi/libvips_ffi.dart';

void main() {
  // Initialize libvips
  initVips();
  
  // Process an image using Pipeline
  final result = VipsPipeline.fromFile('input.jpg')
    .resize(0.5)        // Scale factor: 0.5 = half size
    .blur(1.5)          // Gaussian blur sigma
    .rotate(90)         // Degrees
    .toJpeg(quality: 85);
  
  // Save to file
  File('output.jpg').writeAsBytesSync(result);
  
  // Cleanup
  shutdownVips();
}
```

## Package Family

libvips_ffi is organized as a monorepo with multiple packages:

| Package | Description |
|---------|-------------|
| [libvips_ffi](packages/libvips_ffi) | Main Flutter plugin (Android/iOS) |
| [libvips_ffi_api](packages/libvips_ffi_api) | High-level Pipeline API |
| [libvips_ffi_core](packages/libvips_ffi_core) | Pure Dart FFI bindings |
| [libvips_ffi_desktop](packages/libvips_ffi_desktop) | Desktop meta-package |
| libvips_ffi_macos | macOS precompiled library |
| libvips_ffi_windows | Windows precompiled library |
| libvips_ffi_linux | Linux precompiled library |

## Next Steps

- [Getting Started](getting-started/installation) - Installation and setup
- [Pipeline API](guide/pipeline) - Learn the Pipeline API
- [Packages Overview](packages/overview) - Understand the package structure
