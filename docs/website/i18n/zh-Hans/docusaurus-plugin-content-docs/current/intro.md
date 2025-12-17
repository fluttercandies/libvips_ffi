---
sidebar_position: 1
slug: /
---

# 简介

**libvips_ffi** 是一个高性能的 Flutter 和 Dart 图像处理库，基于 [libvips](https://www.libvips.org/) 构建。

## 为什么选择 libvips_ffi？

- **高性能**：libvips 是最快的图像处理库之一，使用流式处理和缓存来最小化内存使用
- **功能丰富**：支持缩放、裁剪、旋转、模糊、锐化、色彩转换等 300+ 种操作
- **跨平台**：支持 Android、iOS、macOS、Windows 和 Linux
- **易于使用**：Pipeline 风格的链式 API，直观的图像处理体验
- **纯 Dart FFI**：无平台通道，直接调用原生库

## 快速开始

### 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  libvips_ffi: ^0.1.0
```

### 基本用法

```dart
import 'package:libvips_ffi/libvips_ffi.dart';

void main() async {
  // 初始化 libvips
  VipsCore.init();
  
  // 使用 Pipeline 处理图像
  final result = VipsPipeline.fromFile('input.jpg')
    .resize(width: 800)
    .gaussianBlur(sigma: 1.5)
    .rotate(angle: 90)
    .toJpeg(quality: 85);
  
  // 保存到文件
  File('output.jpg').writeAsBytesSync(result);
  
  // 清理
  VipsCore.shutdown();
}
```

## 包家族

libvips_ffi 以 monorepo 形式组织，包含多个包：

| 包名 | 描述 |
|------|------|
| [libvips_ffi](packages/libvips_ffi) | 主 Flutter 插件 (Android/iOS) |
| [libvips_ffi_api](packages/libvips_ffi_api) | 高级 Pipeline API |
| [libvips_ffi_core](packages/libvips_ffi_core) | 纯 Dart FFI 绑定 |
| [libvips_ffi_desktop](packages/libvips_ffi_desktop) | 桌面端元包 |
| libvips_ffi_macos | macOS 预编译库 |
| libvips_ffi_windows | Windows 预编译库 |
| libvips_ffi_linux | Linux 预编译库 |

## 下一步

- [快速入门](getting-started/installation) - 安装和设置
- [Pipeline API](guide/pipeline) - 学习 Pipeline API
- [包概览](packages/overview) - 了解包结构
