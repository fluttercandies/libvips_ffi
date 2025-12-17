---
sidebar_position: 5
---

# libvips_ffi_desktop

Meta-package for desktop platform support (macOS, Windows, Linux).

## Installation

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0+8.16.0
  libvips_ffi_desktop: ^0.1.0+8.16.0
```

## What's Included

This package automatically includes the correct platform-specific package:

| Platform | Package | libvips Version |
|----------|---------|-----------------|
| macOS | libvips_ffi_macos | 8.17.0 |
| Windows | libvips_ffi_windows | 8.17.3 |
| Linux | libvips_ffi_linux | (system) |

## Usage

```dart
import 'package:libvips_ffi_api/libvips_ffi_api.dart';

void main() {
  VipsCore.init();
  
  final result = VipsPipeline.fromFile('input.jpg')
    .resize(width: 800)
    .toJpeg(quality: 85);
  
  File('output.jpg').writeAsBytesSync(result);
  
  VipsCore.shutdown();
}
```

## Individual Platform Packages

If you only need specific platforms, use the individual packages:

### macOS Only

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0+8.16.0
  libvips_ffi_macos: ^0.1.0+8.17.0
```

### Windows Only

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0+8.16.0
  libvips_ffi_windows: ^0.1.0+8.17.3
```

### Linux Only

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0+8.16.0
  libvips_ffi_linux: ^0.1.0+8.16.0
```

## Platform Notes

### macOS

- Bundled libraries for arm64 and x86_64
- Minimum macOS 10.15 (Catalina)
- Libraries are code-signed and notarized

### Windows

- Bundled DLLs in `windows/dll/`
- No additional runtime required
- x64 only (no x86 support)

### Linux

- Currently uses system-installed libvips
- Install via package manager:

```bash
# Ubuntu/Debian
sudo apt install libvips-dev

# Fedora
sudo dnf install vips-devel

# Arch
sudo pacman -S libvips
```
