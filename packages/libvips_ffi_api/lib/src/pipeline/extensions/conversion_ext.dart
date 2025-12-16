import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart'
    hide VipsBandFormat;

import '../../image/vips_img.dart';
import '../../types/enums.dart';
import '../../vips_api_init.dart';
import '../vips_pipeline.dart';

/// Conversion operations: flatten, cast, copy, extractBand, bandjoinConst.
extension VipsConversionExtension on VipsPipeline {
  /// Flatten alpha channel to background.
  VipsPipeline flatten() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.flatten(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException(
          'Failed to flatten. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Cast image to different format.
  VipsPipeline cast(VipsBandFormat format) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.cast(image.pointer, outPtr, format.value);
      if (result != 0) {
        throw VipsApiException(
          'Failed to cast. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Invert image colours (negative).
  VipsPipeline invert() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.invert(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException(
          'Failed to invert. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Apply gamma correction.
  VipsPipeline gamma() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.gamma(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException(
          'Failed to apply gamma. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Auto-rotate based on EXIF orientation.
  VipsPipeline autoRotate() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.autorot(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException(
          'Failed to auto-rotate. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Extract a single band (channel).
  VipsPipeline extractBand(int band) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.extractBand(image.pointer, outPtr, band);
      if (result != 0) {
        throw VipsApiException(
          'Failed to extract band. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Add constant alpha channel.
  VipsPipeline addAlpha([double alpha = 255.0]) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    final cPtr = calloc<ffi.Double>(1);
    try {
      cPtr[0] = alpha;
      final result = apiBindings.bandjoinConst(image.pointer, outPtr, cPtr, 1);
      if (result != 0) {
        throw VipsApiException(
          'Failed to add alpha. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
      calloc.free(cPtr);
    }
  }
}
