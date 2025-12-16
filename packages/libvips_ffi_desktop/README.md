# libvips_ffi_desktop

Meta package for libvips_ffi desktop support (macOS, Windows, Linux).

## Features

- Unified API for all desktop platforms
- Automatic platform detection
- Re-exports core functionality

## Usage

```dart
import 'package:libvips_ffi_desktop/libvips_ffi_desktop.dart';

void main() {
  initVipsDesktop();
  
  final pipeline = VipsPipeline.fromFile('input.jpg');
  pipeline.resize(0.5);
  pipeline.toFile('output.jpg');
  pipeline.dispose();
  
  shutdownVips();
}
```

## Related Packages

- [libvips_ffi_core](https://pub.dev/packages/libvips_ffi_core) - Core FFI bindings
- [libvips_ffi_macos](https://pub.dev/packages/libvips_ffi_macos) - macOS support
- [libvips_ffi_windows](https://pub.dev/packages/libvips_ffi_windows) - Windows support
- [libvips_ffi_linux](https://pub.dev/packages/libvips_ffi_linux) - Linux support
