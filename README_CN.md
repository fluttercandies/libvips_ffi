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

## 包架构

```text
┌─────────────────────────────────────────────────────────────────┐
│                          你的应用程序                             │
├─────────────────────────────────────────────────────────────────┤
│  Flutter 移动端   │  Flutter 桌面端    │  纯 Dart 桌面端         │
│  (Android/iOS)    │  (macOS/Win/Linux) │  (CLI/服务器)           │
├───────────────────┼────────────────────┼─────────────────────────┤
│  libvips_ffi      │  libvips_ffi       │  libvips_ffi_core       │
│  (内置原生库)      │  + 平台包          │  + 加载器选择            │
└───────────────────┴────────────────────┴─────────────────────────┘
                              │
              ┌───────────────┼───────────────┐
              ▼               ▼               ▼
      libvips_ffi_macos  libvips_ffi_windows  libvips_ffi_linux
      (预编译库)          (预编译库)           (预编译库)
                              │
                              ▼
                      libvips_ffi_core (纯 Dart FFI)
```

## 包结构

本项目使用 [melos](https://melos.invertase.dev/) 进行多包管理。

### 核心包

| 包名 | 说明 |
|------|------|
| [libvips_ffi_core](packages/libvips_ffi_core/) | 纯 Dart FFI 绑定 (无 Flutter 依赖) |

### 平台包

| 包名 | 说明 |
|------|------|
| [libvips_ffi](packages/libvips_ffi/) | Flutter 移动端 (Android/iOS)，内置原生库 |
| [libvips_ffi_macos](packages/libvips_ffi_macos/) | macOS 预编译包 (arm64 + x86_64) |
| [libvips_ffi_windows](packages/libvips_ffi_windows/) | Windows 预编译包 (x64) |
| [libvips_ffi_linux](packages/libvips_ffi_linux/) | Linux 预编译包 (x64) |
| [libvips_ffi_desktop](packages/libvips_ffi_desktop/) | 桌面元包 (自动选择平台) |

### 工具包

| 包名 | 说明 |
|------|------|
| [libvips_ffi_system](packages/libvips_ffi_system/) | 从系统包管理器加载 (Homebrew, apt 等) |
| [libvips_ffi_loader](packages/libvips_ffi_loader/) | 动态库下载器，支持回调 |

## 按平台快速入门

### Flutter 移动端 (Android/iOS) - 推荐

预编译的原生库会自动打包。

```yaml
dependencies:
  libvips_ffi: ^0.0.1
```

```dart
import 'package:libvips_ffi/libvips_ffi.dart';

void main() {
  initVips();
  
  // 同步 API (简单操作)
  final image = VipsImageWrapper.fromFile('input.jpg');
  final resized = image.resize(0.5);
  resized.writeToFile('output.jpg');
  resized.dispose();
  image.dispose();
  
  // 异步 API (Flutter UI 推荐)
  final result = await VipsCompute.resizeFile('input.jpg', 0.5);
  // result.data 包含处理后的图像字节
  
  shutdownVips();
}
```

### Flutter 桌面端 (macOS/Windows/Linux) - 推荐

使用 `libvips_ffi` 配合平台特定包来获取内置库。

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
  initVips();  // 自动检测平台并加载内置库
  
  // 与移动端相同的 API
  final result = await VipsCompute.resizeFile('input.jpg', 0.5);
  
  shutdownVips();
}
```

### 纯 Dart 桌面端 (CLI/服务器)

用于非 Flutter 的 Dart 应用程序。

#### 方式一：使用系统安装的 libvips

```yaml
dependencies:
  libvips_ffi_core: ^0.1.0
```

```dart
import 'package:libvips_ffi_core/libvips_ffi_core.dart';

void main() {
  // 需要先安装: brew install vips (macOS) 或 apt install libvips-dev (Linux)
  initVipsSystem();
  
  final image = VipsImageWrapper.fromFile('input.jpg');
  final resized = image.resize(0.5);
  resized.writeToFile('output.jpg');
  
  resized.dispose();
  image.dispose();
  shutdownVips();
}
```

#### 方式二：使用预编译库

```yaml
dependencies:
  libvips_ffi_desktop: ^0.1.0
```

```dart
import 'package:libvips_ffi_desktop/libvips_ffi_desktop.dart';

void main() {
  initVipsDesktop();  // 自动选择平台
  // ...
  shutdownVips();
}
```

## 如何选择正确的包

| 场景 | 推荐包 |
|------|--------|
| Flutter 移动应用 | `libvips_ffi` |
| Flutter 桌面应用 | `libvips_ffi` + `libvips_ffi_<平台>` |
| Dart CLI 工具 (系统 libvips) | `libvips_ffi_core` |
| Dart CLI 工具 (内置 libvips) | `libvips_ffi_desktop` |
| 自定义库加载 | `libvips_ffi_core` + `libvips_ffi_loader` |

## 同步 vs 异步 API

| API | 使用场景 | 阻塞 UI? |
|-----|----------|----------|
| `VipsImageWrapper` (同步) | 简单脚本、CLI 工具 | 是 |
| `VipsCompute` (异步) | Flutter 应用、UI 密集型应用 | 否 (在 isolate 中运行) |

```dart
// 同步 - 阻塞直到完成
final image = VipsImageWrapper.fromFile('input.jpg');
final resized = image.resize(0.5);

// 异步 - 在后台 isolate 中运行
final result = await VipsCompute.resizeFile('input.jpg', 0.5);
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
