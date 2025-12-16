/// Pure Dart FFI bindings for libvips image processing library.
///
/// libvips 图像处理库的纯 Dart FFI 绑定。
///
/// This library provides low-level Dart bindings for the libvips image
/// processing library without any Flutter dependency.
/// 此库为 libvips 图像处理库提供底层 Dart 绑定，无 Flutter 依赖。
///
/// For high-level API, use `libvips_ffi_api` package with `VipsPipeline`.
/// 若需高级 API，请使用 `libvips_ffi_api` 包的 `VipsPipeline`。
///
/// ## Getting Started / 入门
///
/// ```dart
/// import 'package:libvips_ffi_core/libvips_ffi_core.dart';
///
/// void main() {
///   // Use system libvips (desktop)
///   initVipsSystem();
///
///   // Or use custom path
///   // initVipsWithLoader(PathVipsLoader('/path/to/libvips.dylib'));
///
///   // Your code here / 你的代码
///   shutdownVips();
/// }
/// ```
library libvips_ffi_core;

// Export raw bindings for advanced users.
// 为高级用户导出原始绑定。
export 'src/bindings/vips_bindings_generated.dart' show VipsBindings;

// Export library loading utilities.
// 导出库加载工具。
export 'src/vips_core.dart'
    show
        vipsBindings,
        vipsLibrary,
        initVipsSystem,
        initVipsWithLoader,
        initVipsWithLookup,
        initVipsWithLibrary,
        shutdownVips,
        getVipsError,
        clearVipsError,
        vipsVersion,
        vipsVersionString,
        VipsException;

export 'src/loader/library_loader.dart'
    show VipsLibraryLoader, SystemVipsLoader, PathVipsLoader, DirectVipsLoader;

export 'src/platform_types.dart' show VipsPlatform, VipsArch;

// Export enums for high-level API use.
// 导出枚举供高级 API 使用。
export 'src/vips_enums.dart' show VipsDirection, VipsInterpretation;

// Export pointer manager for memory diagnostics.
// 导出指针管理器用于内存诊断。
export 'src/vips_pointer_manager.dart' show VipsPointerManager;
