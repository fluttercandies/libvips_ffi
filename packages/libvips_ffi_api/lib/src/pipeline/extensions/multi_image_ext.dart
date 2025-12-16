import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import '../../image/vips_img.dart';
import '../../vips_api_init.dart';
import '../vips_pipeline.dart';

/// Multi-image operations that take an array of images.
///
/// These operations combine multiple images into one.
/// The current pipeline image is used as the first image in the array.
extension VipsMultiImageExtension on VipsPipeline {
  /// Join multiple images into one multi-band image.
  ///
  /// [images]: Additional images to join (current image is first)
  VipsPipeline bandjoinMulti(List<VipsImg> images) {
    clearVipsError();
    final totalCount = 1 + images.length;
    final inPtr = calloc<ffi.Pointer<VipsImage>>(totalCount);
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      inPtr[0] = image.pointer;
      for (int i = 0; i < images.length; i++) {
        inPtr[i + 1] = images[i].pointer;
      }
      final result = conversionBindings.bandjoin(inPtr, outPtr, totalCount);
      if (result != 0) {
        throw VipsApiException('Failed bandjoinMulti. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(inPtr);
      calloc.free(outPtr);
    }
  }

  /// Join two images into one multi-band image.
  VipsPipeline bandjoin2(VipsImg other) {
    clearVipsError();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = conversionBindings.bandjoin2(image.pointer, other.pointer, outPtr);
      if (result != 0) {
        throw VipsApiException('Failed bandjoin2. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Composite multiple images with blend modes.
  ///
  /// [images]: Overlay images to composite
  /// [modes]: Blend mode for each overlay image
  VipsPipeline compositeMulti(List<VipsImg> images, List<int> modes) {
    if (images.length != modes.length) {
      throw ArgumentError('images and modes must have same length');
    }
    clearVipsError();
    final totalCount = 1 + images.length;
    final inPtr = calloc<ffi.Pointer<VipsImage>>(totalCount);
    final modesPtr = calloc<ffi.Int>(modes.length);
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      inPtr[0] = image.pointer;
      for (int i = 0; i < images.length; i++) {
        inPtr[i + 1] = images[i].pointer;
        modesPtr[i] = modes[i];
      }
      final result = createBindings.composite(inPtr, outPtr, totalCount, modesPtr);
      if (result != 0) {
        throw VipsApiException('Failed compositeMulti. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(inPtr);
      calloc.free(modesPtr);
      calloc.free(outPtr);
    }
  }

  /// Sum multiple images pixel-wise.
  ///
  /// [images]: Additional images to sum (current image is first)
  VipsPipeline sumMulti(List<VipsImg> images) {
    clearVipsError();
    final totalCount = 1 + images.length;
    final inPtr = calloc<ffi.Pointer<VipsImage>>(totalCount);
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      inPtr[0] = image.pointer;
      for (int i = 0; i < images.length; i++) {
        inPtr[i + 1] = images[i].pointer;
      }
      final result = arithmeticBindings.sum(inPtr, outPtr, totalCount);
      if (result != 0) {
        throw VipsApiException('Failed sumMulti. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(inPtr);
      calloc.free(outPtr);
    }
  }

  /// Array join images into a grid.
  ///
  /// [images]: Additional images to join (current image is first)
  VipsPipeline arrayjoin(List<VipsImg> images) {
    clearVipsError();
    final totalCount = 1 + images.length;
    final inPtr = calloc<ffi.Pointer<VipsImage>>(totalCount);
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      inPtr[0] = image.pointer;
      for (int i = 0; i < images.length; i++) {
        inPtr[i + 1] = images[i].pointer;
      }
      final result = conversionBindings.arrayjoin(inPtr, outPtr, totalCount);
      if (result != 0) {
        throw VipsApiException('Failed arrayjoin. ${getVipsError() ?? "Unknown error"}');
      }
      replaceImage(VipsImg.fromPointer(outPtr.value));
      return this;
    } finally {
      calloc.free(inPtr);
      calloc.free(outPtr);
    }
  }
}

/// Static methods for creating images from multiple sources.
class VipsMultiImage {
  VipsMultiImage._();

  /// Join multiple images into one multi-band image.
  static VipsImg bandjoin(List<VipsImg> images) {
    if (images.isEmpty) {
      throw ArgumentError('images cannot be empty');
    }
    clearVipsError();
    final inPtr = calloc<ffi.Pointer<VipsImage>>(images.length);
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      for (int i = 0; i < images.length; i++) {
        inPtr[i] = images[i].pointer;
      }
      final result = conversionBindings.bandjoin(inPtr, outPtr, images.length);
      if (result != 0) {
        throw VipsApiException('Failed bandjoin. ${getVipsError() ?? "Unknown error"}');
      }
      return VipsImg.fromPointer(outPtr.value);
    } finally {
      calloc.free(inPtr);
      calloc.free(outPtr);
    }
  }

  /// Sum multiple images pixel-wise.
  static VipsImg sum(List<VipsImg> images) {
    if (images.isEmpty) {
      throw ArgumentError('images cannot be empty');
    }
    clearVipsError();
    final inPtr = calloc<ffi.Pointer<VipsImage>>(images.length);
    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      for (int i = 0; i < images.length; i++) {
        inPtr[i] = images[i].pointer;
      }
      final result = arithmeticBindings.sum(inPtr, outPtr, images.length);
      if (result != 0) {
        throw VipsApiException('Failed sum. ${getVipsError() ?? "Unknown error"}');
      }
      return VipsImg.fromPointer(outPtr.value);
    } finally {
      calloc.free(inPtr);
      calloc.free(outPtr);
    }
  }

}
