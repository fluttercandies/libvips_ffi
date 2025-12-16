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
}
