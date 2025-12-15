# libvips_ffi_macos

Pre-compiled libvips for macOS. Part of the libvips_ffi package family.

## Features

- Pre-compiled libvips binaries for macOS
- Supports both Intel (x64) and Apple Silicon (arm64)
- Automatic architecture detection

## Usage

```dart
import 'package:libvips_ffi_macos/libvips_ffi_macos.dart';

void main() {
  initVipsMacos();
  
  // Use libvips...
  
  shutdownVips();
}
```

## Pre-compiled Libraries

This package includes pre-compiled libvips binaries for:

- **arm64** (Apple Silicon)
- **x86_64** (Intel)

The appropriate architecture is automatically selected at build time.

## Related Packages

- [libvips_ffi_core](https://pub.dev/packages/libvips_ffi_core) - Core FFI bindings
- [libvips_ffi_desktop](https://pub.dev/packages/libvips_ffi_desktop) - Desktop meta package
