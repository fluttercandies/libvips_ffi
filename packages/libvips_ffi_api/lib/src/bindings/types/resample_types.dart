import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

// Resample operation variadic function types

typedef VipsAffineNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double a,
  ffi.Double b,
  ffi.Double c,
  ffi.Double d,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsAffineDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double a,
  double b,
  double c,
  double d,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMapimNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<VipsImage> index,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMapimDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<VipsImage> index,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsQuadraticNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<VipsImage> coeff,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsQuadraticDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<VipsImage> coeff,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsReducehNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double hshrink,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsReducehDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double hshrink,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsReducevNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double vshrink,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsReducevDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double vshrink,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsShrinkhNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int hshrink,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsShrinkhDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int hshrink,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsShrinkVNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int vshrink,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsShrinkVDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int vshrink,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsSimilarityNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsSimilarityDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsThumbnailNative = ffi.Int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsThumbnailDart = int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsThumbnailBufferNative = ffi.Int Function(
  ffi.Pointer<ffi.Void> buf,
  ffi.Size len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsThumbnailBufferDart = int Function(
  ffi.Pointer<ffi.Void> buf,
  int len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsThumbnailSourceNative = ffi.Int Function(
  ffi.Pointer<VipsSource> source,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsThumbnailSourceDart = int Function(
  ffi.Pointer<VipsSource> source,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  ffi.Pointer<ffi.Void> terminator,
);
