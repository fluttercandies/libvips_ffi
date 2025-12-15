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

## Package Architecture

```text
┌─────────────────────────────────────────────────────────────────┐
│                        Your Application                          │
├─────────────────────────────────────────────────────────────────┤
│  Flutter Mobile    │  Flutter Desktop   │  Pure Dart Desktop    │
│  (Android/iOS)     │  (macOS/Win/Linux) │  (CLI/Server)         │
├────────────────────┼────────────────────┼───────────────────────┤
│  libvips_ffi       │  libvips_ffi       │  libvips_ffi_core     │
│  (includes native) │  + platform pkg    │  + loader choice      │
└────────────────────┴────────────────────┴───────────────────────┘
                              │
              ┌───────────────┼───────────────┐
              ▼               ▼               ▼
      libvips_ffi_macos  libvips_ffi_windows  libvips_ffi_linux
      (pre-compiled)     (pre-compiled)       (pre-compiled)
                              │
                              ▼
                      libvips_ffi_core (Pure Dart FFI)
```

## Packages

This project uses [melos](https://melos.invertase.dev/) for multi-package management.

### Core Package

| Package | Description |
|---------|-------------|
| [libvips_ffi_core](packages/libvips_ffi_core/) | Pure Dart FFI bindings (no Flutter dependency) |

### Platform Packages

| Package | Description |
|---------|-------------|
| [libvips_ffi](packages/libvips_ffi/) | Flutter mobile (Android/iOS) with bundled native libraries |
| [libvips_ffi_macos](packages/libvips_ffi_macos/) | Pre-compiled libvips for macOS (arm64 + x86_64) |
| [libvips_ffi_windows](packages/libvips_ffi_windows/) | Pre-compiled libvips for Windows (x64) |
| [libvips_ffi_linux](packages/libvips_ffi_linux/) | Pre-compiled libvips for Linux (x64) |
| [libvips_ffi_desktop](packages/libvips_ffi_desktop/) | Desktop meta package (auto-selects platform) |

### Utility Packages

| Package | Description |
|---------|-------------|
| [libvips_ffi_system](packages/libvips_ffi_system/) | Load from system package manager (Homebrew, apt, etc.) |
| [libvips_ffi_loader](packages/libvips_ffi_loader/) | Dynamic library downloader with callback support |

## Quick Start by Platform

### Flutter Mobile (Android/iOS) - Recommended

Pre-compiled native libraries are bundled automatically.

```yaml
dependencies:
  libvips_ffi: ^0.0.1
```

```dart
import 'package:libvips_ffi/libvips_ffi.dart';

void main() {
  initVips();
  
  // Sync API (simple operations)
  final image = VipsImageWrapper.fromFile('input.jpg');
  final resized = image.resize(0.5);
  resized.writeToFile('output.jpg');
  resized.dispose();
  image.dispose();
  
  // Async API (recommended for Flutter UI)
  final result = await VipsCompute.resizeFile('input.jpg', 0.5);
  // result.data contains processed image bytes
  
  shutdownVips();
}
```

### Flutter Desktop (macOS/Windows/Linux) - Recommended

Use `libvips_ffi` with platform-specific packages for bundled libraries.

```yaml
dependencies:
  libvips_ffi: ^0.0.1
  libvips_ffi_macos: ^0.1.0   # macOS
  # libvips_ffi_windows: ^0.1.0  # Windows
  # libvips_ffi_linux: ^0.1.0    # Linux
```

```dart
import 'package:libvips_ffi/libvips_ffi.dart';

void main() {
  initVips();  // Auto-detects platform and loads bundled library
  
  // Same API as mobile
  final result = await VipsCompute.resizeFile('input.jpg', 0.5);
  
  shutdownVips();
}
```

### Pure Dart Desktop (CLI/Server)

For non-Flutter Dart applications.

#### Option 1: Use system-installed libvips

```yaml
dependencies:
  libvips_ffi_core: ^0.1.0
```

```dart
import 'package:libvips_ffi_core/libvips_ffi_core.dart';

void main() {
  // Requires: brew install vips (macOS) or apt install libvips-dev (Linux)
  initVipsSystem();
  
  final image = VipsImageWrapper.fromFile('input.jpg');
  final resized = image.resize(0.5);
  resized.writeToFile('output.jpg');
  
  resized.dispose();
  image.dispose();
  shutdownVips();
}
```

#### Option 2: Use pre-compiled libraries

```yaml
dependencies:
  libvips_ffi_desktop: ^0.1.0
```

```dart
import 'package:libvips_ffi_desktop/libvips_ffi_desktop.dart';

void main() {
  initVipsDesktop();  // Auto-selects platform
  // ...
  shutdownVips();
}
```

## Choosing the Right Package

| Scenario | Recommended Package(s) |
|----------|------------------------|
| Flutter mobile app | `libvips_ffi` |
| Flutter desktop app | `libvips_ffi` + `libvips_ffi_<platform>` |
| Dart CLI tool (system libvips) | `libvips_ffi_core` |
| Dart CLI tool (bundled libvips) | `libvips_ffi_desktop` |
| Custom library loading | `libvips_ffi_core` + `libvips_ffi_loader` |

## Sync vs Async API

| API | Use Case | Blocks UI? |
|-----|----------|------------|
| `VipsImageWrapper` (sync) | Simple scripts, CLI tools | Yes |
| `VipsCompute` (async) | Flutter apps, UI-heavy apps | No (runs in isolate) |

```dart
// Sync - blocks until complete
final image = VipsImageWrapper.fromFile('input.jpg');
final resized = image.resize(0.5);

// Async - runs in background isolate
final result = await VipsCompute.resizeFile('input.jpg', 0.5);
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
