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

  // ============ Color Space Conversions ============

  /// Convert CMC to LCh.
  VipsPipeline cmc2LCh() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.cmc2LCh(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed cmc2LCh. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Convert CMYK to XYZ.
  VipsPipeline cmyk2XYZ() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.cmyk2XYZ(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed cmyk2XYZ. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Convert HSV to sRGB.
  VipsPipeline hsv2sRGB() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.hsv2sRGB(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed hsv2sRGB. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Convert sRGB to HSV.
  VipsPipeline sRGB2HSV() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.sRGB2HSV(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed sRGB2HSV. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Convert Lab to XYZ.
  VipsPipeline lab2XYZ() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.lab2XYZ(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed lab2XYZ. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Convert XYZ to Lab.
  VipsPipeline xyz2Lab() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.xyz2Lab(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed xyz2Lab. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Convert scRGB to sRGB.
  VipsPipeline scRGB2sRGB() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.scRGB2sRGB(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed scRGB2sRGB. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Convert sRGB to scRGB.
  VipsPipeline sRGB2scRGB() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.sRGB2scRGB(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed sRGB2scRGB. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Convert LCh to CMC.
  VipsPipeline lch2CMC() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.lch2CMC(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed lch2CMC. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Convert LCh to Lab.
  VipsPipeline lch2Lab() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.lch2Lab(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed lch2Lab. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Convert Lab to LCh.
  VipsPipeline lab2LCh() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.lab2LCh(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed lab2LCh. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Convert XYZ to CMYK.
  VipsPipeline xyz2CMYK() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.xyz2CMYK(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed xyz2CMYK. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Convert XYZ to scRGB.
  VipsPipeline xyz2scRGB() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.xyz2scRGB(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed xyz2scRGB. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Convert scRGB to XYZ.
  VipsPipeline scRGB2XYZ() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.scRGB2XYZ(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed scRGB2XYZ. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Convert scRGB to BW.
  VipsPipeline scRGB2BW() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.scRGB2BW(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed scRGB2BW. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// False colour transform.
  VipsPipeline falsecolour() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.falsecolour(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed falsecolour. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }
}
