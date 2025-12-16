import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import '../../image/vips_img.dart';
import '../../vips_api_init.dart';
import '../vips_pipeline.dart';

/// Convolution operations: blur, sharpen, sobel, canny.
extension VipsConvolutionExtension on VipsPipeline {
  /// Apply Gaussian blur.
  ///
  /// [sigma]: standard deviation of Gaussian (larger = more blur)
  /// Typical values: 1.0 to 10.0
  VipsPipeline blur(double sigma) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.gaussblur(image.pointer, outPtr, sigma);
      if (result != 0) {
        throw VipsApiException(
          'Failed to blur. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Alias for blur.
  VipsPipeline gaussianBlur(double sigma) => blur(sigma);

  /// Sharpen image using unsharp masking.
  VipsPipeline sharpen() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.sharpen(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException(
          'Failed to sharpen. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Apply Sobel edge detection.
  VipsPipeline sobel() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.sobel(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException(
          'Failed to apply sobel. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Apply Canny edge detection.
  VipsPipeline canny() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.canny(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException(
          'Failed to apply canny. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }
}
