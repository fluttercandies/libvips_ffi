---
sidebar_position: 1
---

# 安装

## Flutter (移动端)

对于 Android 和 iOS 应用，添加 `libvips_ffi` 依赖：

```yaml
dependencies:
  libvips_ffi: ^0.1.0
```

### 平台要求

| 平台 | 最低版本 | 架构 |
|------|----------|------|
| Android | API 21 | arm64-v8a, armeabi-v7a, x86_64 |
| iOS | 12.0 | arm64 (设备), arm64 (模拟器) |

:::note
不支持 iOS x86_64 模拟器 (Intel Mac)。请在 Apple Silicon Mac 上使用 arm64 模拟器。
:::

## Flutter (桌面端)

对于 macOS、Windows 和 Linux，添加 `libvips_ffi_desktop`：

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0
  libvips_ffi_desktop: ^0.1.0
```

此元包会自动包含正确的平台特定包。

### 单独平台包

如果只需要特定平台：

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0
  libvips_ffi_macos: ^0.1.0+8.17.0    # 仅 macOS
  libvips_ffi_windows: ^0.1.0+8.17.3  # 仅 Windows
  libvips_ffi_linux: ^0.1.0+8.16.0    # 仅 Linux
```

## 纯 Dart

对于非 Flutter 的 Dart 应用：

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0
  libvips_ffi_system: ^0.1.0  # 使用系统安装的 libvips
```

### 在系统上安装 libvips

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

## 下一步

- [快速开始](./quick-start) - 你的第一个图像处理
- [Pipeline API](../guide/pipeline) - 学习 Pipeline API
