---
sidebar_position: 2
---

# libvips_ffi

The main Flutter plugin for Android and iOS.

## Installation

```yaml
dependencies:
  libvips_ffi: ^0.1.0+8.16.0
```

## Features

- Bundled libvips 8.16.0 for Android and iOS
- Flutter-specific APIs (`VipsPipelineCompute`)
- Automatic library loading
- Platform-specific optimizations

## Supported Platforms

| Platform | Architecture | Notes |
|----------|--------------|-------|
| Android | arm64-v8a | 64-bit ARM |
| Android | armeabi-v7a | 32-bit ARM |
| Android | x86_64 | Emulator |
| iOS | arm64 | Device |
| iOS | arm64 (simulator) | Apple Silicon Mac |

:::warning
iOS x86_64 simulator (Intel Mac) is not supported.
:::

## Usage

### Sync API (VipsPipeline)

```dart
import 'package:libvips_ffi/libvips_ffi.dart';

void main() {
  VipsCore.init();
  
  final result = VipsPipeline.fromFile('input.jpg')
    .resize(width: 800)
    .toJpeg(quality: 85);
  
  File('output.jpg').writeAsBytesSync(result);
  
  VipsCore.shutdown();
}
```

### Async API (VipsPipelineCompute)

```dart
import 'package:libvips_ffi/libvips_ffi.dart';

Future<Uint8List> processImage(String path) async {
  return await VipsPipelineCompute.run(
    PipelineSpec.fromFile(path)
      .resize(width: 800)
      .toJpeg(quality: 85),
  );
}
```

## Android Configuration

### Minimum SDK

The library requires Android API 21 (Lollipop) or higher.

```gradle
android {
    defaultConfig {
        minSdkVersion 21
    }
}
```

### ProGuard

No ProGuard configuration is required. The native libraries are automatically included.

### Android 15+ (16KB Page Alignment)

All native libraries are 16KB page-aligned for Android 15+ compatibility.

## iOS Configuration

### Minimum Version

iOS 12.0 or higher is required.

```ruby
# Podfile
platform :ios, '12.0'
```

### Bitcode

Bitcode is disabled by default as libvips does not support it.

## Exported APIs

This package re-exports:
- `libvips_ffi_api` - Pipeline API
- `libvips_ffi_core` - Core FFI bindings

```dart
// All these are available from libvips_ffi
import 'package:libvips_ffi/libvips_ffi.dart';

VipsPipeline        // From libvips_ffi_api
VipsCore            // From libvips_ffi_core
VipsImage           // From libvips_ffi_core
```
