import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

// Create operation variadic function types

typedef VipsSinesNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsSinesDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsCompositeNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int n,
  ffi.Pointer<ffi.Int> mode,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsCompositeDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int n,
  ffi.Pointer<ffi.Int> mode,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsEyeNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsEyeDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsZoneNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsZoneDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsPerlinNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsPerlinDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsWorleyNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsWorleyDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsFractsurfNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.Double fractalDimension,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsFractsurfDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  double fractalDimension,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsSdfNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.Int shape,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsSdfDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  int shape,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsIdentityNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsIdentityDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsBuildlutNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsBuildlutDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsInvertlutNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsInvertlutDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsTonelutNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsTonelutDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMaskIdealNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.Double frequencyCutoff,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMaskIdealDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  double frequencyCutoff,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMaskIdealRingNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.Double frequencyCutoff,
  ffi.Double ringwidth,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMaskIdealRingDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  double frequencyCutoff,
  double ringwidth,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMaskIdealBandNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.Double frequencyCutoffX,
  ffi.Double frequencyCutoffY,
  ffi.Double radius,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMaskIdealBandDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  double frequencyCutoffX,
  double frequencyCutoffY,
  double radius,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMaskButterworthNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.Double order,
  ffi.Double frequencyCutoff,
  ffi.Double amplitudeCutoff,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMaskButterworthDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  double order,
  double frequencyCutoff,
  double amplitudeCutoff,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMaskButterworthRingNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.Double order,
  ffi.Double frequencyCutoff,
  ffi.Double amplitudeCutoff,
  ffi.Double ringwidth,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMaskButterworthRingDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  double order,
  double frequencyCutoff,
  double amplitudeCutoff,
  double ringwidth,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMaskButterworthBandNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.Double order,
  ffi.Double frequencyCutoffX,
  ffi.Double frequencyCutoffY,
  ffi.Double radius,
  ffi.Double amplitudeCutoff,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMaskButterworthBandDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  double order,
  double frequencyCutoffX,
  double frequencyCutoffY,
  double radius,
  double amplitudeCutoff,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMaskGaussianNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.Double frequencyCutoff,
  ffi.Double amplitudeCutoff,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMaskGaussianDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  double frequencyCutoff,
  double amplitudeCutoff,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMaskGaussianRingNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.Double frequencyCutoff,
  ffi.Double amplitudeCutoff,
  ffi.Double ringwidth,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMaskGaussianRingDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  double frequencyCutoff,
  double amplitudeCutoff,
  double ringwidth,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMaskGaussianBandNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.Double frequencyCutoffX,
  ffi.Double frequencyCutoffY,
  ffi.Double radius,
  ffi.Double amplitudeCutoff,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMaskGaussianBandDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  double frequencyCutoffX,
  double frequencyCutoffY,
  double radius,
  double amplitudeCutoff,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMaskFractalNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.Double fractalDimension,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMaskFractalDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  double fractalDimension,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsGaussmatNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double sigma,
  ffi.Double minAmpl,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsGaussmatDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double sigma,
  double minAmpl,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsLogmatNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double sigma,
  ffi.Double minAmpl,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsLogmatDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double sigma,
  double minAmpl,
  ffi.Pointer<ffi.Void> terminator,
);
