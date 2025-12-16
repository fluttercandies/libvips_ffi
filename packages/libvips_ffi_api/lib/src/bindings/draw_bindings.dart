import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import 'types/draw_types.dart';

/// Draw operation bindings.
class VipsDrawBindings {
  final ffi.DynamicLibrary _lib;

  VipsDrawBindings(this._lib);

  late final _drawRect = _lib.lookup<ffi.NativeFunction<VipsDrawRectNative>>('vips_draw_rect').asFunction<VipsDrawRectDart>();
  late final _drawRect1 = _lib.lookup<ffi.NativeFunction<VipsDrawRect1Native>>('vips_draw_rect1').asFunction<VipsDrawRect1Dart>();
  late final _drawCircle = _lib.lookup<ffi.NativeFunction<VipsDrawCircleNative>>('vips_draw_circle').asFunction<VipsDrawCircleDart>();
  late final _drawCircle1 = _lib.lookup<ffi.NativeFunction<VipsDrawCircle1Native>>('vips_draw_circle1').asFunction<VipsDrawCircle1Dart>();
  late final _drawLine = _lib.lookup<ffi.NativeFunction<VipsDrawLineNative>>('vips_draw_line').asFunction<VipsDrawLineDart>();
  late final _drawLine1 = _lib.lookup<ffi.NativeFunction<VipsDrawLine1Native>>('vips_draw_line1').asFunction<VipsDrawLine1Dart>();
  late final _drawMask = _lib.lookup<ffi.NativeFunction<VipsDrawMaskNative>>('vips_draw_mask').asFunction<VipsDrawMaskDart>();
  late final _drawMask1 = _lib.lookup<ffi.NativeFunction<VipsDrawMask1Native>>('vips_draw_mask1').asFunction<VipsDrawMask1Dart>();
  late final _drawImage = _lib.lookup<ffi.NativeFunction<VipsDrawImageNative>>('vips_draw_image').asFunction<VipsDrawImageDart>();
  late final _drawFlood = _lib.lookup<ffi.NativeFunction<VipsDrawFloodNative>>('vips_draw_flood').asFunction<VipsDrawFloodDart>();
  late final _drawFlood1 = _lib.lookup<ffi.NativeFunction<VipsDrawFlood1Native>>('vips_draw_flood1').asFunction<VipsDrawFlood1Dart>();
  late final _drawSmudge = _lib.lookup<ffi.NativeFunction<VipsDrawSmudgeNative>>('vips_draw_smudge').asFunction<VipsDrawSmudgeDart>();
  late final _drawPoint = _lib.lookup<ffi.NativeFunction<VipsDrawPointNative>>('vips_draw_point').asFunction<VipsDrawPointDart>();
  late final _drawPoint1 = _lib.lookup<ffi.NativeFunction<VipsDrawPoint1Native>>('vips_draw_point1').asFunction<VipsDrawPoint1Dart>();

  int drawRect(ffi.Pointer<VipsImage> image, ffi.Pointer<ffi.Double> ink, int n, int left, int top, int width, int height) =>
      _drawRect(image, ink, n, left, top, width, height, ffi.nullptr);

  int drawRect1(ffi.Pointer<VipsImage> image, double ink, int left, int top, int width, int height) =>
      _drawRect1(image, ink, left, top, width, height, ffi.nullptr);

  int drawCircle(ffi.Pointer<VipsImage> image, ffi.Pointer<ffi.Double> ink, int n, int cx, int cy, int radius) =>
      _drawCircle(image, ink, n, cx, cy, radius, ffi.nullptr);

  int drawCircle1(ffi.Pointer<VipsImage> image, double ink, int cx, int cy, int radius) =>
      _drawCircle1(image, ink, cx, cy, radius, ffi.nullptr);

  int drawLine(ffi.Pointer<VipsImage> image, ffi.Pointer<ffi.Double> ink, int n, int x1, int y1, int x2, int y2) =>
      _drawLine(image, ink, n, x1, y1, x2, y2, ffi.nullptr);

  int drawLine1(ffi.Pointer<VipsImage> image, double ink, int x1, int y1, int x2, int y2) =>
      _drawLine1(image, ink, x1, y1, x2, y2, ffi.nullptr);

  int drawMask(ffi.Pointer<VipsImage> image, ffi.Pointer<ffi.Double> ink, int n, ffi.Pointer<VipsImage> mask, int x, int y) =>
      _drawMask(image, ink, n, mask, x, y, ffi.nullptr);

  int drawMask1(ffi.Pointer<VipsImage> image, double ink, ffi.Pointer<VipsImage> mask, int x, int y) =>
      _drawMask1(image, ink, mask, x, y, ffi.nullptr);

  int drawImage(ffi.Pointer<VipsImage> image, ffi.Pointer<VipsImage> sub, int x, int y) =>
      _drawImage(image, sub, x, y, ffi.nullptr);

  int drawFlood(ffi.Pointer<VipsImage> image, ffi.Pointer<ffi.Double> ink, int n, int x, int y) =>
      _drawFlood(image, ink, n, x, y, ffi.nullptr);

  int drawFlood1(ffi.Pointer<VipsImage> image, double ink, int x, int y) =>
      _drawFlood1(image, ink, x, y, ffi.nullptr);

  int drawSmudge(ffi.Pointer<VipsImage> image, int left, int top, int width, int height) =>
      _drawSmudge(image, left, top, width, height, ffi.nullptr);

  int drawPoint(ffi.Pointer<VipsImage> image, ffi.Pointer<ffi.Double> ink, int n, int x, int y) =>
      _drawPoint(image, ink, n, x, y, ffi.nullptr);

  int drawPoint1(ffi.Pointer<VipsImage> image, double ink, int x, int y) =>
      _drawPoint1(image, ink, x, y, ffi.nullptr);
}
