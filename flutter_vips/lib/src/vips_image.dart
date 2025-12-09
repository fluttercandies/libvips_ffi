import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import 'bindings/vips_bindings_generated.dart';
import 'vips_library.dart';

/// Global libvips bindings instance.
final VipsBindings _bindings = VipsBindings(vipsLibrary);

// Custom function types for variadic functions that need NULL termination
typedef _VipsImageNewFromFileNative = ffi.Pointer<VipsImage> Function(
  ffi.Pointer<ffi.Char> name,
  ffi.Pointer<ffi.Void> terminator, // NULL terminator
);
typedef _VipsImageNewFromFileDart = ffi.Pointer<VipsImage> Function(
  ffi.Pointer<ffi.Char> name,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsImageWriteToFileNative = ffi.Int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Char> name,
  ffi.Pointer<ffi.Void> terminator, // NULL terminator
);
typedef _VipsImageWriteToFileDart = int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Char> name,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsImageWriteToBufferNative = ffi.Int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Char> suffix,
  ffi.Pointer<ffi.Pointer<ffi.Void>> buf,
  ffi.Pointer<ffi.Size> size,
  ffi.Pointer<ffi.Void> terminator, // NULL terminator
);
typedef _VipsImageWriteToBufferDart = int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Char> suffix,
  ffi.Pointer<ffi.Pointer<ffi.Void>> buf,
  ffi.Pointer<ffi.Size> size,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsImageNewFromBufferNative = ffi.Pointer<VipsImage> Function(
  ffi.Pointer<ffi.Void> buf,
  ffi.Size len,
  ffi.Pointer<ffi.Char> option_string,
  ffi.Pointer<ffi.Void> terminator, // NULL terminator
);
typedef _VipsImageNewFromBufferDart = ffi.Pointer<VipsImage> Function(
  ffi.Pointer<ffi.Void> buf,
  int len,
  ffi.Pointer<ffi.Char> option_string,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsResizeNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double scale,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsResizeDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double scale,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsRotateNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double angle,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsRotateDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double angle,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsCropNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int left,
  ffi.Int top,
  ffi.Int width,
  ffi.Int height,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsCropDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int left,
  int top,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsThumbnailImageNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsThumbnailImageDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsThumbnailNative = ffi.Int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsThumbnailDart = int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsThumbnailBufferNative = ffi.Int Function(
  ffi.Pointer<ffi.Void> buf,
  ffi.Size len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsThumbnailBufferDart = int Function(
  ffi.Pointer<ffi.Void> buf,
  int len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  ffi.Pointer<ffi.Void> terminator,
);

/// Custom bindings for variadic functions that need NULL termination
class _VipsVariadicBindings {
  final ffi.DynamicLibrary _lib;
  
  _VipsVariadicBindings(this._lib);
  
  late final _vipsImageNewFromFile = _lib
      .lookup<ffi.NativeFunction<_VipsImageNewFromFileNative>>('vips_image_new_from_file')
      .asFunction<_VipsImageNewFromFileDart>();
  
  late final _vipsImageWriteToFile = _lib
      .lookup<ffi.NativeFunction<_VipsImageWriteToFileNative>>('vips_image_write_to_file')
      .asFunction<_VipsImageWriteToFileDart>();
  
  late final _vipsImageWriteToBuffer = _lib
      .lookup<ffi.NativeFunction<_VipsImageWriteToBufferNative>>('vips_image_write_to_buffer')
      .asFunction<_VipsImageWriteToBufferDart>();
  
  late final _vipsImageNewFromBuffer = _lib
      .lookup<ffi.NativeFunction<_VipsImageNewFromBufferNative>>('vips_image_new_from_buffer')
      .asFunction<_VipsImageNewFromBufferDart>();
  
  late final _vipsResize = _lib
      .lookup<ffi.NativeFunction<_VipsResizeNative>>('vips_resize')
      .asFunction<_VipsResizeDart>();
  
  late final _vipsRotate = _lib
      .lookup<ffi.NativeFunction<_VipsRotateNative>>('vips_rotate')
      .asFunction<_VipsRotateDart>();
  
  late final _vipsCrop = _lib
      .lookup<ffi.NativeFunction<_VipsCropNative>>('vips_crop')
      .asFunction<_VipsCropDart>();
  
  late final _vipsThumbnailImage = _lib
      .lookup<ffi.NativeFunction<_VipsThumbnailImageNative>>('vips_thumbnail_image')
      .asFunction<_VipsThumbnailImageDart>();
  
  late final _vipsThumbnail = _lib
      .lookup<ffi.NativeFunction<_VipsThumbnailNative>>('vips_thumbnail')
      .asFunction<_VipsThumbnailDart>();
  
  late final _vipsThumbnailBuffer = _lib
      .lookup<ffi.NativeFunction<_VipsThumbnailBufferNative>>('vips_thumbnail_buffer')
      .asFunction<_VipsThumbnailBufferDart>();
  
  ffi.Pointer<VipsImage> imageNewFromFile(ffi.Pointer<ffi.Char> name) {
    return _vipsImageNewFromFile(name, ffi.nullptr);
  }
  
  int imageWriteToFile(ffi.Pointer<VipsImage> image, ffi.Pointer<ffi.Char> name) {
    return _vipsImageWriteToFile(image, name, ffi.nullptr);
  }
  
  int imageWriteToBuffer(
    ffi.Pointer<VipsImage> image,
    ffi.Pointer<ffi.Char> suffix,
    ffi.Pointer<ffi.Pointer<ffi.Void>> buf,
    ffi.Pointer<ffi.Size> size,
  ) {
    return _vipsImageWriteToBuffer(image, suffix, buf, size, ffi.nullptr);
  }
  
  ffi.Pointer<VipsImage> imageNewFromBuffer(
    ffi.Pointer<ffi.Void> buf,
    int len,
    ffi.Pointer<ffi.Char> optionString,
  ) {
    return _vipsImageNewFromBuffer(buf, len, optionString, ffi.nullptr);
  }
  
  int resize(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    double scale,
  ) {
    return _vipsResize(in1, out, scale, ffi.nullptr);
  }
  
  int rotate(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    double angle,
  ) {
    return _vipsRotate(in1, out, angle, ffi.nullptr);
  }
  
  int crop(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    int left,
    int top,
    int width,
    int height,
  ) {
    return _vipsCrop(in1, out, left, top, width, height, ffi.nullptr);
  }
  
  int thumbnailImage(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    int width,
  ) {
    return _vipsThumbnailImage(in1, out, width, ffi.nullptr);
  }
  
  int thumbnail(
    ffi.Pointer<ffi.Char> filename,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    int width,
  ) {
    return _vipsThumbnail(filename, out, width, ffi.nullptr);
  }
  
  int thumbnailBuffer(
    ffi.Pointer<ffi.Void> buf,
    int len,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    int width,
  ) {
    return _vipsThumbnailBuffer(buf, len, out, width, ffi.nullptr);
  }
}

/// Custom variadic bindings instance
final _VipsVariadicBindings _variadicBindings = _VipsVariadicBindings(vipsLibrary);

/// Whether libvips has been initialized.
bool _initialized = false;

/// Initialize libvips.
///
/// This must be called before using any other libvips functions.
/// It's safe to call multiple times - subsequent calls are no-ops.
///
/// Throws [VipsException] if initialization fails.
void initVips([String appName = 'flutter_vips']) {
  if (_initialized) return;

  final appNamePtr = appName.toNativeUtf8();
  try {
    final result = _bindings.vips_init(appNamePtr.cast());
    if (result != 0) {
      throw VipsException('Failed to initialize libvips: ${getVipsError()}');
    }
    _initialized = true;
  } finally {
    calloc.free(appNamePtr);
  }
}

/// Shutdown libvips and free resources.
///
/// Call this when you're done using libvips.
void shutdownVips() {
  if (!_initialized) return;
  _bindings.vips_shutdown();
  _initialized = false;
}

/// Get the current libvips error message.
String? getVipsError() {
  final errorPtr = _bindings.vips_error_buffer();
  if (errorPtr == ffi.nullptr) return null;
  
  try {
    // Try to decode as UTF-8, but handle potential encoding issues
    return errorPtr.cast<Utf8>().toDartString();
  } catch (e) {
    // If UTF-8 decoding fails, try to read as raw bytes and convert
    // This can happen if the error message contains non-UTF-8 characters
    try {
      // Read bytes until null terminator
      final bytes = <int>[];
      var i = 0;
      while (true) {
        final byte = errorPtr.cast<ffi.Uint8>()[i];
        if (byte == 0) break;
        bytes.add(byte);
        i++;
        if (i > 4096) break; // Safety limit
      }
      // Replace invalid UTF-8 sequences
      return String.fromCharCodes(bytes.where((b) => b < 128));
    } catch (_) {
      return 'Error reading vips error buffer';
    }
  }
}

/// Clear the libvips error buffer.
void clearVipsError() {
  _bindings.vips_error_clear();
}

/// Get libvips version information.
///
/// [flag] determines what version info to return:
/// - 0: major version
/// - 1: minor version
/// - 2: micro version
/// - 3: library current
/// - 4: library revision
/// - 5: library age
int vipsVersion(int flag) {
  return _bindings.vips_version(flag);
}

/// Get libvips version as a string (e.g., "8.15.0").
String get vipsVersionString {
  return '${vipsVersion(0)}.${vipsVersion(1)}.${vipsVersion(2)}';
}

/// Exception thrown by libvips operations.
class VipsException implements Exception {
  final String message;

  VipsException(this.message);

  @override
  String toString() => 'VipsException: $message';
}

/// High-level wrapper for VipsImage.
///
/// This class provides a safe, Dart-friendly interface to libvips images.
/// Resources are automatically managed - call [dispose] when done.
class VipsImageWrapper {
  final ffi.Pointer<VipsImage> _pointer;
  bool _disposed = false;

  VipsImageWrapper._(this._pointer);

  /// Whether this image has been disposed.
  bool get isDisposed => _disposed;

  /// Whether the underlying pointer is null.
  bool get isNull => _pointer == ffi.nullptr;

  /// Get the underlying pointer (for advanced use).
  ///
  /// Throws [StateError] if the image has been disposed.
  ffi.Pointer<VipsImage> get pointer {
    _checkDisposed();
    return _pointer;
  }

  /// Load an image from a file.
  ///
  /// Throws [VipsException] if loading fails.
  factory VipsImageWrapper.fromFile(String filename) {
    initVips();
    clearVipsError();

    final filenamePtr = filename.toNativeUtf8();
    try {
      // Use custom binding with NULL terminator for variadic function
      final imagePtr = _variadicBindings.imageNewFromFile(filenamePtr.cast());

      if (imagePtr == ffi.nullptr) {
        final error = getVipsError();
        clearVipsError();
        throw VipsException(
          'Failed to load image: $filename. ${error ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(imagePtr);
    } finally {
      calloc.free(filenamePtr);
    }
  }

  /// Load an image from memory buffer.
  ///
  /// [data] is the image data in any supported format (JPEG, PNG, etc.).
  /// [optionString] can specify format options.
  ///
  /// Throws [VipsException] if loading fails.
  factory VipsImageWrapper.fromBuffer(
    Uint8List data, {
    String optionString = '',
  }) {
    initVips();
    clearVipsError();

    final dataPtr = calloc<ffi.Uint8>(data.length);
    final optionPtr = optionString.toNativeUtf8();

    try {
      // Copy data to native memory
      for (var i = 0; i < data.length; i++) {
        dataPtr[i] = data[i];
      }

      // Use custom binding with NULL terminator for variadic function
      final imagePtr = _variadicBindings.imageNewFromBuffer(
        dataPtr.cast(),
        data.length,
        optionPtr.cast(),
      );

      if (imagePtr == ffi.nullptr) {
        throw VipsException(
          'Failed to load image from buffer. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(imagePtr);
    } finally {
      calloc.free(dataPtr);
      calloc.free(optionPtr);
    }
  }

  /// Get image width in pixels.
  int get width {
    _checkDisposed();
    return _bindings.vips_image_get_width(_pointer);
  }

  /// Get image height in pixels.
  int get height {
    _checkDisposed();
    return _bindings.vips_image_get_height(_pointer);
  }

  /// Get number of bands (channels) in the image.
  int get bands {
    _checkDisposed();
    return _bindings.vips_image_get_bands(_pointer);
  }

  /// Write the image to a file.
  ///
  /// The format is determined by the file extension.
  ///
  /// Throws [VipsException] if writing fails.
  void writeToFile(String filename) {
    _checkDisposed();
    clearVipsError();

    final filenamePtr = filename.toNativeUtf8();
    try {
      // Use custom binding with NULL terminator for variadic function
      final result = _variadicBindings.imageWriteToFile(_pointer, filenamePtr.cast());

      if (result != 0) {
        throw VipsException(
          'Failed to write image: $filename. ${getVipsError() ?? "Unknown error"}',
        );
      }
    } finally {
      calloc.free(filenamePtr);
    }
  }

  /// Write the image to a memory buffer.
  ///
  /// [suffix] determines the format (e.g., '.jpg', '.png', '.webp').
  ///
  /// Returns the encoded image data.
  /// Throws [VipsException] if encoding fails.
  Uint8List writeToBuffer(String suffix) {
    _checkDisposed();
    clearVipsError();

    final suffixPtr = suffix.toNativeUtf8();
    final bufPtr = calloc<ffi.Pointer<ffi.Void>>();
    final sizePtr = calloc<ffi.Size>();

    try {
      // Use custom binding with NULL terminator for variadic function
      final result = _variadicBindings.imageWriteToBuffer(
        _pointer,
        suffixPtr.cast(),
        bufPtr,
        sizePtr,
      );

      if (result != 0) {
        throw VipsException(
          'Failed to write image to buffer. ${getVipsError() ?? "Unknown error"}',
        );
      }

      final size = sizePtr.value;
      final data = Uint8List(size);
      final dataPtr = bufPtr.value.cast<ffi.Uint8>();

      for (var i = 0; i < size; i++) {
        data[i] = dataPtr[i];
      }

      // Free the buffer allocated by vips
      _bindings.g_free(bufPtr.value);

      return data;
    } finally {
      calloc.free(suffixPtr);
      calloc.free(bufPtr);
      calloc.free(sizePtr);
    }
  }

  // ============ Image Processing Operations ============

  /// Resize the image by a scale factor.
  ///
  /// [scale] is the resize factor (e.g., 0.5 for half size, 2.0 for double).
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// Throws [VipsException] if the operation fails.
  VipsImageWrapper resize(double scale) {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      // Use custom binding with NULL terminator for variadic function
      final result = _variadicBindings.resize(_pointer, outPtr, scale);

      if (result != 0) {
        throw VipsException(
          'Failed to resize image. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Rotate the image by an angle in degrees.
  ///
  /// [angle] is the rotation angle in degrees (positive = counter-clockwise).
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// Throws [VipsException] if the operation fails.
  VipsImageWrapper rotate(double angle) {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      // Use custom binding with NULL terminator for variadic function
      final result = _variadicBindings.rotate(_pointer, outPtr, angle);

      if (result != 0) {
        throw VipsException(
          'Failed to rotate image. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Crop a region from the image.
  ///
  /// [left], [top] specify the top-left corner of the crop region.
  /// [width], [height] specify the size of the crop region.
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// Throws [VipsException] if the operation fails.
  VipsImageWrapper crop(int left, int top, int width, int height) {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      // Use custom binding with NULL terminator for variadic function
      final result = _variadicBindings.crop(_pointer, outPtr, left, top, width, height);

      if (result != 0) {
        throw VipsException(
          'Failed to crop image. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Create a thumbnail of the image with a target width.
  ///
  /// This is optimized for creating thumbnails - it will shrink the image
  /// as it loads, making it much faster than loading then resizing.
  ///
  /// [targetWidth] is the desired width in pixels. Height is calculated
  /// to maintain aspect ratio.
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// Throws [VipsException] if the operation fails.
  VipsImageWrapper thumbnail(int targetWidth) {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      // Use custom binding with NULL terminator for variadic function
      final result = _variadicBindings.thumbnailImage(_pointer, outPtr, targetWidth);

      if (result != 0) {
        throw VipsException(
          'Failed to create thumbnail. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  // ============ Static Factory Methods ============

  /// Create a thumbnail directly from a file path.
  ///
  /// This is more efficient than loading then thumbnailing, as it
  /// shrinks the image during load.
  ///
  /// [filename] is the path to the image file.
  /// [targetWidth] is the desired width in pixels.
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// Throws [VipsException] if the operation fails.
  static VipsImageWrapper thumbnailFromFile(String filename, int targetWidth) {
    initVips();
    clearVipsError();

    final filenamePtr = filename.toNativeUtf8();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();

    try {
      // Use custom binding with NULL terminator for variadic function
      final result = _variadicBindings.thumbnail(filenamePtr.cast(), outPtr, targetWidth);

      if (result != 0) {
        throw VipsException(
          'Failed to create thumbnail from file: $filename. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(filenamePtr);
      calloc.free(outPtr);
    }
  }

  /// Create a thumbnail directly from a memory buffer.
  ///
  /// This is more efficient than loading then thumbnailing, as it
  /// shrinks the image during load.
  ///
  /// [data] is the image data in any supported format.
  /// [targetWidth] is the desired width in pixels.
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// Throws [VipsException] if the operation fails.
  static VipsImageWrapper thumbnailFromBuffer(Uint8List data, int targetWidth) {
    initVips();
    clearVipsError();

    final dataPtr = calloc<ffi.Uint8>(data.length);
    final outPtr = calloc<ffi.Pointer<VipsImage>>();

    try {
      // Copy data to native memory
      for (var i = 0; i < data.length; i++) {
        dataPtr[i] = data[i];
      }

      // Use custom binding with NULL terminator for variadic function
      final result = _variadicBindings.thumbnailBuffer(
        dataPtr.cast(),
        data.length,
        outPtr,
        targetWidth,
      );

      if (result != 0) {
        throw VipsException(
          'Failed to create thumbnail from buffer. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(dataPtr);
      calloc.free(outPtr);
    }
  }

  /// Release the image resources.
  ///
  /// After calling dispose, this object should not be used anymore.
  void dispose() {
    if (_disposed) return;
    _bindings.g_object_unref(_pointer.cast());
    _disposed = true;
  }

  void _checkDisposed() {
    if (_disposed) {
      throw StateError('VipsImage has been disposed');
    }
  }
}
