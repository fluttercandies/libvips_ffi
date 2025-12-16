import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import '../../image/vips_img.dart';
import '../../vips_api_init.dart';
import '../vips_pipeline.dart';

/// Frequency domain operations.
extension VipsFrequencyExtension on VipsPipeline {
  /// Forward FFT.
  VipsPipeline fwfft() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = frequencyBindings.fwfft(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed fwfft. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Inverse FFT.
  VipsPipeline invfft() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = frequencyBindings.invfft(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed invfft. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Frequency multiply with mask.
  VipsPipeline freqmult(VipsImg mask) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = frequencyBindings.freqmult(image.pointer, mask.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed freqmult. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Power spectrum.
  VipsPipeline spectrum() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = frequencyBindings.spectrum(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed spectrum. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Phase correlation with another image.
  VipsPipeline phasecor(VipsImg other) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = frequencyBindings.phasecor(image.pointer, other.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed phasecor. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }
}
