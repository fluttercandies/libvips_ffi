# libvips_ffi

[libvips](https://www.libvips.org/) 的 Flutter/Dart FFI 绑定 - 一个快速、多线程的图像处理库。

[English](README.md)

## 功能

- 图像加载/保存 (JPEG, PNG, WebP, TIFF, GIF 等)
- 图像变换 (缩放、旋转、裁剪、翻转)
- 图像滤镜 (模糊、锐化、反色、伽马)
- 色彩空间转换
- 智能裁剪和重力定位
- 多线程支持的高性能处理

## 包结构

本项目使用 [melos](https://melos.invertase.dev/) 进行多包管理。

### 核心包

| 包名 | 版本 | 说明 |
|------|------|------|
| [libvips_ffi_core](packages/libvips_ffi_core/) | 0.1.0 | 纯 Dart FFI 绑定 (无 Flutter 依赖) |

### 平台包

| 包名 | 版本 | 说明 |
|------|------|------|
| [libvips_ffi](packages/libvips_ffi/) | 0.0.1+8.16.0 | Flutter 移动端 (Android/iOS) |
| [libvips_ffi_macos](packages/libvips_ffi_macos/) | 0.1.0+8.16.0 | macOS 预编译包 |
| [libvips_ffi_windows](packages/libvips_ffi_windows/) | 0.1.0+8.16.0 | Windows 预编译包 |
| [libvips_ffi_linux](packages/libvips_ffi_linux/) | 0.1.0+8.16.0 | Linux 预编译包 |
| [libvips_ffi_desktop](packages/libvips_ffi_desktop/) | 0.1.0 | 桌面元包 |

### 工具包

| 包名 | 版本 | 说明 |
|------|------|------|
| [libvips_ffi_system](packages/libvips_ffi_system/) | 0.1.0 | 系统包管理器加载器 (Homebrew, apt 等) |
| [libvips_ffi_loader](packages/libvips_ffi_loader/) | 0.1.0 | 动态库下载器 |

## 使用方法

### Flutter 移动端

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

### 桌面端使用系统库

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

### 桌面端使用预编译库

```yaml
dependencies:
  libvips_ffi_desktop: ^0.1.0
```

```dart
import 'package:libvips_ffi_desktop/libvips_ffi_desktop.dart';

void main() {
  initVipsDesktop();
  
  // 使用 libvips...
  
  shutdownVips();
}
```

## 版本号规则

- **包含预编译二进制的包**: `x.y.z+libvips_version`
  - 例如: `0.1.0+8.16.0` 表示包版本 0.1.0，libvips 版本 8.16.0
- **纯 Dart 包**: `x.y.z`

## 环境要求

- Dart SDK >= 3.5.0
- Flutter >= 3.0.0 (Flutter 包)

## 开发

```bash
# 安装 melos
dart pub global activate melos

# 初始化所有包
melos bootstrap

# 运行分析
melos analyze

# 运行测试
melos test
```

## 许可证

LGPL-2.1 - 详见 [LICENSE](LICENSE)。

## 链接

- [libvips 官网](https://www.libvips.org/)
- [libvips GitHub](https://github.com/libvips/libvips)
- [Dart FFI 文档](https://dart.dev/guides/libraries/c-interop)
