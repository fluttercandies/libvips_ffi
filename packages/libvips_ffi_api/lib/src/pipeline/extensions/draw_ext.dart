import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../../image/vips_img.dart';
import '../../vips_api_init.dart';
import '../vips_pipeline.dart';

/// Draw operations (modifies image in-place, returns copy).
extension VipsDrawExtension on VipsPipeline {
  /// Draw a circle.
  VipsPipeline drawCircle(List<double> ink, int cx, int cy, int radius) {
    clearVipsError();
    final inkPtr = calloc<ffi.Double>(ink.length);
    try {
      for (int i = 0; i < ink.length; i++) {
        inkPtr[i] = ink[i];
      }
      final result = drawBindings.drawCircle(image.pointer, inkPtr, ink.length, cx, cy, radius);
      if (result != 0) {
        throw VipsApiException('Failed drawCircle. ${getVipsError() ?? "Unknown error"}');
      }
      return this;
    } finally {
      calloc.free(inkPtr);
    }
  }

  /// Draw a line.
  VipsPipeline drawLine(List<double> ink, int x1, int y1, int x2, int y2) {
    clearVipsError();
    final inkPtr = calloc<ffi.Double>(ink.length);
    try {
      for (int i = 0; i < ink.length; i++) {
        inkPtr[i] = ink[i];
      }
      final result = drawBindings.drawLine(image.pointer, inkPtr, ink.length, x1, y1, x2, y2);
      if (result != 0) {
        throw VipsApiException('Failed drawLine. ${getVipsError() ?? "Unknown error"}');
      }
      return this;
    } finally {
      calloc.free(inkPtr);
    }
  }

  /// Draw a rectangle.
  VipsPipeline drawRect(List<double> ink, int left, int top, int width, int height) {
    clearVipsError();
    final inkPtr = calloc<ffi.Double>(ink.length);
    try {
      for (int i = 0; i < ink.length; i++) {
        inkPtr[i] = ink[i];
      }
      final result = drawBindings.drawRect(image.pointer, inkPtr, ink.length, left, top, width, height);
      if (result != 0) {
        throw VipsApiException('Failed drawRect. ${getVipsError() ?? "Unknown error"}');
      }
      return this;
    } finally {
      calloc.free(inkPtr);
    }
  }

  /// Draw a point.
  VipsPipeline drawPoint(List<double> ink, int x, int y) {
    clearVipsError();
    final inkPtr = calloc<ffi.Double>(ink.length);
    try {
      for (int i = 0; i < ink.length; i++) {
        inkPtr[i] = ink[i];
      }
      final result = drawBindings.drawPoint(image.pointer, inkPtr, ink.length, x, y);
      if (result != 0) {
        throw VipsApiException('Failed drawPoint. ${getVipsError() ?? "Unknown error"}');
      }
      return this;
    } finally {
      calloc.free(inkPtr);
    }
  }

  /// Flood fill.
  VipsPipeline drawFlood(List<double> ink, int x, int y) {
    clearVipsError();
    final inkPtr = calloc<ffi.Double>(ink.length);
    try {
      for (int i = 0; i < ink.length; i++) {
        inkPtr[i] = ink[i];
      }
      final result = drawBindings.drawFlood(image.pointer, inkPtr, ink.length, x, y);
      if (result != 0) {
        throw VipsApiException('Failed drawFlood. ${getVipsError() ?? "Unknown error"}');
      }
      return this;
    } finally {
      calloc.free(inkPtr);
    }
  }

  /// Smudge area.
  VipsPipeline drawSmudge(int left, int top, int width, int height) {
    clearVipsError();
    final result = drawBindings.drawSmudge(image.pointer, left, top, width, height);
    if (result != 0) {
      throw VipsApiException('Failed drawSmudge. ${getVipsError() ?? "Unknown error"}');
    }
    return this;
  }

  /// Draw another image onto this one.
  VipsPipeline drawImage(VipsImg sub, int x, int y) {
    clearVipsError();
    final result = drawBindings.drawImage(image.pointer, sub.pointer, x, y);
    if (result != 0) {
      throw VipsApiException('Failed drawImage. ${getVipsError() ?? "Unknown error"}');
    }
    return this;
  }

  /// Draw with mask.
  VipsPipeline drawMask(List<double> ink, VipsImg mask, int x, int y) {
    clearVipsError();
    final inkPtr = calloc<ffi.Double>(ink.length);
    try {
      for (int i = 0; i < ink.length; i++) {
        inkPtr[i] = ink[i];
      }
      final result = drawBindings.drawMask(image.pointer, inkPtr, ink.length, mask.pointer, x, y);
      if (result != 0) {
        throw VipsApiException('Failed drawMask. ${getVipsError() ?? "Unknown error"}');
      }
      return this;
    } finally {
      calloc.free(inkPtr);
    }
  }
}
