import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import '../../image/vips_img.dart';
import '../../vips_api_init.dart';
import '../vips_pipeline.dart';

/// Mosaicing operations: globalbalance.
extension VipsMosaicingExtension on VipsPipeline {
  /// Global balance (for mosaics).
  VipsPipeline globalbalance() {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = mosaicingBindings.globalbalance(image.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed globalbalance. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }
}
