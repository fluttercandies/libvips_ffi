---
sidebar_position: 5
---

# libvips_ffi_desktop

桌面平台支持的元包 (macOS, Windows, Linux)。

## 安装

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0+8.16.0
  libvips_ffi_desktop: ^0.1.0+8.16.0
```

## 包含内容

此包自动包含正确的平台特定包：

| 平台 | 包 | libvips 版本 |
|------|-----|--------------|
| macOS | libvips_ffi_macos | 8.17.0 |
| Windows | libvips_ffi_windows | 8.17.3 |
| Linux | libvips_ffi_linux | (系统) |

## 使用

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

## 单独平台包

如果只需要特定平台，使用单独的包：

### 仅 macOS

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0+8.16.0
  libvips_ffi_macos: ^0.1.0+8.17.0
```

### 仅 Windows

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0+8.16.0
  libvips_ffi_windows: ^0.1.0+8.17.3
```

### 仅 Linux

```yaml
dependencies:
  libvips_ffi_api: ^0.1.0+8.16.0
  libvips_ffi_linux: ^0.1.0+8.16.0
```

## 平台说明

### macOS

- 捆绑 arm64 和 x86_64 库
- 最低 macOS 10.15 (Catalina)
- 库已签名和公证

### Windows

- 捆绑 DLL 在 `windows/dll/`
- 无需额外运行时
- 仅 x64（不支持 x86）

### Linux

- 目前使用系统安装的 libvips
- 通过包管理器安装：

```bash
# Ubuntu/Debian
sudo apt install libvips-dev

# Fedora
sudo dnf install vips-devel

# Arch
sudo pacman -S libvips
```
