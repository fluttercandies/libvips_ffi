import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart'
    hide VipsBlendMode, VipsDirection;

import '../../image/vips_img.dart';
import '../../types/enums.dart';
import '../../vips_api_init.dart';
import '../vips_pipeline.dart';

/// Composite operations: insert, join, composite.
extension VipsCompositeExtension on VipsPipeline {
  /// Insert sub-image at position.
  ///
  /// [sub]: image to insert (will be disposed after operation)
  /// [x], [y]: position to insert at
  VipsPipeline insert(VipsImg sub, int x, int y) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.insert(
        image.pointer, sub.pointer, outPtr, x, y,
      );
      if (result != 0) {
        throw VipsApiException(
          'Failed to insert. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      sub.dispose();
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Join two images together.
  ///
  /// [other]: image to join (will be disposed after operation)
  /// [direction]: horizontal (0) or vertical (1)
  VipsPipeline join(VipsImg other, VipsDirection direction) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.join(
        image.pointer, other.pointer, outPtr, direction.value,
      );
      if (result != 0) {
        throw VipsApiException(
          'Failed to join. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      other.dispose();
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Join horizontally.
  VipsPipeline joinHorizontal(VipsImg other) {
    return join(other, VipsDirection.horizontal);
  }

  /// Join vertically.
  VipsPipeline joinVertical(VipsImg other) {
    return join(other, VipsDirection.vertical);
  }

  /// Composite overlay onto base image.
  ///
  /// [overlay]: image to composite (will be disposed after operation)
  /// [mode]: blend mode
  VipsPipeline composite(VipsImg overlay, VipsBlendMode mode) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.composite2(
        image.pointer, overlay.pointer, outPtr, mode.value,
      );
      if (result != 0) {
        throw VipsApiException(
          'Failed to composite. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      overlay.dispose();
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Composite with "over" blend mode.
  VipsPipeline compositeOver(VipsImg overlay) {
    return composite(overlay, VipsBlendMode.over);
  }
}
