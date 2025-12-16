import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import 'types/arithmetic_types.dart';

/// Arithmetic operation bindings.
class VipsArithmeticBindings {
  final ffi.DynamicLibrary _lib;

  VipsArithmeticBindings(this._lib);

  // Math functions
  late final _ceil = _lib.lookup<ffi.NativeFunction<VipsCeilNative>>('vips_ceil').asFunction<VipsCeilDart>();
  late final _cos = _lib.lookup<ffi.NativeFunction<VipsCosNative>>('vips_cos').asFunction<VipsCosDart>();
  late final _exp = _lib.lookup<ffi.NativeFunction<VipsExpNative>>('vips_exp').asFunction<VipsExpDart>();
  late final _exp10 = _lib.lookup<ffi.NativeFunction<VipsExp10Native>>('vips_exp10').asFunction<VipsExp10Dart>();
  late final _floor = _lib.lookup<ffi.NativeFunction<VipsFloorNative>>('vips_floor').asFunction<VipsFloorDart>();
  late final _log = _lib.lookup<ffi.NativeFunction<VipsLogNative>>('vips_log').asFunction<VipsLogDart>();
  late final _log10 = _lib.lookup<ffi.NativeFunction<VipsLog10Native>>('vips_log10').asFunction<VipsLog10Dart>();
  late final _pow = _lib.lookup<ffi.NativeFunction<VipsPowNative>>('vips_pow').asFunction<VipsPowDart>();
  late final _remainder = _lib.lookup<ffi.NativeFunction<VipsRemainderNative>>('vips_remainder').asFunction<VipsRemainderDart>();
  late final _rint = _lib.lookup<ffi.NativeFunction<VipsRintNative>>('vips_rint').asFunction<VipsRintDart>();
  late final _sin = _lib.lookup<ffi.NativeFunction<VipsSinNative>>('vips_sin').asFunction<VipsSinDart>();
  late final _sum = _lib.lookup<ffi.NativeFunction<VipsSumNative>>('vips_sum').asFunction<VipsSumDart>();
  late final _tan = _lib.lookup<ffi.NativeFunction<VipsTanNative>>('vips_tan').asFunction<VipsTanDart>();
  late final _measure = _lib.lookup<ffi.NativeFunction<VipsMeasureNative>>('vips_measure').asFunction<VipsMeasureDart>();

  int ceil(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _ceil(in$, out, ffi.nullptr);
  int cos(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _cos(in$, out, ffi.nullptr);
  int exp(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _exp(in$, out, ffi.nullptr);
  int exp10(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _exp10(in$, out, ffi.nullptr);
  int floor(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _floor(in$, out, ffi.nullptr);
  int log(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _log(in$, out, ffi.nullptr);
  int log10(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _log10(in$, out, ffi.nullptr);
  int pow(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _pow(left, right, out, ffi.nullptr);
  int remainder(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _remainder(left, right, out, ffi.nullptr);
  int rint(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _rint(in$, out, ffi.nullptr);
  int sin(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _sin(in$, out, ffi.nullptr);
  int sum(ffi.Pointer<ffi.Pointer<VipsImage>> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, int n) => _sum(in$, out, n, ffi.nullptr);
  int tan(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _tan(in$, out, ffi.nullptr);
  int measure(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, int h, int v) => _measure(in$, out, h, v, ffi.nullptr);

  // ============ Basic Arithmetic ============
  late final _add = _lib.lookup<ffi.NativeFunction<VipsAddNative>>('vips_add').asFunction<VipsAddDart>();
  late final _subtract = _lib.lookup<ffi.NativeFunction<VipsSubtractNative>>('vips_subtract').asFunction<VipsSubtractDart>();
  late final _multiply = _lib.lookup<ffi.NativeFunction<VipsMultiplyNative>>('vips_multiply').asFunction<VipsMultiplyDart>();
  late final _divide = _lib.lookup<ffi.NativeFunction<VipsDivideNative>>('vips_divide').asFunction<VipsDivideDart>();

  int add(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _add(left, right, out, ffi.nullptr);

  int subtract(ffi.Pointer<VipsImage> in1, ffi.Pointer<VipsImage> in2, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _subtract(in1, in2, out, ffi.nullptr);

  int multiply(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _multiply(left, right, out, ffi.nullptr);

  int divide(ffi.Pointer<VipsImage> in1, ffi.Pointer<VipsImage> in2, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _divide(in1, in2, out, ffi.nullptr);

  // ============ Unary Operations ============
  late final _abs = _lib.lookup<ffi.NativeFunction<VipsAbsNative>>('vips_abs').asFunction<VipsAbsDart>();
  late final _sign = _lib.lookup<ffi.NativeFunction<VipsSignNative>>('vips_sign').asFunction<VipsSignDart>();

  int abs(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _abs(in$, out, ffi.nullptr);

  int sign(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _sign(in$, out, ffi.nullptr);

  // ============ Math Operations ============
  late final _math = _lib.lookup<ffi.NativeFunction<VipsMathNative>>('vips_math').asFunction<VipsMathDart>();
  late final _math2 = _lib.lookup<ffi.NativeFunction<VipsMath2Native>>('vips_math2').asFunction<VipsMath2Dart>();
  late final _round = _lib.lookup<ffi.NativeFunction<VipsRoundNative>>('vips_round').asFunction<VipsRoundDart>();

  int math(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, int mathOp) =>
      _math(in$, out, mathOp, ffi.nullptr);

  int math2(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out, int math2Op) =>
      _math2(left, right, out, math2Op, ffi.nullptr);

  int round(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, int roundOp) =>
      _round(in$, out, roundOp, ffi.nullptr);

  // ============ Statistics ============
  late final _avg = _lib.lookup<ffi.NativeFunction<VipsAvgNative>>('vips_avg').asFunction<VipsAvgDart>();
  late final _deviate = _lib.lookup<ffi.NativeFunction<VipsDeviateNative>>('vips_deviate').asFunction<VipsDeviateDart>();
  late final _min = _lib.lookup<ffi.NativeFunction<VipsMinNative>>('vips_min').asFunction<VipsMinDart>();
  late final _max = _lib.lookup<ffi.NativeFunction<VipsMaxNative>>('vips_max').asFunction<VipsMaxDart>();
  late final _stats = _lib.lookup<ffi.NativeFunction<VipsStatsNative>>('vips_stats').asFunction<VipsStatsDart>();

  int avg(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Double> out) =>
      _avg(in$, out, ffi.nullptr);

  int deviate(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Double> out) =>
      _deviate(in$, out, ffi.nullptr);

  int min(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Double> out) =>
      _min(in$, out, ffi.nullptr);

  int max(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Double> out) =>
      _max(in$, out, ffi.nullptr);

  int stats(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _stats(in$, out, ffi.nullptr);

  // ============ Utility ============
  late final _getpoint = _lib.lookup<ffi.NativeFunction<VipsGetpointNative>>('vips_getpoint').asFunction<VipsGetpointDart>();
  late final _findTrim = _lib.lookup<ffi.NativeFunction<VipsFindTrimNative>>('vips_find_trim').asFunction<VipsFindTrimDart>();
  late final _maxpair = _lib.lookup<ffi.NativeFunction<VipsMaxpairNative>>('vips_maxpair').asFunction<VipsMaxpairDart>();
  late final _minpair = _lib.lookup<ffi.NativeFunction<VipsMinpairNative>>('vips_minpair').asFunction<VipsMinpairDart>();

  int getpoint(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<ffi.Double>> vector, ffi.Pointer<ffi.Int> n, int x, int y) =>
      _getpoint(in$, vector, n, x, y, ffi.nullptr);

  int findTrim(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Int> left, ffi.Pointer<ffi.Int> top, ffi.Pointer<ffi.Int> width, ffi.Pointer<ffi.Int> height) =>
      _findTrim(in$, left, top, width, height, ffi.nullptr);

  int maxpair(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _maxpair(left, right, out, ffi.nullptr);

  int minpair(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _minpair(left, right, out, ffi.nullptr);

  // ============ Clamp ============
  late final _clamp = _lib.lookup<ffi.NativeFunction<VipsClampNative>>('vips_clamp').asFunction<VipsClampDart>();

  int clamp(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _clamp(in$, out, ffi.nullptr);

  // ============ Hough Transform ============
  late final _houghCircle = _lib.lookup<ffi.NativeFunction<VipsHoughCircleNative>>('vips_hough_circle').asFunction<VipsHoughCircleDart>();
  late final _houghLine = _lib.lookup<ffi.NativeFunction<VipsHoughLineNative>>('vips_hough_line').asFunction<VipsHoughLineDart>();

  int houghCircle(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _houghCircle(in$, out, ffi.nullptr);

  int houghLine(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _houghLine(in$, out, ffi.nullptr);

  // ============ Profile & Project ============
  late final _profile = _lib.lookup<ffi.NativeFunction<VipsProfileNative>>('vips_profile').asFunction<VipsProfileDart>();
  late final _project = _lib.lookup<ffi.NativeFunction<VipsProjectNative>>('vips_project').asFunction<VipsProjectDart>();

  int profile(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> columns, ffi.Pointer<ffi.Pointer<VipsImage>> rows) =>
      _profile(in$, columns, rows, ffi.nullptr);

  int project(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> columns, ffi.Pointer<ffi.Pointer<VipsImage>> rows) =>
      _project(in$, columns, rows, ffi.nullptr);
}
