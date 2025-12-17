---
sidebar_position: 2
---

# libvips_ffi

Android 和 iOS 的主 Flutter 插件。

## 安装

```yaml
dependencies:
  libvips_ffi: ^0.1.0+8.16.0
```

## 特性

- 捆绑 libvips 8.16.0 用于 Android 和 iOS
- Flutter 特定 API (`VipsPipelineCompute`)
- 自动库加载
- 平台特定优化

## 支持的平台

| 平台 | 架构 | 备注 |
|------|------|------|
| Android | arm64-v8a | 64 位 ARM |
| Android | armeabi-v7a | 32 位 ARM |
| Android | x86_64 | 模拟器 |
| iOS | arm64 | 设备 |
| iOS | arm64 (模拟器) | Apple Silicon Mac |

:::warning
不支持 iOS x86_64 模拟器 (Intel Mac)。
:::

## 使用

### 同步 API (VipsPipeline)

```dart
import 'package:libvips_ffi/libvips_ffi.dart';

void main() {
  VipsCore.init();
  
  final result = VipsPipeline.fromFile('input.jpg')
    .resize(width: 800)
    .toJpeg(quality: 85);
  
  File('output.jpg').writeAsBytesSync(result);
  
  VipsCore.shutdown();
}
```

### 异步 API (VipsPipelineCompute)

```dart
import 'package:libvips_ffi/libvips_ffi.dart';

Future<Uint8List> processImage(String path) async {
  return await VipsPipelineCompute.run(
    PipelineSpec.fromFile(path)
      .resize(width: 800)
      .toJpeg(quality: 85),
  );
}
```

## Android 配置

### 最低 SDK

库需要 Android API 21 (Lollipop) 或更高。

```gradle
android {
    defaultConfig {
        minSdkVersion 21
    }
}
```

### ProGuard

不需要 ProGuard 配置。原生库自动包含。

### Android 15+ (16KB 页面对齐)

所有原生库都是 16KB 页面对齐，兼容 Android 15+。

## iOS 配置

### 最低版本

需要 iOS 12.0 或更高。

```ruby
# Podfile
platform :ios, '12.0'
```

### Bitcode

默认禁用 Bitcode，因为 libvips 不支持。

## 导出的 API

此包重新导出：

- `libvips_ffi_api` - Pipeline API
- `libvips_ffi_core` - 核心 FFI 绑定

```dart
// 这些都可以从 libvips_ffi 使用
import 'package:libvips_ffi/libvips_ffi.dart';

VipsPipeline        // 来自 libvips_ffi_api
VipsCore            // 来自 libvips_ffi_core
VipsImage           // 来自 libvips_ffi_core
```
