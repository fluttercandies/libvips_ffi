import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart'
    hide VipsDirection, VipsCompassDirection;

import '../../image/vips_img.dart';
import '../../types/enums.dart';
import '../../vips_api_init.dart';
import '../vips_pipeline.dart';

/// Geometry operations: crop, flip, embed, extractArea, smartCrop, gravity, zoom.
extension VipsGeometryExtension on VipsPipeline {
  /// Crop a region from the image.
  ///
  /// [left], [top]: top-left corner of crop region
  /// [width], [height]: size of crop region
  VipsPipeline crop(int left, int top, int width, int height) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.crop(
        image.pointer, outPtr, left, top, width, height,
      );
      if (result != 0) {
        throw VipsApiException(
          'Failed to crop. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Flip image horizontally or vertically.
  VipsPipeline flip(VipsDirection direction) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.flip(image.pointer, outPtr, direction.value);
      if (result != 0) {
        throw VipsApiException(
          'Failed to flip. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Flip image horizontally.
  VipsPipeline flipHorizontal() => flip(VipsDirection.horizontal);

  /// Flip image vertically.
  VipsPipeline flipVertical() => flip(VipsDirection.vertical);

  /// Embed image in larger canvas.
  ///
  /// [x], [y]: position of image in new canvas
  /// [width], [height]: size of new canvas
  VipsPipeline embed(int x, int y, int width, int height) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.embed(
        image.pointer, outPtr, x, y, width, height,
      );
      if (result != 0) {
        throw VipsApiException(
          'Failed to embed. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Extract area from image (alias for crop).
  VipsPipeline extractArea(int left, int top, int width, int height) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.extractArea(
        image.pointer, outPtr, left, top, width, height,
      );
      if (result != 0) {
        throw VipsApiException(
          'Failed to extract area. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Smart crop to target size (finds interesting region).
  VipsPipeline smartCrop(int width, int height) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.smartcrop(image.pointer, outPtr, width, height);
      if (result != 0) {
        throw VipsApiException(
          'Failed to smart crop. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Place image at compass direction in canvas.
  VipsPipeline gravity(VipsCompassDirection direction, int width, int height) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.gravity(
        image.pointer, outPtr, direction.value, width, height,
      );
      if (result != 0) {
        throw VipsApiException(
          'Failed to apply gravity. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Zoom image by integer factors (pixel replication).
  VipsPipeline zoom(int xfac, int yfac) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.zoom(image.pointer, outPtr, xfac, yfac);
      if (result != 0) {
        throw VipsApiException(
          'Failed to zoom. ${getVipsError() ?? "Unknown error"}',
        );
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Join two images side by side.
  VipsPipeline join(VipsImg in2, int direction) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.join(image.pointer, in2.pointer, outPtr, direction);
      if (result != 0) {
        throw VipsApiException('Failed join. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Insert one image into another.
  VipsPipeline insert(VipsImg sub, int x, int y) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = apiBindings.insert(image.pointer, sub.pointer, outPtr, x, y);
      if (result != 0) {
        throw VipsApiException('Failed insert. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }
}
