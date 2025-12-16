import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

// Relational and Boolean operation variadic function types

// ============ Boolean ============
typedef VipsBooleanNative = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int boolean,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsBooleanDart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int boolean,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsBooleanConstNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int boolean,
  ffi.Pointer<ffi.Double> c,
  ffi.Int n,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsBooleanConstDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int boolean,
  ffi.Pointer<ffi.Double> c,
  int n,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsBandboolNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int boolean,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsBandboolDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int boolean,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsBandandNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsBandandDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsBandorNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsBandorDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsBandeorNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsBandeorDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsEqualNative = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsEqualDart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsEqualConstNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  ffi.Int n,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsEqualConstDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  int n,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsEqualConst1Native = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double c,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsEqualConst1Dart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double c,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsNotequalNative = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsNotequalDart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsNotequalConstNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  ffi.Int n,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsNotequalConstDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  int n,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsNotequalConst1Native = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double c,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsNotequalConst1Dart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double c,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsLessNative = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsLessDart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsLessConstNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  ffi.Int n,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsLessConstDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  int n,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsLessConst1Native = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double c,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsLessConst1Dart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double c,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsLesseqNative = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsLesseqDart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsLesseqConstNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  ffi.Int n,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsLesseqConstDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  int n,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsLesseqConst1Native = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double c,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsLesseqConst1Dart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double c,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMoreNative = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMoreDart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMoreConstNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  ffi.Int n,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMoreConstDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  int n,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMoreConst1Native = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double c,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMoreConst1Dart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double c,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMoreeqNative = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMoreeqDart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMoreeqConstNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  ffi.Int n,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMoreeqConstDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  int n,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMoreeqConst1Native = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double c,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMoreeqConst1Dart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double c,
  ffi.Pointer<ffi.Void> terminator,
);

// Boolean operations
typedef VipsAndimageNative = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsAndimageDart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsAndimageConstNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  ffi.Int n,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsAndimageConstDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  int n,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsAndimageConst1Native = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double c,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsAndimageConst1Dart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double c,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsOrimageNative = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsOrimageDart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsOrimageConstNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  ffi.Int n,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsOrimageConstDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  int n,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsOrimageConst1Native = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double c,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsOrimageConst1Dart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double c,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsEorimageNative = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsEorimageDart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsLshiftNative = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsLshiftDart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsLshiftConstNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  ffi.Int n,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsLshiftConstDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  int n,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsLshiftConst1Native = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double c,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsLshiftConst1Dart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double c,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsRshiftNative = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsRshiftDart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsRshiftConstNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  ffi.Int n,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsRshiftConstDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  int n,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsRshiftConst1Native = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double c,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsRshiftConst1Dart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double c,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsIfthenelseNative = ffi.Int Function(
  ffi.Pointer<VipsImage> cond,
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<VipsImage> in2,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsIftheneIseDart = int Function(
  ffi.Pointer<VipsImage> cond,
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<VipsImage> in2,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);
