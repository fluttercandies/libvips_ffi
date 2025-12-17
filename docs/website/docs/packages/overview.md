---
sidebar_position: 1
---

# Package Overview

libvips_ffi is organized as a monorepo with multiple packages, each serving a specific purpose.

## Package Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Your Application                        │
└─────────────────────────────────────────────────────────────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        ▼                     ▼                     ▼
┌───────────────┐    ┌───────────────┐    ┌───────────────┐
│  libvips_ffi  │    │libvips_ffi_   │    │libvips_ffi_   │
│   (Flutter)   │    │   desktop     │    │   system      │
└───────────────┘    └───────────────┘    └───────────────┘
        │                     │                     │
        └─────────────────────┼─────────────────────┘
                              ▼
                    ┌───────────────┐
                    │libvips_ffi_api│
                    └───────────────┘
                              │
                              ▼
                    ┌───────────────┐
                    │libvips_ffi_   │
                    │     core      │
                    └───────────────┘
```

## Package Summary

| Package | Type | Description |
|---------|------|-------------|
| **libvips_ffi** | Flutter Plugin | Main package for Android/iOS with bundled libraries |
| **libvips_ffi_api** | Dart | High-level Pipeline API |
| **libvips_ffi_core** | Dart | Low-level FFI bindings |
| **libvips_ffi_desktop** | Flutter Plugin | Meta-package for all desktop platforms |
| **libvips_ffi_macos** | Flutter Plugin | macOS with bundled libraries |
| **libvips_ffi_windows** | Flutter Plugin | Windows with bundled libraries |
| **libvips_ffi_linux** | Flutter Plugin | Linux with bundled libraries |
| **libvips_ffi_loader** | Dart | Dynamic library loader |
| **libvips_ffi_system** | Dart | System library finder |

## Choosing the Right Package

### Flutter Mobile (Android/iOS)

```yaml
dependencies:
  libvips_ffi: ^0.1.0
```

### Flutter Desktop (All Platforms)

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0
  libvips_ffi_desktop: ^0.1.0
```

### Flutter Desktop (Specific Platform)

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0
  libvips_ffi_macos: ^0.1.0+8.17.0  # macOS only
```

### Pure Dart with System libvips

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0
  libvips_ffi_system: ^0.1.0
```

### Pure Dart with Custom Library Path

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0
  libvips_ffi_loader: ^0.1.0
```

## Version Scheme

Packages follow semantic versioning with libvips version suffix:

```
<package_version>+<libvips_version>
```

Example: `0.1.0+8.17.0` means:
- Package version: 0.1.0
- Bundled libvips version: 8.17.0

## libvips Versions

Different platforms may bundle different libvips versions:

| Platform | libvips Version |
|----------|-----------------|
| Android | 8.16.0 |
| iOS | 8.16.0 |
| macOS | 8.17.0 |
| Windows | 8.17.3 |
| Linux | (uses system) |

## Next Steps

- [libvips_ffi](./libvips_ffi) - Mobile package details
- [libvips_ffi_api](./libvips_ffi_api) - API package details
- [libvips_ffi_core](./libvips_ffi_core) - Core bindings details
