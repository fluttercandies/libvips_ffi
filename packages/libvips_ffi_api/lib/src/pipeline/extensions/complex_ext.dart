import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import '../../image/vips_img.dart';
import '../../vips_api_init.dart';
import '../vips_pipeline.dart';

/// Complex number operations.
extension VipsComplexExtension on VipsPipeline {
  /// Convert to polar coordinates.
  VipsPipeline polar() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = complexBindings.polar(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed polar. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Convert to rectangular coordinates.
  VipsPipeline rect() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = complexBindings.rect(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed rect. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Complex conjugate.
  VipsPipeline conj() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = complexBindings.conj(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed conj. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Get real part of complex.
  VipsPipeline real() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = complexBindings.real(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed real. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Get imaginary part of complex.
  VipsPipeline imag() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = complexBindings.imag(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed imag. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Form complex from two images.
  VipsPipeline complexform(VipsImg right) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = complexBindings.complexform(image.pointer, right.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed complexform. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Binary complex operation.
  VipsPipeline complex2(VipsImg right, int cmplx) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = complexBindings.complex2(image.pointer, right.pointer, outPtr, cmplx);
      if (result != 0) {
        throw VipsApiException('Failed complex2. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Cross phase correlation.
  VipsPipeline crossPhase(VipsImg right) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = complexBindings.crossPhase(image.pointer, right.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed crossPhase. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }
}
