---
sidebar_position: 4
---

# libvips_ffi_core

libvips 的纯 Dart FFI 绑定。无 Flutter 依赖。

## 安装

```yaml
dependencies:
  libvips_ffi_core: ^0.1.0+8.16.0
```

:::note
此包仅提供 FFI 绑定。你需要单独加载库。
:::

## 特性

- 纯 Dart（无 Flutter 依赖）
- 从 libvips 头文件生成的绑定
- 支持 variadic 函数的 VarArgs
- 内存管理工具

## 核心类

### VipsCore

库初始化和版本信息的静态类。

```dart
// 初始化 libvips
VipsCore.init();

// 获取版本
print(VipsCore.version);     // 如 "8.16.0"
print(VipsCore.majorVersion); // 如 8

// 关闭
VipsCore.shutdown();
```

### VipsPointerManager

原生指针的内存管理。

```dart
final manager = VipsPointerManager();
try {
  final ptr = manager.allocate<Int>(10);
  // 使用 ptr...
} finally {
  manager.freeAll();
}
```

### LibraryLoader

平台特定的库加载。

```dart
// 自动检测
final lib = LibraryLoader.load();

// 自定义路径
final lib = LibraryLoader.loadFromPath('/path/to/libvips.so');
```

## 枚举

此包导出 libvips 枚举：

```dart
VipsDirection.horizontal
VipsDirection.vertical

VipsInterpretation.sRGB
VipsInterpretation.lab
VipsInterpretation.grey16

VipsBlendMode.over
VipsBlendMode.multiply
VipsBlendMode.screen

// ... 还有更多
```

## 底层使用

对于需要直接 FFI 访问的高级用户：

```dart
import 'package:libvips_ffi_core/libvips_ffi_core.dart';
import 'dart:ffi' as ffi;

void main() {
  VipsCore.init();
  
  final bindings = VipsCore.bindings;
  
  // 直接 FFI 调用
  final namePtr = 'input.jpg'.toNativeUtf8();
  final imagePtr = bindings.vips_image_new_from_file(
    namePtr.cast(),
    ffi.nullptr,  // variadic 参数的 NULL 终止符
  );
  
  if (imagePtr != ffi.nullptr) {
    print('宽度: ${bindings.vips_image_get_width(imagePtr)}');
    bindings.g_object_unref(imagePtr.cast());
  }
  
  calloc.free(namePtr);
  VipsCore.shutdown();
}
```

## 何时使用

使用 `libvips_ffi_core` 当：

- 构建自定义高级 API
- 需要直接 FFI 访问以获得性能
- 在非 Flutter Dart 环境中工作
- 创建专门的图像处理工具

对于大多数用例，建议使用 `libvips_ffi_api`，它提供更友好的 API。
