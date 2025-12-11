# libvips_ffi

Flutter/Dart FFI bindings for [libvips](https://www.libvips.org/) - a fast, multi-threaded image processing library.

[中文文档](README_CN.md)

## Features

- Image loading/saving (JPEG, PNG, WebP, TIFF, GIF, etc.)
- Image transformations (resize, rotate, crop, flip)
- Image filters (blur, sharpen, invert, gamma)
- Color space conversions
- Smart crop and gravity
- High performance with multi-threading support

## Packages

This project uses [melos](https://melos.invertase.dev/) for multi-package management.

### Core Package

| Package | Version | Description |
|---------|---------|-------------|
| [libvips_ffi_core](packages/libvips_ffi_core/) | 0.1.0 | Pure Dart FFI bindings (no Flutter dependency) |

### Platform Packages

| Package | Version | Description |
|---------|---------|-------------|
| [libvips_ffi](packages/libvips_ffi/) | 0.0.1+8.16.0 | Flutter mobile (Android/iOS) |
| [libvips_ffi_macos](packages/libvips_ffi_macos/) | 0.1.0+8.16.0 | Pre-compiled for macOS |
| [libvips_ffi_windows](packages/libvips_ffi_windows/) | 0.1.0+8.16.0 | Pre-compiled for Windows |
| [libvips_ffi_linux](packages/libvips_ffi_linux/) | 0.1.0+8.16.0 | Pre-compiled for Linux |
| [libvips_ffi_desktop](packages/libvips_ffi_desktop/) | 0.1.0 | Desktop meta package |

### Utility Packages

| Package | Version | Description |
|---------|---------|-------------|
| [libvips_ffi_system](packages/libvips_ffi_system/) | 0.1.0 | System package manager loader (Homebrew, apt, etc.) |
| [libvips_ffi_loader](packages/libvips_ffi_loader/) | 0.1.0 | Dynamic library downloader |

## Usage

### Flutter Mobile

```yaml
dependencies:
  libvips_ffi: ^0.0.1
```

```dart
import 'package:libvips_ffi/libvips_ffi.dart';

void main() async {
  await initVips();
  
  final image = VipsImageWrapper.fromFile('input.jpg');
  final resized = image.resize(0.5);
  resized.writeToFile('output.jpg');
  
  resized.dispose();
  image.dispose();
  shutdownVips();
}
```

### Desktop with System Library

```yaml
dependencies:
  libvips_ffi_core: ^0.1.0
  libvips_ffi_system: ^0.1.0
```

```dart
import 'package:libvips_ffi_core/libvips_ffi_core.dart';
import 'package:libvips_ffi_system/libvips_ffi_system.dart';

void main() async {
  await initVipsSystemAsync();
  
  final image = VipsImageWrapper.fromFile('input.jpg');
  final resized = image.resize(0.5);
  resized.writeToFile('output.jpg');
  
  resized.dispose();
  image.dispose();
  shutdownVips();
}
```

### Desktop with Pre-compiled Library

```yaml
dependencies:
  libvips_ffi_desktop: ^0.1.0
```

```dart
import 'package:libvips_ffi_desktop/libvips_ffi_desktop.dart';

void main() {
  initVipsDesktop();
  
  // Use libvips...
  
  shutdownVips();
}
```

## Version Numbering

- **Packages with pre-compiled binaries**: `x.y.z+libvips_version`
  - Example: `0.1.0+8.16.0` means package version 0.1.0 with libvips 8.16.0
- **Pure Dart packages**: `x.y.z`

## Requirements

- Dart SDK >= 3.5.0
- Flutter >= 3.0.0 (for Flutter packages)

## Development

```bash
# Install melos
dart pub global activate melos

# Bootstrap all packages
melos bootstrap

# Run analysis
melos analyze

# Run tests
melos test
```

## License

LGPL-2.1 - see [LICENSE](LICENSE) for details.

## Links

- [libvips official website](https://www.libvips.org/)
- [libvips GitHub](https://github.com/libvips/libvips)
- [Dart FFI documentation](https://dart.dev/guides/libraries/c-interop)
