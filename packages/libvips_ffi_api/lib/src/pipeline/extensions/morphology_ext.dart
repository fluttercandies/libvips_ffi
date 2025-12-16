import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import '../../image/vips_img.dart';
import '../../vips_api_init.dart';
import '../vips_pipeline.dart';

/// Morphology operations.
extension VipsMorphologyExtension on VipsPipeline {
  /// Morphological operation with mask.
  VipsPipeline morph(VipsImg mask, int morph) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = morphologyBindings.morph(image.pointer, outPtr, mask.pointer, morph);
      if (result != 0) {
        throw VipsApiException('Failed morph. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Rank filter.
  VipsPipeline rank(int width, int height, int index) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = morphologyBindings.rank(image.pointer, outPtr, width, height, index);
      if (result != 0) {
        throw VipsApiException('Failed rank. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Median filter (3x3).
  VipsPipeline median([int size = 3]) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = morphologyBindings.median(image.pointer, outPtr, size);
      if (result != 0) {
        throw VipsApiException('Failed median. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Fill nearest pixel values.
  VipsPipeline fillNearest() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = morphologyBindings.fillNearest(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed fillNearest. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Label connected regions.
  VipsPipeline labelregions() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = morphologyBindings.labelregions(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed labelregions. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Erode image with structuring element.
  /// [mask]: Structuring element (VipsImg)
  VipsPipeline erode(VipsImg mask) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      // VIPS_OPERATION_MORPHOLOGY_ERODE = 0
      final result = morphologyBindings.morph(image.pointer, outPtr, mask.pointer, 0);
      if (result != 0) {
        throw VipsApiException('Failed erode. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Dilate image with structuring element.
  /// [mask]: Structuring element (VipsImg)
  VipsPipeline dilate(VipsImg mask) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      // VIPS_OPERATION_MORPHOLOGY_DILATE = 1
      final result = morphologyBindings.morph(image.pointer, outPtr, mask.pointer, 1);
      if (result != 0) {
        throw VipsApiException('Failed dilate. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }
}
