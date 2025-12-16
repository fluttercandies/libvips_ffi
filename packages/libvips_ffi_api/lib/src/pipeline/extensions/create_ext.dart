import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import '../../image/vips_img.dart';
import '../../vips_api_init.dart';
import '../vips_pipeline.dart';

/// Create operations: black, text, gaussnoise, xyz, grey.
/// These are static factory methods that create new pipelines.
extension VipsCreateExtension on VipsPipeline {
  /// Create a black image.
  static VipsPipeline black(int width, int height) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.black(outPtr, width, height);
      if (result != 0) {
        throw VipsApiException(
          'Failed to create black image. ${getVipsError() ?? "Unknown error"}',
        );
      }
      return VipsPipeline.fromImage(VipsImg.fromPointer(outPtr.value));
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Create a text image.
  static VipsPipeline text(String text) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    final textPtr = text.toNativeUtf8();
    try {
      final result = apiBindings.text(outPtr, textPtr.cast());
      if (result != 0) {
        throw VipsApiException(
          'Failed to create text image. ${getVipsError() ?? "Unknown error"}',
        );
      }
      return VipsPipeline.fromImage(VipsImg.fromPointer(outPtr.value));
    } finally {
      calloc.free(outPtr);
      calloc.free(textPtr);
    }
  }

  /// Create a Gaussian noise image.
  static VipsPipeline gaussnoise(int width, int height) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.gaussnoise(outPtr, width, height);
      if (result != 0) {
        throw VipsApiException(
          'Failed to create noise image. ${getVipsError() ?? "Unknown error"}',
        );
      }
      return VipsPipeline.fromImage(VipsImg.fromPointer(outPtr.value));
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Create an XYZ coordinate image.
  static VipsPipeline xyz(int width, int height) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.xyz(outPtr, width, height);
      if (result != 0) {
        throw VipsApiException(
          'Failed to create xyz image. ${getVipsError() ?? "Unknown error"}',
        );
      }
      return VipsPipeline.fromImage(VipsImg.fromPointer(outPtr.value));
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Create a grey ramp image.
  static VipsPipeline grey(int width, int height) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.grey(outPtr, width, height);
      if (result != 0) {
        throw VipsApiException(
          'Failed to create grey image. ${getVipsError() ?? "Unknown error"}',
        );
      }
      return VipsPipeline.fromImage(VipsImg.fromPointer(outPtr.value));
    } finally {
      calloc.free(outPtr);
    }
  }
}
