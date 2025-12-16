import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import '../vips_api_init.dart';

/// High-level wrapper for VipsImage pointer.
///
/// This class manages the lifecycle of a native VipsImage pointer.
/// Users should not need to interact with raw pointers when using VipsPipeline.
class VipsImg {
  ffi.Pointer<VipsImage> _pointer;
  bool _disposed = false;

  VipsImg._(this._pointer);

  /// Create from a raw pointer (takes ownership).
  factory VipsImg.fromPointer(ffi.Pointer<VipsImage> pointer) {
    if (pointer == ffi.nullptr) {
      throw VipsApiException('Cannot create VipsImg from null pointer');
    }
    return VipsImg._(pointer);
  }

  /// Load image from file.
  factory VipsImg.fromFile(String path) {
    clearVipsError();
    final pathPtr = path.toNativeUtf8();
    try {
      final ptr = apiBindings.imageNewFromFile(pathPtr.cast());
      if (ptr == ffi.nullptr) {
        throw VipsApiException(
          'Failed to load image: $path. ${getVipsError() ?? "Unknown error"}',
        );
      }
      return VipsImg._(ptr);
    } finally {
      calloc.free(pathPtr);
    }
  }

  /// Load image from buffer.
  factory VipsImg.fromBuffer(Uint8List data) {
    clearVipsError();
    final dataPtr = calloc<ffi.Uint8>(data.length);
    try {
      dataPtr.asTypedList(data.length).setAll(0, data);
      final ptr = apiBindings.imageNewFromBuffer(
        dataPtr.cast(),
        data.length,
        ''.toNativeUtf8().cast(), // empty option string
      );
      if (ptr == ffi.nullptr) {
        throw VipsApiException(
          'Failed to load image from buffer. ${getVipsError() ?? "Unknown error"}',
        );
      }
      return VipsImg._(ptr);
    } finally {
      calloc.free(dataPtr);
    }
  }

  /// Get the raw pointer (for internal use).
  ffi.Pointer<VipsImage> get pointer {
    _checkDisposed();
    return _pointer;
  }

  /// Whether this image has been disposed.
  bool get isDisposed => _disposed;

  /// Image width in pixels.
  int get width {
    _checkDisposed();
    return vipsBindings.vips_image_get_width(_pointer);
  }

  /// Image height in pixels.
  int get height {
    _checkDisposed();
    return vipsBindings.vips_image_get_height(_pointer);
  }

  /// Number of bands (channels).
  int get bands {
    _checkDisposed();
    return vipsBindings.vips_image_get_bands(_pointer);
  }

  /// Image format (raw value).
  int get format {
    _checkDisposed();
    return vipsBindings.vips_image_get_format(_pointer).value;
  }

  /// Image interpretation (colour space, raw value).
  int get interpretation {
    _checkDisposed();
    return vipsBindings.vips_image_get_interpretation(_pointer).value;
  }

  /// Whether the image has an alpha channel.
  bool get hasAlpha {
    _checkDisposed();
    return vipsBindings.vips_image_hasalpha(_pointer) != 0;
  }

  /// Write image to file.
  void writeToFile(String path) {
    _checkDisposed();
    clearVipsError();
    final pathPtr = path.toNativeUtf8();
    try {
      final result = apiBindings.imageWriteToFile(_pointer, pathPtr.cast());
      if (result != 0) {
        throw VipsApiException(
          'Failed to write image: $path. ${getVipsError() ?? "Unknown error"}',
        );
      }
    } finally {
      calloc.free(pathPtr);
    }
  }

  /// Write image to buffer with format suffix.
  Uint8List writeToBuffer(String suffix) {
    _checkDisposed();
    clearVipsError();
    final suffixPtr = suffix.toNativeUtf8();
    final bufPtr = calloc<ffi.Pointer<ffi.Void>>();
    final sizePtr = calloc<ffi.Size>();

    try {
      final result = apiBindings.imageWriteToBuffer(
        _pointer,
        suffixPtr.cast(),
        bufPtr,
        sizePtr,
      );
      if (result != 0) {
        throw VipsApiException(
          'Failed to write to buffer. ${getVipsError() ?? "Unknown error"}',
        );
      }

      final size = sizePtr.value;
      final dataPtr = bufPtr.value.cast<ffi.Uint8>();
      final data = Uint8List.fromList(dataPtr.asTypedList(size));
      vipsBindings.g_free(bufPtr.value);
      return data;
    } finally {
      calloc.free(suffixPtr);
      calloc.free(bufPtr);
      calloc.free(sizePtr);
    }
  }

  /// Create a copy of the image (increments reference count).
  VipsImg copy() {
    _checkDisposed();
    final ref = vipsBindings.g_object_ref(_pointer.cast());
    return VipsImg._(ref.cast());
  }

  /// Dispose the image and free native resources.
  void dispose() {
    if (_disposed) return;
    vipsBindings.g_object_unref(_pointer.cast());
    _disposed = true;
  }

  void _checkDisposed() {
    if (_disposed) {
      throw StateError('VipsImg has been disposed');
    }
  }

  @override
  String toString() {
    if (_disposed) return 'VipsImg(disposed)';
    return 'VipsImg(${width}x$height, $bands bands)';
  }
}
