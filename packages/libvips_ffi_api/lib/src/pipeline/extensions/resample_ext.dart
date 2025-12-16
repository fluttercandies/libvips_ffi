import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import '../../image/vips_img.dart';
import '../../vips_api_init.dart';
import '../vips_pipeline.dart';

/// Resample operations: resize, thumbnail, rotate, reduce, shrink.
extension VipsResampleExtension on VipsPipeline {
  /// Resize image by scale factor.
  ///
  /// [scale]: resize factor (0.5 = half size, 2.0 = double)
  VipsPipeline resize(double scale) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.resize(image.pointer, outPtr, scale);
      if (result != 0) {
        throw VipsApiException(
          'Failed to resize. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Rotate image by angle in degrees.
  ///
  /// [angle]: rotation angle (positive = counter-clockwise)
  VipsPipeline rotate(double angle) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.rotate(image.pointer, outPtr, angle);
      if (result != 0) {
        throw VipsApiException(
          'Failed to rotate. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Create thumbnail with target width.
  ///
  /// [width]: target width in pixels
  VipsPipeline thumbnail(int width) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.thumbnailImage(image.pointer, outPtr, width);
      if (result != 0) {
        throw VipsApiException(
          'Failed to thumbnail. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Reduce image size by factor (fast, no interpolation).
  ///
  /// [hshrink]: horizontal shrink factor
  /// [vshrink]: vertical shrink factor
  VipsPipeline reduce(double hshrink, double vshrink) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.reduce(image.pointer, outPtr, hshrink, vshrink);
      if (result != 0) {
        throw VipsApiException(
          'Failed to reduce. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Shrink image by integer factors.
  ///
  /// [hshrink]: horizontal shrink factor
  /// [vshrink]: vertical shrink factor
  VipsPipeline shrink(double hshrink, double vshrink) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.shrink(image.pointer, outPtr, hshrink, vshrink);
      if (result != 0) {
        throw VipsApiException(
          'Failed to shrink. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Affine transform.
  ///
  /// [a], [b], [c], [d]: transformation matrix elements
  VipsPipeline affine(double a, double b, double c, double d) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = resampleBindings.affine(image.pointer, outPtr, a, b, c, d);
      if (result != 0) {
        throw VipsApiException('Failed affine. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Map image coordinates through index image.
  VipsPipeline mapim(VipsImg index) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = resampleBindings.mapim(image.pointer, outPtr, index.pointer);
      if (result != 0) {
        throw VipsApiException('Failed mapim. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Similarity transform (scale and rotate).
  VipsPipeline similarity() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = resampleBindings.similarity(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed similarity. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Reduce horizontally.
  VipsPipeline reduceh(double hshrink) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = resampleBindings.reduceh(image.pointer, outPtr, hshrink);
      if (result != 0) {
        throw VipsApiException('Failed reduceh. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Reduce vertically.
  VipsPipeline reducev(double vshrink) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = resampleBindings.reducev(image.pointer, outPtr, vshrink);
      if (result != 0) {
        throw VipsApiException('Failed reducev. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Shrink horizontally by integer factor.
  VipsPipeline shrinkh(int hshrink) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = resampleBindings.shrinkh(image.pointer, outPtr, hshrink);
      if (result != 0) {
        throw VipsApiException('Failed shrinkh. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Shrink vertically by integer factor.
  VipsPipeline shrinkv(int vshrink) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = resampleBindings.shrinkv(image.pointer, outPtr, vshrink);
      if (result != 0) {
        throw VipsApiException('Failed shrinkv. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }
}
