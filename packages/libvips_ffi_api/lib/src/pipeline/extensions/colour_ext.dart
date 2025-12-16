import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart'
    hide VipsInterpretation;

import '../../image/vips_img.dart';
import '../../types/enums.dart';
import '../../vips_api_init.dart';
import '../vips_pipeline.dart';

/// Colour operations: colourspace, brightness, contrast, linear.
extension VipsColourExtension on VipsPipeline {
  /// Convert to different colour space.
  VipsPipeline colourspace(VipsInterpretation space) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.colourspace(
        image.pointer, outPtr, space.value,
      );
      if (result != 0) {
        throw VipsApiException(
          'Failed to convert colourspace. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Apply linear transformation: out = in * a + b
  ///
  /// [a]: multiplier
  /// [b]: offset
  VipsPipeline linear(double a, double b) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.linear1(image.pointer, outPtr, a, b);
      if (result != 0) {
        throw VipsApiException(
          'Failed to apply linear. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Adjust brightness.
  ///
  /// [factor]: brightness factor (1.0 = no change, >1.0 = brighter)
  VipsPipeline brightness(double factor) {
    return linear(factor, 0);
  }

  /// Adjust contrast.
  ///
  /// [factor]: contrast factor (1.0 = no change, >1.0 = more contrast)
  VipsPipeline contrast(double factor) {
    return linear(factor, 128 * (1 - factor));
  }

  /// Convert to grayscale.
  VipsPipeline grayscale() {
    return colourspace(VipsInterpretation.bw);
  }

  /// Convert to sRGB.
  VipsPipeline toSrgb() {
    return colourspace(VipsInterpretation.srgb);
  }
}
