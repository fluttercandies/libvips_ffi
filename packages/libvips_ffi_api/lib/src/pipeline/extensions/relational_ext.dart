import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import '../../image/vips_img.dart';
import '../../vips_api_init.dart';
import '../vips_pipeline.dart';

/// Relational and band-wise boolean operations.
extension VipsRelationalExtension on VipsPipeline {
  /// Band-wise AND across all bands.
  VipsPipeline bandand() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = relationalBindings.bandand(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed bandand. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Band-wise OR across all bands.
  VipsPipeline bandor() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = relationalBindings.bandor(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed bandor. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Band-wise EOR (XOR) across all bands.
  VipsPipeline bandeor() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = relationalBindings.bandeor(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed bandeor. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  // ============ Two-Image Comparisons ============

  /// Equal comparison with another image.
  VipsPipeline equal(VipsImg other) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = relationalBindings.equal(image.pointer, other.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed equal. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Not equal comparison with another image.
  VipsPipeline notequal(VipsImg other) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = relationalBindings.notequal(image.pointer, other.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed notequal. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Less than comparison with another image.
  VipsPipeline less(VipsImg other) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = relationalBindings.less(image.pointer, other.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed less. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Less than or equal comparison with another image.
  VipsPipeline lesseq(VipsImg other) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = relationalBindings.lesseq(image.pointer, other.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed lesseq. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Greater than comparison with another image.
  VipsPipeline more(VipsImg other) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = relationalBindings.more(image.pointer, other.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed more. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Greater than or equal comparison with another image.
  VipsPipeline moreeq(VipsImg other) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = relationalBindings.moreeq(image.pointer, other.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed moreeq. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }
}
