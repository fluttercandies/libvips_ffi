---
sidebar_position: 1
---

# Installation

## Flutter (Mobile)

For Android and iOS applications, add `libvips_ffi` to your dependencies:

```yaml
dependencies:
  libvips_ffi: ^0.1.0
```

### Platform Requirements

| Platform | Minimum Version | Architectures |
|----------|-----------------|---------------|
| Android | API 21 | arm64-v8a, armeabi-v7a, x86_64 |
| iOS | 12.0 | arm64 (device), arm64 (simulator) |

:::note
iOS x86_64 simulator (Intel Mac) is not supported. Use arm64 simulator on Apple Silicon Mac.
:::

## Flutter (Desktop)

For macOS, Windows, and Linux, add `libvips_ffi_desktop`:

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0
  libvips_ffi_desktop: ^0.1.0
```

This meta-package automatically includes the correct platform-specific package.

### Individual Platform Packages

If you only need specific platforms:

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0
  libvips_ffi_macos: ^0.1.0+8.17.0    # macOS only
  libvips_ffi_windows: ^0.1.0+8.17.3  # Windows only
  libvips_ffi_linux: ^0.1.0+8.16.0    # Linux only
```

## Pure Dart

For non-Flutter Dart applications:

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0
  libvips_ffi_system: ^0.1.0  # Uses system-installed libvips
```

### Install libvips on your system

**macOS (Homebrew):**
```bash
brew install vips
```

**Linux (apt):**
```bash
sudo apt install libvips-dev
```

**Windows (vcpkg):**
```bash
vcpkg install vips
```

## Next Steps

- [Quick Start](./quick-start) - Your first image processing
- [Pipeline API](../guide/pipeline) - Learn the Pipeline API
