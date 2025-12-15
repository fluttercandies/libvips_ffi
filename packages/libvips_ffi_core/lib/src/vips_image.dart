import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import 'bindings/vips_bindings_generated.dart'
    hide VipsDirection, VipsInterpretation;
import 'vips_core.dart';
import 'vips_pointer_manager.dart';
import 'vips_variadic_bindings.dart';

// Re-export core functions and types for convenience.
// 为方便起见，重新导出核心函数和类型。
export 'vips_core.dart'
    show
        VipsException,
        initVipsSystem,
        initVipsWithLoader,
        initVipsWithLibrary,
        shutdownVips,
        getVipsError,
        clearVipsError,
        vipsVersion,
        vipsVersionString;
export 'vips_enums.dart' show VipsDirection, VipsInterpretation;
export 'vips_pointer_manager.dart' show VipsPointerManager;
export 'loader/library_loader.dart'
    show VipsLibraryLoader, SystemVipsLoader, PathVipsLoader, DirectVipsLoader;
export 'platform_types.dart' show VipsPlatform, VipsArch;

// Export extensions for convenience
// 为方便起见导出扩展
export 'extensions/vips_transform_extension.dart';
export 'extensions/vips_filter_extension.dart';
export 'extensions/vips_color_extension.dart';
export 'extensions/vips_io_extension.dart';
export 'extensions/vips_utility_extension.dart';

/// High-level wrapper for VipsImage.
///
/// VipsImage 的高级封装。
///
/// This class provides a safe, Dart-friendly interface to libvips images.
/// Resources are automatically managed - call [dispose] when done.
/// 此类提供了一个安全的、对 Dart 友好的 libvips 图像接口。
/// 资源自动管理 - 完成后调用 [dispose]。
///
/// ## Example / 示例
///
/// ```dart
/// final image = VipsImageWrapper.fromFile('input.jpg');
/// try {
///   final resized = image.resize(0.5);
///   resized.writeToFile('output.jpg');
///   resized.dispose();
/// } finally {
///   image.dispose();
/// }
/// ```
class VipsImageWrapper {
  final ffi.Pointer<VipsImage> _pointer;
  bool _disposed = false;

  /// Buffer pointer that must be kept alive for the lifetime of the image.
  ///
  /// 必须在图像生命周期内保持活动的缓冲区指针。
  ///
  /// This is needed because vips_image_new_from_buffer does lazy loading
  /// and requires the buffer to remain valid until the image is disposed.
  /// 这是必需的，因为 vips_image_new_from_buffer 执行延迟加载，
  /// 需要缓冲区在图像被释放之前保持有效。
  ffi.Pointer<ffi.Uint8>? _bufferPtr;

  VipsImageWrapper._(this._pointer, [this._bufferPtr, String? label]) {
    VipsPointerManager.instance.register(_pointer, label);
  }

  /// Creates a VipsImageWrapper from a raw pointer.
  ///
  /// 从原始指针创建 VipsImageWrapper。
  ///
  /// This is used internally by extension methods to create new instances.
  /// 这是扩展方法内部用于创建新实例的方法。
  ///
  /// [pointer] is the VipsImage pointer.
  /// [pointer] 是 VipsImage 指针。
  ///
  /// [bufferPtr] is an optional buffer pointer that must be kept alive.
  /// [bufferPtr] 是可选的缓冲区指针，必须保持活动状态。
  ///
  /// [label] is an optional label for debugging.
  /// [label] 是可选的调试标签。
  factory VipsImageWrapper.fromPointer(
    ffi.Pointer<VipsImage> pointer, {
    ffi.Pointer<ffi.Uint8>? bufferPtr,
    String? label,
  }) {
    return VipsImageWrapper._(pointer, bufferPtr, label ?? 'fromPointer');
  }

  /// Whether this image has been disposed.
  ///
  /// 此图像是否已被释放。
  bool get isDisposed => _disposed;

  /// Whether the underlying pointer is null.
  ///
  /// 底层指针是否为空。
  bool get isNull => _pointer == ffi.nullptr;

  /// Gets the underlying pointer.
  ///
  /// 获取底层指针。
  ///
  /// Throws [StateError] if the image has been disposed.
  /// 如果图像已被释放，则抛出 [StateError]。
  ffi.Pointer<VipsImage> get pointer {
    checkDisposed();
    return _pointer;
  }

  /// Checks if the image has been disposed and throws if so.
  ///
  /// 检查图像是否已被释放，如果是则抛出异常。
  void checkDisposed() {
    if (_disposed) {
      throw StateError('VipsImage has been disposed');
    }
  }

  /// Loads an image from a file.
  ///
  /// 从文件加载图像。
  ///
  /// [filename] is the path to the image file.
  /// [filename] 是图像文件的路径。
  ///
  /// Throws [VipsException] if loading fails.
  /// 如果加载失败，则抛出 [VipsException]。
  factory VipsImageWrapper.fromFile(String filename) {
    clearVipsError();

    final filenamePtr = filename.toNativeUtf8();
    try {
      final imagePtr = variadicBindings.imageNewFromFile(filenamePtr.cast());

      if (imagePtr == ffi.nullptr) {
        final error = getVipsError();
        clearVipsError();
        throw VipsException(
          'Failed to load image: $filename. ${error ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(imagePtr, null, 'fromFile: $filename');
    } finally {
      calloc.free(filenamePtr);
    }
  }

  /// Loads an image from memory buffer.
  ///
  /// 从内存缓冲区加载图像。
  ///
  /// [data] is the image data in any supported format (JPEG, PNG, etc.).
  /// [data] 是任何支持格式（JPEG、PNG 等）的图像数据。
  ///
  /// [optionString] can specify format options.
  /// [optionString] 可以指定格式选项。
  ///
  /// Throws [VipsException] if loading fails.
  /// 如果加载失败，则抛出 [VipsException]。
  factory VipsImageWrapper.fromBuffer(
    Uint8List data, {
    String optionString = '',
  }) {
    clearVipsError();

    final dataPtr = calloc<ffi.Uint8>(data.length);
    final optionPtr = optionString.toNativeUtf8();

    try {
      // Copy data to native memory using batch copy (much faster than byte-by-byte)
      // 使用批量拷贝将数据复制到原生内存（比逐字节拷贝快得多）
      dataPtr.asTypedList(data.length).setAll(0, data);

      final imagePtr = variadicBindings.imageNewFromBuffer(
        dataPtr.cast(),
        data.length,
        optionPtr.cast(),
      );

      if (imagePtr == ffi.nullptr) {
        // Free buffer on error
        calloc.free(dataPtr);
        throw VipsException(
          'Failed to load image from buffer. ${getVipsError() ?? "Unknown error"}',
        );
      }

      // IMPORTANT: Do NOT free dataPtr here!
      // vips_image_new_from_buffer does lazy loading and requires the buffer
      // to remain valid until the image is disposed. The buffer will be freed
      // in dispose().
      return VipsImageWrapper._(imagePtr, dataPtr, 'fromBuffer');
    } finally {
      // Only free optionPtr, NOT dataPtr - it must stay alive for lazy loading
      calloc.free(optionPtr);
    }
  }

  /// Gets image width in pixels.
  ///
  /// 获取图像宽度（以像素为单位）。
  int get width {
    checkDisposed();
    return vipsBindings.vips_image_get_width(_pointer);
  }

  /// Gets image height in pixels.
  ///
  /// 获取图像高度（以像素为单位）。
  int get height {
    checkDisposed();
    return vipsBindings.vips_image_get_height(_pointer);
  }

  /// Gets number of bands (channels) in the image.
  ///
  /// 获取图像的通道数。
  int get bands {
    checkDisposed();
    return vipsBindings.vips_image_get_bands(_pointer);
  }

  // ============ Static Factory Methods ============
  // ============ 静态工厂方法 ============

  /// Creates a thumbnail directly from a file path.
  ///
  /// 直接从文件路径创建缩略图。
  ///
  /// This is more efficient than loading then thumbnailing, as it
  /// shrinks the image during load.
  /// 这比先加载再创建缩略图更高效，因为它在加载时就缩小图像。
  ///
  /// [filename] is the path to the image file.
  /// [filename] 是图像文件的路径。
  ///
  /// [targetWidth] is the desired width in pixels.
  /// [targetWidth] 是期望的宽度（像素）。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  static VipsImageWrapper thumbnailFromFile(String filename, int targetWidth) {
    clearVipsError();

    final filenamePtr = filename.toNativeUtf8();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();

    try {
      final result =
          variadicBindings.thumbnail(filenamePtr.cast(), outPtr, targetWidth);

      if (result != 0) {
        throw VipsException(
          'Failed to create thumbnail from file: $filename. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(
          outPtr.value, null, 'thumbnailFromFile: $filename');
    } finally {
      calloc.free(filenamePtr);
      calloc.free(outPtr);
    }
  }

  /// Creates a thumbnail directly from a memory buffer.
  ///
  /// 直接从内存缓冲区创建缩略图。
  ///
  /// This is more efficient than loading then thumbnailing, as it
  /// shrinks the image during load.
  /// 这比先加载再创建缩略图更高效，因为它在加载时就缩小图像。
  ///
  /// [data] is the image data in any supported format.
  /// [data] 是任何支持格式的图像数据。
  ///
  /// [targetWidth] is the desired width in pixels.
  /// [targetWidth] 是期望的宽度（像素）。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  static VipsImageWrapper thumbnailFromBuffer(
      Uint8List data, int targetWidth) {
    clearVipsError();

    final dataPtr = calloc<ffi.Uint8>(data.length);
    final outPtr = calloc<ffi.Pointer<VipsImage>>();

    try {
      // Copy data to native memory using batch copy (much faster than byte-by-byte)
      // 使用批量拷贝将数据复制到原生内存（比逐字节拷贝快得多）
      dataPtr.asTypedList(data.length).setAll(0, data);

      final result = variadicBindings.thumbnailBuffer(
        dataPtr.cast(),
        data.length,
        outPtr,
        targetWidth,
      );

      if (result != 0) {
        // Free buffer on error
        calloc.free(dataPtr);
        throw VipsException(
          'Failed to create thumbnail from buffer. ${getVipsError() ?? "Unknown error"}',
        );
      }

      // IMPORTANT: Do NOT free dataPtr here!
      // vips_thumbnail_buffer does lazy loading and requires the buffer
      // to remain valid until the image is disposed. The buffer will be freed
      // in dispose().
      return VipsImageWrapper._(outPtr.value, dataPtr, 'thumbnailFromBuffer');
    } finally {
      // Only free outPtr, NOT dataPtr - it must stay alive for lazy loading
      calloc.free(outPtr);
    }
  }

  // ============ Composition Methods ============
  // ============ 合成方法 ============

  /// Creates a black (empty) image with the specified dimensions.
  ///
  /// 创建指定尺寸的黑色（空白）图像。
  ///
  /// [width] is the image width in pixels.
  /// [width] 是图像宽度（像素）。
  ///
  /// [height] is the image height in pixels.
  /// [height] 是图像高度（像素）。
  ///
  /// Returns a new [VipsImageWrapper] with 1 band. Remember to dispose it when done.
  /// 返回新的 1 通道 [VipsImageWrapper]。完成后记得调用 dispose。
  static VipsImageWrapper black(int width, int height) {
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();

    try {
      final result = variadicBindings.black(outPtr, width, height);

      if (result != 0) {
        throw VipsException(
          'Failed to create black image. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value, null, 'black');
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Creates an image filled with a solid color (3-band RGB).
  ///
  /// 创建填充纯色的图像（3 通道 RGB）。
  ///
  /// [width] is the image width in pixels.
  /// [width] 是图像宽度（像素）。
  ///
  /// [height] is the image height in pixels.
  /// [height] 是图像高度（像素）。
  ///
  /// [r], [g], [b] are the RGB color values (0-255).
  /// [r]、[g]、[b] 是 RGB 颜色值（0-255）。
  ///
  /// Returns a new [VipsImageWrapper] with 3 bands. Remember to dispose it when done.
  /// 返回新的 3 通道 [VipsImageWrapper]。完成后记得调用 dispose。
  static VipsImageWrapper solidColor(
    int width,
    int height, {
    int r = 255,
    int g = 255,
    int b = 255,
  }) {
    // Create a 1-band black image first
    var canvas = black(width, height);
    
    // Set R channel value using linear (variadic function): out = in * 1 + r
    final outPtr1 = calloc<ffi.Pointer<VipsImage>>();
    final aPtr = calloc<ffi.Double>(1);
    final bPtr = calloc<ffi.Double>(1);
    try {
      aPtr[0] = 1.0;
      bPtr[0] = r.toDouble();
      
      final result1 = variadicBindings.linear(
        canvas._pointer,
        outPtr1,
        aPtr,
        bPtr,
        1,
      );
      
      if (result1 == 0) {
        canvas.dispose();
        canvas = VipsImageWrapper._(outPtr1.value, null, 'solidColor_r');
      } else {
        throw VipsException(
          'Failed to set R channel. ${getVipsError() ?? "Unknown error"}',
        );
      }
    } finally {
      calloc.free(outPtr1);
      calloc.free(aPtr);
      calloc.free(bPtr);
    }
    
    // Add G band
    final outPtr2 = calloc<ffi.Pointer<VipsImage>>();
    final gPtr = calloc<ffi.Double>(1);
    try {
      gPtr[0] = g.toDouble();
      
      final result2 = variadicBindings.bandjoinConst(
        canvas._pointer,
        outPtr2,
        gPtr,
        1,
      );
      
      if (result2 == 0) {
        canvas.dispose();
        canvas = VipsImageWrapper._(outPtr2.value, null, 'solidColor_rg');
      } else {
        throw VipsException(
          'Failed to add G band. ${getVipsError() ?? "Unknown error"}',
        );
      }
    } finally {
      calloc.free(outPtr2);
      calloc.free(gPtr);
    }
    
    // Add B band
    final outPtr3 = calloc<ffi.Pointer<VipsImage>>();
    final bBandPtr = calloc<ffi.Double>(1);
    try {
      bBandPtr[0] = b.toDouble();
      
      final result3 = variadicBindings.bandjoinConst(
        canvas._pointer,
        outPtr3,
        bBandPtr,
        1,
      );
      
      if (result3 == 0) {
        canvas.dispose();
        canvas = VipsImageWrapper._(outPtr3.value, null, 'solidColor_rgb');
      } else {
        throw VipsException(
          'Failed to add B band. ${getVipsError() ?? "Unknown error"}',
        );
      }
    } finally {
      calloc.free(outPtr3);
      calloc.free(bBandPtr);
    }
    
    return canvas;
  }

  /// Inserts another image into this image at the specified position.
  ///
  /// 在指定位置将另一张图像插入到此图像中。
  ///
  /// [sub] is the image to insert.
  /// [sub] 是要插入的图像。
  ///
  /// [x] is the x position to insert at.
  /// [x] 是插入的 x 位置。
  ///
  /// [y] is the y position to insert at.
  /// [y] 是插入的 y 位置。
  ///
  /// [expand] if true, expands the output to hold all of both images.
  /// [expand] 如果为 true，则扩展输出以容纳两张图像。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  VipsImageWrapper insert(VipsImageWrapper sub, int x, int y, {bool expand = false}) {
    checkDisposed();
    sub.checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();

    try {
      final result = variadicBindings.insert(
        _pointer,
        sub._pointer,
        outPtr,
        x,
        y,
      );

      if (result != 0) {
        throw VipsException(
          'Failed to insert image. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value, null, 'insert');
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Releases the image resources.
  ///
  /// 释放图像资源。
  ///
  /// After calling dispose, this object should not be used anymore.
  /// 调用 dispose 后，此对象不应再被使用。
  void dispose() {
    if (_disposed) return;
    VipsPointerManager.instance.unregister(_pointer);
    vipsBindings.g_object_unref(_pointer.cast());
    // Free the buffer pointer if it was allocated (from fromBuffer constructor)
    if (_bufferPtr != null) {
      calloc.free(_bufferPtr!);
      _bufferPtr = null;
    }
    _disposed = true;
  }
}
