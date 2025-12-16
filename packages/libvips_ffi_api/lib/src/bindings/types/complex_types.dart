import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

// Complex operation variadic function types

typedef VipsComplexNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int cmplx,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsComplexDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int cmplx,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsComplex2Native = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int cmplx,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsComplex2Dart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int cmplx,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsComplexformNative = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsComplexformDart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsComplexgetNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int get,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsComplexgetDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int get,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsPolarNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsPolarDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsRectNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsRectDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsConjNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsConjDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsRealNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsRealDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsImagNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsImagDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsCrossPhaseNative = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsCrossPhaseDart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);
