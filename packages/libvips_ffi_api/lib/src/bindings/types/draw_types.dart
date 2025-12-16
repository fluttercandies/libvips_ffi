import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

// Draw operation variadic function types

typedef VipsDrawRectNative = ffi.Int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Double> ink,
  ffi.Int n,
  ffi.Int left,
  ffi.Int top,
  ffi.Int width,
  ffi.Int height,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsDrawRectDart = int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Double> ink,
  int n,
  int left,
  int top,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsDrawRect1Native = ffi.Int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Double ink,
  ffi.Int left,
  ffi.Int top,
  ffi.Int width,
  ffi.Int height,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsDrawRect1Dart = int Function(
  ffi.Pointer<VipsImage> image,
  double ink,
  int left,
  int top,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsDrawCircleNative = ffi.Int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Double> ink,
  ffi.Int n,
  ffi.Int cx,
  ffi.Int cy,
  ffi.Int radius,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsDrawCircleDart = int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Double> ink,
  int n,
  int cx,
  int cy,
  int radius,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsDrawCircle1Native = ffi.Int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Double ink,
  ffi.Int cx,
  ffi.Int cy,
  ffi.Int radius,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsDrawCircle1Dart = int Function(
  ffi.Pointer<VipsImage> image,
  double ink,
  int cx,
  int cy,
  int radius,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsDrawLineNative = ffi.Int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Double> ink,
  ffi.Int n,
  ffi.Int x1,
  ffi.Int y1,
  ffi.Int x2,
  ffi.Int y2,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsDrawLineDart = int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Double> ink,
  int n,
  int x1,
  int y1,
  int x2,
  int y2,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsDrawLine1Native = ffi.Int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Double ink,
  ffi.Int x1,
  ffi.Int y1,
  ffi.Int x2,
  ffi.Int y2,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsDrawLine1Dart = int Function(
  ffi.Pointer<VipsImage> image,
  double ink,
  int x1,
  int y1,
  int x2,
  int y2,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsDrawMaskNative = ffi.Int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Double> ink,
  ffi.Int n,
  ffi.Pointer<VipsImage> mask,
  ffi.Int x,
  ffi.Int y,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsDrawMaskDart = int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Double> ink,
  int n,
  ffi.Pointer<VipsImage> mask,
  int x,
  int y,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsDrawMask1Native = ffi.Int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Double ink,
  ffi.Pointer<VipsImage> mask,
  ffi.Int x,
  ffi.Int y,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsDrawMask1Dart = int Function(
  ffi.Pointer<VipsImage> image,
  double ink,
  ffi.Pointer<VipsImage> mask,
  int x,
  int y,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsDrawImageNative = ffi.Int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<VipsImage> sub,
  ffi.Int x,
  ffi.Int y,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsDrawImageDart = int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<VipsImage> sub,
  int x,
  int y,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsDrawFloodNative = ffi.Int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Double> ink,
  ffi.Int n,
  ffi.Int x,
  ffi.Int y,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsDrawFloodDart = int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Double> ink,
  int n,
  int x,
  int y,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsDrawFlood1Native = ffi.Int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Double ink,
  ffi.Int x,
  ffi.Int y,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsDrawFlood1Dart = int Function(
  ffi.Pointer<VipsImage> image,
  double ink,
  int x,
  int y,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsDrawSmudgeNative = ffi.Int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Int left,
  ffi.Int top,
  ffi.Int width,
  ffi.Int height,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsDrawSmudgeDart = int Function(
  ffi.Pointer<VipsImage> image,
  int left,
  int top,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsDrawPointNative = ffi.Int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Double> ink,
  ffi.Int n,
  ffi.Int x,
  ffi.Int y,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsDrawPointDart = int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Double> ink,
  int n,
  int x,
  int y,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsDrawPoint1Native = ffi.Int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Double ink,
  ffi.Int x,
  ffi.Int y,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsDrawPoint1Dart = int Function(
  ffi.Pointer<VipsImage> image,
  double ink,
  int x,
  int y,
  ffi.Pointer<ffi.Void> terminator,
);
