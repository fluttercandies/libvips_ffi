import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import '../../image/vips_img.dart';
import '../../vips_api_init.dart';
import '../vips_pipeline.dart';

/// Boolean and bitwise operations.
extension VipsBooleanExtension on VipsPipeline {
  /// Boolean AND with another image.
  VipsPipeline booleanAnd(VipsImg other) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      // VIPS_OPERATION_BOOLEAN_AND = 0
      final result = relationalBindings.boolean(image.pointer, other.pointer, outPtr, 0);
      if (result != 0) {
        throw VipsApiException('Failed booleanAnd. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Boolean OR with another image.
  VipsPipeline booleanOr(VipsImg other) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      // VIPS_OPERATION_BOOLEAN_OR = 1
      final result = relationalBindings.boolean(image.pointer, other.pointer, outPtr, 1);
      if (result != 0) {
        throw VipsApiException('Failed booleanOr. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Boolean EOR (XOR) with another image.
  VipsPipeline booleanEor(VipsImg other) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      // VIPS_OPERATION_BOOLEAN_EOR = 2
      final result = relationalBindings.boolean(image.pointer, other.pointer, outPtr, 2);
      if (result != 0) {
        throw VipsApiException('Failed booleanEor. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Left shift with another image.
  VipsPipeline booleanLshift(VipsImg other) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      // VIPS_OPERATION_BOOLEAN_LSHIFT = 3
      final result = relationalBindings.boolean(image.pointer, other.pointer, outPtr, 3);
      if (result != 0) {
        throw VipsApiException('Failed booleanLshift. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Right shift with another image.
  VipsPipeline booleanRshift(VipsImg other) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      // VIPS_OPERATION_BOOLEAN_RSHIFT = 4
      final result = relationalBindings.boolean(image.pointer, other.pointer, outPtr, 4);
      if (result != 0) {
        throw VipsApiException('Failed booleanRshift. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }
}
