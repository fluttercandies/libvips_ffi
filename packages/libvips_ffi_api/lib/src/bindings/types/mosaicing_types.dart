import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

// Mosaicing operation variadic function types

typedef VipsGlobalbalanceNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsGlobalbalanceDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMatchNative = ffi.Int Function(
  ffi.Pointer<VipsImage> ref,
  ffi.Pointer<VipsImage> sec,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int xr1,
  ffi.Int yr1,
  ffi.Int xs1,
  ffi.Int ys1,
  ffi.Int xr2,
  ffi.Int yr2,
  ffi.Int xs2,
  ffi.Int ys2,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMatchDart = int Function(
  ffi.Pointer<VipsImage> ref,
  ffi.Pointer<VipsImage> sec,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int xr1,
  int yr1,
  int xs1,
  int ys1,
  int xr2,
  int yr2,
  int xs2,
  int ys2,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMergeNative = ffi.Int Function(
  ffi.Pointer<VipsImage> ref,
  ffi.Pointer<VipsImage> sec,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int direction,
  ffi.Int dx,
  ffi.Int dy,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMergeDart = int Function(
  ffi.Pointer<VipsImage> ref,
  ffi.Pointer<VipsImage> sec,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int direction,
  int dx,
  int dy,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMosaicNative = ffi.Int Function(
  ffi.Pointer<VipsImage> ref,
  ffi.Pointer<VipsImage> sec,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int direction,
  ffi.Int xref,
  ffi.Int yref,
  ffi.Int xsec,
  ffi.Int ysec,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMosaicDart = int Function(
  ffi.Pointer<VipsImage> ref,
  ffi.Pointer<VipsImage> sec,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int direction,
  int xref,
  int yref,
  int xsec,
  int ysec,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMosaic1Native = ffi.Int Function(
  ffi.Pointer<VipsImage> ref,
  ffi.Pointer<VipsImage> sec,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int direction,
  ffi.Int xr1,
  ffi.Int yr1,
  ffi.Int xs1,
  ffi.Int ys1,
  ffi.Int xr2,
  ffi.Int yr2,
  ffi.Int xs2,
  ffi.Int ys2,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMosaic1Dart = int Function(
  ffi.Pointer<VipsImage> ref,
  ffi.Pointer<VipsImage> sec,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int direction,
  int xr1,
  int yr1,
  int xs1,
  int ys1,
  int xr2,
  int yr2,
  int xs2,
  int ys2,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsRemosaicNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Char> oldStr,
  ffi.Pointer<ffi.Char> newStr,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsRemosaicDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Char> oldStr,
  ffi.Pointer<ffi.Char> newStr,
  ffi.Pointer<ffi.Void> terminator,
);
