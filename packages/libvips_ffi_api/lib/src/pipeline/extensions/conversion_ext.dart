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

  // ============ Rotation ============

  /// Rotate 90 degrees clockwise.
  VipsPipeline rot90() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = conversionBindings.rot90(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed rot90. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Rotate 180 degrees.
  VipsPipeline rot180() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = conversionBindings.rot180(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed rot180. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Rotate 270 degrees clockwise (90 counter-clockwise).
  VipsPipeline rot270() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = conversionBindings.rot270(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed rot270. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Copy image.
  VipsPipeline copy() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = conversionBindings.copy(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed copy. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Premultiply alpha channel.
  VipsPipeline premultiply() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = conversionBindings.premultiply(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed premultiply. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Unpremultiply alpha channel.
  VipsPipeline unpremultiply() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = conversionBindings.unpremultiply(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed unpremultiply. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Replicate image.
  VipsPipeline replicate(int across, int down) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = conversionBindings.replicate(image.pointer, outPtr, across, down);
      if (result != 0) {
        throw VipsApiException('Failed replicate. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Band mean (average all bands).
  VipsPipeline bandmean() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = conversionBindings.bandmean(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed bandmean. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Band fold.
  VipsPipeline bandfold() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = conversionBindings.bandfold(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed bandfold. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Band unfold.
  VipsPipeline bandunfold() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = conversionBindings.bandunfold(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed bandunfold. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Byte swap.
  VipsPipeline byteswap() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = conversionBindings.byteswap(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed byteswap. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Scale image.
  VipsPipeline scale() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = conversionBindings.scale(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed scale. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Sequential access.
  VipsPipeline sequential() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = conversionBindings.sequential(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed sequential. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Subsample image.
  VipsPipeline subsample(int xfac, int yfac) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = conversionBindings.subsample(image.pointer, outPtr, xfac, yfac);
      if (result != 0) {
        throw VipsApiException('Failed subsample. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Wrap image.
  VipsPipeline wrap() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = conversionBindings.wrap(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed wrap. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Most significant byte.
  VipsPipeline msb() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = conversionBindings.msb(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed msb. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Rotate 45 degrees.
  VipsPipeline rot45() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = conversionBindings.rot45(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed rot45. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }
}
