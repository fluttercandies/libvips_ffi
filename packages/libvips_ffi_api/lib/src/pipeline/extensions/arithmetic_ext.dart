import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import '../../image/vips_img.dart';
import '../../vips_api_init.dart';
import '../vips_pipeline.dart';

/// Arithmetic operations: math functions.
extension VipsArithmeticExtension on VipsPipeline {
  /// Ceiling (round up).
  VipsPipeline ceil() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = arithmeticBindings.ceil(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed ceil. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Floor (round down).
  VipsPipeline floor() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = arithmeticBindings.floor(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed floor. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Round to nearest integer.
  VipsPipeline rint() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = arithmeticBindings.rint(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed rint. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Cosine.
  VipsPipeline cos() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = arithmeticBindings.cos(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed cos. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Sine.
  VipsPipeline sin() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = arithmeticBindings.sin(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed sin. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Tangent.
  VipsPipeline tan() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = arithmeticBindings.tan(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed tan. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Exponential (e^x).
  VipsPipeline exp() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = arithmeticBindings.exp(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed exp. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Exponential base 10 (10^x).
  VipsPipeline exp10() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = arithmeticBindings.exp10(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed exp10. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Natural logarithm.
  VipsPipeline log() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = arithmeticBindings.log(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed log. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Logarithm base 10.
  VipsPipeline log10() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = arithmeticBindings.log10(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed log10. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Absolute value.
  VipsPipeline abs() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = arithmeticBindings.abs(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed abs. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Sign of pixels (-1, 0, or 1).
  VipsPipeline sign() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = arithmeticBindings.sign(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed sign. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  // ============ Two-Image Operations ============

  /// Add another image.
  VipsPipeline add(VipsImg other) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = arithmeticBindings.add(image.pointer, other.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed add. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Subtract another image.
  VipsPipeline subtract(VipsImg other) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = arithmeticBindings.subtract(image.pointer, other.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed subtract. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Multiply by another image.
  VipsPipeline multiply(VipsImg other) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = arithmeticBindings.multiply(image.pointer, other.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed multiply. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Divide by another image.
  VipsPipeline divide(VipsImg other) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = arithmeticBindings.divide(image.pointer, other.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed divide. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Maximum of two images pixel-wise.
  VipsPipeline maxpair(VipsImg other) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = arithmeticBindings.maxpair(image.pointer, other.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed maxpair. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Minimum of two images pixel-wise.
  VipsPipeline minpair(VipsImg other) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = arithmeticBindings.minpair(image.pointer, other.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed minpair. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }
}
