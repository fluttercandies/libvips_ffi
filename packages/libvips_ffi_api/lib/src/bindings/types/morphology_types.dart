import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

// Morphology operation variadic function types

typedef VipsMorphNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<VipsImage> mask,
  ffi.Int morph,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMorphDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<VipsImage> mask,
  int morph,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsRankNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.Int index,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsRankDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  int index,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMedianNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int size,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMedianDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int size,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsCountlinesNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Double> nolines,
  ffi.Int direction,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsCountlinesDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Double> nolines,
  int direction,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsLabelregionsNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> mask,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsLabelregionsDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> mask,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsFillNearestNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsFillNearestDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsBandrankNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int n,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsBandrankDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int n,
  ffi.Pointer<ffi.Void> terminator,
);
