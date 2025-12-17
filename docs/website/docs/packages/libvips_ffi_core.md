---
sidebar_position: 4
---

# libvips_ffi_core

Pure Dart FFI bindings for libvips. No Flutter dependency.

## Installation

```yaml
dependencies:
  libvips_ffi_core: ^0.1.0+8.16.0
```

:::note
This package provides FFI bindings only. You need to load the library separately.
:::

## Features

- Pure Dart (no Flutter dependency)
- Generated bindings from libvips headers
- VarArgs support for variadic functions
- Memory management utilities

## Core Classes

### VipsCore

Static class for library initialization and version info.

```dart
// Initialize libvips
VipsCore.init();

// Get version
print(VipsCore.version);     // e.g., "8.16.0"
print(VipsCore.majorVersion); // e.g., 8

// Shutdown
VipsCore.shutdown();
```

### VipsPointerManager

Memory management for native pointers.

```dart
final manager = VipsPointerManager();
try {
  final ptr = manager.allocate<Int>(10);
  // Use ptr...
} finally {
  manager.freeAll();
}
```

### LibraryLoader

Platform-specific library loading.

```dart
// Automatic detection
final lib = LibraryLoader.load();

// Custom path
final lib = LibraryLoader.loadFromPath('/path/to/libvips.so');
```

## Enums

The package exports libvips enums:

```dart
VipsDirection.horizontal
VipsDirection.vertical

VipsInterpretation.sRGB
VipsInterpretation.lab
VipsInterpretation.grey16

VipsBlendMode.over
VipsBlendMode.multiply
VipsBlendMode.screen

// ... and many more
```

## Low-Level Usage

For advanced users who need direct FFI access:

```dart
import 'package:libvips_ffi_core/libvips_ffi_core.dart';
import 'dart:ffi' as ffi;

void main() {
  VipsCore.init();
  
  final bindings = VipsCore.bindings;
  
  // Direct FFI call
  final namePtr = 'input.jpg'.toNativeUtf8();
  final imagePtr = bindings.vips_image_new_from_file(
    namePtr.cast(),
    ffi.nullptr,  // NULL terminator for variadic args
  );
  
  if (imagePtr != ffi.nullptr) {
    print('Width: ${bindings.vips_image_get_width(imagePtr)}');
    bindings.g_object_unref(imagePtr.cast());
  }
  
  calloc.free(namePtr);
  VipsCore.shutdown();
}
```

## When to Use

Use `libvips_ffi_core` when:
- Building a custom high-level API
- Need direct FFI access for performance
- Working in a non-Flutter Dart environment
- Creating specialized image processing tools

For most use cases, prefer `libvips_ffi_api` which provides a friendlier API.
