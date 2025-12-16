import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

// Arithmetic operation variadic function types

// ============ Math Functions ============
typedef VipsCeilNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsCeilDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsCosNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsCosDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsExpNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsExpDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsExp10Native = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsExp10Dart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsFloorNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsFloorDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsLogNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsLogDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsLog10Native = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsLog10Dart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsPowNative = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsPowDart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsRemainderNative = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsRemainderDart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsRintNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsRintDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsSinNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsSinDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsSumNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int n,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsSumDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int n,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsTanNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsTanDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMeasureNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int h,
  ffi.Int v,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMeasureDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int h,
  int v,
  ffi.Pointer<ffi.Void> terminator,
);

// Arithmetic variadic function types

typedef VipsAddNative = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsAddDart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsSubtractNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<VipsImage> in2,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsSubtractDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<VipsImage> in2,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMultiplyNative = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMultiplyDart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsDivideNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<VipsImage> in2,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsDivideDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<VipsImage> in2,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsAbsNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsAbsDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsSignNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsSignDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMathNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int math,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMathDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int math,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMath2Native = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int math2,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMath2Dart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int math2,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsRoundNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int round,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsRoundDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int round,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsAvgNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Double> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsAvgDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Double> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsDeviateNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Double> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsDeviateDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Double> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMinNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Double> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMinDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Double> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMaxNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Double> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMaxDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Double> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsStatsNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsStatsDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsGetpointNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<ffi.Double>> vector,
  ffi.Pointer<ffi.Int> n,
  ffi.Int x,
  ffi.Int y,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsGetpointDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<ffi.Double>> vector,
  ffi.Pointer<ffi.Int> n,
  int x,
  int y,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsFindTrimNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Int> left,
  ffi.Pointer<ffi.Int> top,
  ffi.Pointer<ffi.Int> width,
  ffi.Pointer<ffi.Int> height,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsFindTrimDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Int> left,
  ffi.Pointer<ffi.Int> top,
  ffi.Pointer<ffi.Int> width,
  ffi.Pointer<ffi.Int> height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMaxpairNative = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMaxpairDart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMinpairNative = ffi.Int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMinpairDart = int Function(
  ffi.Pointer<VipsImage> left,
  ffi.Pointer<VipsImage> right,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ Clamp ============
typedef VipsClampNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsClampDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ Hough Transform ============
typedef VipsHoughCircleNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsHoughCircleDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsHoughLineNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsHoughLineDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ Profile & Project ============
typedef VipsProfileNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> columns,
  ffi.Pointer<ffi.Pointer<VipsImage>> rows,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsProfileDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> columns,
  ffi.Pointer<ffi.Pointer<VipsImage>> rows,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsProjectNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> columns,
  ffi.Pointer<ffi.Pointer<VipsImage>> rows,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsProjectDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> columns,
  ffi.Pointer<ffi.Pointer<VipsImage>> rows,
  ffi.Pointer<ffi.Void> terminator,
);
