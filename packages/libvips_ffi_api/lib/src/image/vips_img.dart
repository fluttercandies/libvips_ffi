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
  
  // Buffer pointer for images created from buffer (libvips uses lazy evaluation)
  ffi.Pointer<ffi.Uint8>? _bufferPtr;

  VipsImg._(this._pointer, [this._bufferPtr]);

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
  /// 
  /// Note: The buffer data is copied to native memory and kept alive until
  /// this VipsImg is disposed. This is necessary because libvips uses lazy
  /// evaluation and may not decode the image until later operations.
  factory VipsImg.fromBuffer(Uint8List data) {
    clearVipsError();
    final dataPtr = calloc<ffi.Uint8>(data.length);
    dataPtr.asTypedList(data.length).setAll(0, data);
    final ptr = apiBindings.imageNewFromBuffer(
      dataPtr.cast(),
      data.length,
      ''.toNativeUtf8().cast(), // empty option string
    );
    if (ptr == ffi.nullptr) {
      calloc.free(dataPtr);
      throw VipsApiException(
        'Failed to load image from buffer. ${getVipsError() ?? "Unknown error"}',
      );
    }
    // Keep buffer alive until dispose - libvips uses lazy evaluation
    return VipsImg._(ptr, dataPtr);
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

  // ======= Statistics Methods =======

  /// Get average pixel value.
  double avg() {
    _checkDisposed();
    clearVipsError();
    final outPtr = calloc<ffi.Double>();
    try {
      final result = arithmeticBindings.avg(_pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed avg. ${getVipsError() ?? "Unknown error"}');
      }
      return outPtr.value;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Get standard deviation.
  double deviate() {
    _checkDisposed();
    clearVipsError();
    final outPtr = calloc<ffi.Double>();
    try {
      final result = arithmeticBindings.deviate(_pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed deviate. ${getVipsError() ?? "Unknown error"}');
      }
      return outPtr.value;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Get maximum pixel value.
  double max() {
    _checkDisposed();
    clearVipsError();
    final outPtr = calloc<ffi.Double>();
    try {
      final result = arithmeticBindings.max(_pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed max. ${getVipsError() ?? "Unknown error"}');
      }
      return outPtr.value;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Get minimum pixel value.
  double min() {
    _checkDisposed();
    clearVipsError();
    final outPtr = calloc<ffi.Double>();
    try {
      final result = arithmeticBindings.min(_pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed min. ${getVipsError() ?? "Unknown error"}');
      }
      return outPtr.value;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Get pixel values at a point.
  /// Returns a list of values, one per band.
  List<double> getpoint(int x, int y) {
    _checkDisposed();
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<ffi.Double>>();
    final nPtr = calloc<ffi.Int>();
    try {
      final result = arithmeticBindings.getpoint(_pointer, outPtr, nPtr, x, y);
      if (result != 0) {
        throw VipsApiException('Failed getpoint. ${getVipsError() ?? "Unknown error"}');
      }
      final n = nPtr.value;
      final values = <double>[];
      for (int i = 0; i < n; i++) {
        values.add(outPtr.value[i]);
      }
      vipsBindings.g_free(outPtr.value.cast());
      return values;
    } finally {
      calloc.free(outPtr);
      calloc.free(nPtr);
    }
  }

  /// Get image statistics as a new VipsImg.
  /// Returns a matrix with statistics per band.
  VipsImg stats() {
    _checkDisposed();
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = arithmeticBindings.stats(_pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed stats. ${getVipsError() ?? "Unknown error"}');
      }
      return VipsImg.fromPointer(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Find the bounding box of non-background pixels.
  /// Returns (left, top, width, height).
  (int, int, int, int) findTrim() {
    _checkDisposed();
    clearVipsError();
    final leftPtr = calloc<ffi.Int>();
    final topPtr = calloc<ffi.Int>();
    final widthPtr = calloc<ffi.Int>();
    final heightPtr = calloc<ffi.Int>();
    try {
      final result = arithmeticBindings.findTrim(_pointer, leftPtr, topPtr, widthPtr, heightPtr);
      if (result != 0) {
        throw VipsApiException('Failed findTrim. ${getVipsError() ?? "Unknown error"}');
      }
      return (leftPtr.value, topPtr.value, widthPtr.value, heightPtr.value);
    } finally {
      calloc.free(leftPtr);
      calloc.free(topPtr);
      calloc.free(widthPtr);
      calloc.free(heightPtr);
    }
  }

  /// Get histogram entropy.
  double histEntropy() {
    _checkDisposed();
    clearVipsError();
    final outPtr = calloc<ffi.Double>();
    try {
      final result = colourBindings.histEntropy(_pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed histEntropy. ${getVipsError() ?? "Unknown error"}');
      }
      return outPtr.value;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Check if histogram is monotonic.
  bool histIsmonotonic() {
    _checkDisposed();
    clearVipsError();
    final outPtr = calloc<ffi.Int>();
    try {
      final result = colourBindings.histIsmonotonic(_pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed histIsmonotonic. ${getVipsError() ?? "Unknown error"}');
      }
      return outPtr.value != 0;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Dispose the image and free native resources.
  void dispose() {
    if (_disposed) return;
    vipsBindings.g_object_unref(_pointer.cast());
    // Free buffer if this image was created from buffer
    if (_bufferPtr != null) {
      calloc.free(_bufferPtr!);
      _bufferPtr = null;
    }
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
