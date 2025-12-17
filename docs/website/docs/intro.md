---
sidebar_position: 1
slug: /
---

# Introduction

**libvips_ffi** is a high-performance image processing library for Flutter and Dart, powered by [libvips](https://www.libvips.org/).

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

void main() async {
  // Initialize libvips
  VipsCore.init();
  
  // Process an image using Pipeline
  final result = VipsPipeline.fromFile('input.jpg')
    .resize(width: 800)
    .gaussianBlur(sigma: 1.5)
    .rotate(angle: 90)
    .toJpeg(quality: 85);
  
  // Save to file
  File('output.jpg').writeAsBytesSync(result);
  
  // Cleanup
  VipsCore.shutdown();
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
