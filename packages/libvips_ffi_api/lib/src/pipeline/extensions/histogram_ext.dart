import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import '../../image/vips_img.dart';
import '../../vips_api_init.dart';
import '../vips_pipeline.dart';

/// Histogram operations.
extension VipsHistogramExtension on VipsPipeline {
  /// Cumulative histogram.
  VipsPipeline histCum() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.histCum(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed histCum. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Normalize histogram.
  VipsPipeline histNorm() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.histNorm(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed histNorm. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Histogram equalization.
  VipsPipeline histEqual() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.histEqual(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed histEqual. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Find histogram.
  VipsPipeline histFind() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.histFind(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed histFind. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// N-dimensional histogram.
  VipsPipeline histFindNdim() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.histFindNdim(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed histFindNdim. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Local histogram equalization.
  VipsPipeline histLocal(int width, int height) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.histLocal(image.pointer, outPtr, width, height);
      if (result != 0) {
        throw VipsApiException('Failed histLocal. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Plot histogram.
  VipsPipeline histPlot() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.histPlot(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed histPlot. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Map through lookup table.
  VipsPipeline maplut(VipsImg lut) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.maplut(image.pointer, outPtr, lut.pointer);
      if (result != 0) {
        throw VipsApiException('Failed maplut. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Histogram match with reference.
  VipsPipeline histMatch(VipsImg ref) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.histMatch(image.pointer, ref.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed histMatch. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Statistical difference.
  VipsPipeline stdif(int width, int height) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = colourBindings.stdif(image.pointer, outPtr, width, height);
      if (result != 0) {
        throw VipsApiException('Failed stdif. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }
}
