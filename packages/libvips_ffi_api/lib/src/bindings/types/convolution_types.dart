import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

// Convolution operation variadic function types

typedef VipsCompassNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<VipsImage> mask,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsCompassDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<VipsImage> mask,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsConvNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<VipsImage> mask,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsConvDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<VipsImage> mask,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsConvaNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<VipsImage> mask,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsConvaDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<VipsImage> mask,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsConvasepNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<VipsImage> mask,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsConvasepDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<VipsImage> mask,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsConvfNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<VipsImage> mask,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsConvfDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<VipsImage> mask,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsConviNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<VipsImage> mask,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsConviDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<VipsImage> mask,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsConvsepNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<VipsImage> mask,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsConvsepDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<VipsImage> mask,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsFastcorNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<VipsImage> ref,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsFastcorDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<VipsImage> ref,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsPrewittNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsPrewittDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsScharrNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsScharrDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsSpcorNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<VipsImage> ref,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsSpcorDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<VipsImage> ref,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);
