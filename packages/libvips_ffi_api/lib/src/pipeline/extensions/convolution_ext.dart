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

  /// Apply Prewitt edge detection.
  VipsPipeline prewitt() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = convolutionBindings.prewitt(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed prewitt. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Apply Scharr edge detection.
  VipsPipeline scharr() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = convolutionBindings.scharr(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed scharr. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Convolution with kernel.
  VipsPipeline conv(VipsImg kernel) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = convolutionBindings.conv(image.pointer, outPtr, kernel.pointer);
      if (result != 0) {
        throw VipsApiException('Failed conv. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Integer convolution.
  VipsPipeline convi(VipsImg kernel) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = convolutionBindings.convi(image.pointer, outPtr, kernel.pointer);
      if (result != 0) {
        throw VipsApiException('Failed convi. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Float convolution.
  VipsPipeline convf(VipsImg kernel) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = convolutionBindings.convf(image.pointer, outPtr, kernel.pointer);
      if (result != 0) {
        throw VipsApiException('Failed convf. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Compass edge detection.
  VipsPipeline compass(VipsImg mask) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = convolutionBindings.compass(image.pointer, outPtr, mask.pointer);
      if (result != 0) {
        throw VipsApiException('Failed compass. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Fast correlation.
  VipsPipeline fastcor(VipsImg ref) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = convolutionBindings.fastcor(image.pointer, ref.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed fastcor. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Spatial correlation.
  VipsPipeline spcor(VipsImg ref) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = convolutionBindings.spcor(image.pointer, ref.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed spcor. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Separable convolution.
  VipsPipeline convsep(VipsImg mask) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = convolutionBindings.convsep(image.pointer, outPtr, mask.pointer);
      if (result != 0) {
        throw VipsApiException('Failed convsep. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Approximate separable convolution.
  VipsPipeline convasep(VipsImg mask) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = convolutionBindings.convasep(image.pointer, outPtr, mask.pointer);
      if (result != 0) {
        throw VipsApiException('Failed convasep. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Approximate convolution.
  VipsPipeline conva(VipsImg mask) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = convolutionBindings.conva(image.pointer, outPtr, mask.pointer);
      if (result != 0) {
        throw VipsApiException('Failed conva. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }
}
