import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import 'types/relational_types.dart';

/// Relational and Boolean operation bindings.
class VipsRelationalBindings {
  final ffi.DynamicLibrary _lib;

  VipsRelationalBindings(this._lib);

  // Boolean operations (band-wise)
  late final _boolean = _lib.lookup<ffi.NativeFunction<VipsBooleanNative>>('vips_boolean').asFunction<VipsBooleanDart>();
  late final _booleanConst = _lib.lookup<ffi.NativeFunction<VipsBooleanConstNative>>('vips_boolean_const').asFunction<VipsBooleanConstDart>();
  late final _bandbool = _lib.lookup<ffi.NativeFunction<VipsBandboolNative>>('vips_bandbool').asFunction<VipsBandboolDart>();
  late final _bandand = _lib.lookup<ffi.NativeFunction<VipsBandandNative>>('vips_bandand').asFunction<VipsBandandDart>();
  late final _bandor = _lib.lookup<ffi.NativeFunction<VipsBandorNative>>('vips_bandor').asFunction<VipsBandorDart>();
  late final _bandeor = _lib.lookup<ffi.NativeFunction<VipsBandeorNative>>('vips_bandeor').asFunction<VipsBandeorDart>();

  int boolean(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out, int booleanOp) => _boolean(left, right, out, booleanOp, ffi.nullptr);
  int booleanConst(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, int booleanOp, ffi.Pointer<ffi.Double> c, int n) => _booleanConst(in$, out, booleanOp, c, n, ffi.nullptr);
  int bandbool(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, int booleanOp) => _bandbool(in$, out, booleanOp, ffi.nullptr);
  int bandand(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _bandand(in$, out, ffi.nullptr);
  int bandor(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _bandor(in$, out, ffi.nullptr);
  int bandeor(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _bandeor(in$, out, ffi.nullptr);

  // Comparison operations
  late final _equal = _lib.lookup<ffi.NativeFunction<VipsEqualNative>>('vips_equal').asFunction<VipsEqualDart>();
  late final _equalConst = _lib.lookup<ffi.NativeFunction<VipsEqualConstNative>>('vips_equal_const').asFunction<VipsEqualConstDart>();
  late final _equalConst1 = _lib.lookup<ffi.NativeFunction<VipsEqualConst1Native>>('vips_equal_const1').asFunction<VipsEqualConst1Dart>();
  late final _notequal = _lib.lookup<ffi.NativeFunction<VipsNotequalNative>>('vips_notequal').asFunction<VipsNotequalDart>();
  late final _notequalConst = _lib.lookup<ffi.NativeFunction<VipsNotequalConstNative>>('vips_notequal_const').asFunction<VipsNotequalConstDart>();
  late final _notequalConst1 = _lib.lookup<ffi.NativeFunction<VipsNotequalConst1Native>>('vips_notequal_const1').asFunction<VipsNotequalConst1Dart>();
  late final _less = _lib.lookup<ffi.NativeFunction<VipsLessNative>>('vips_less').asFunction<VipsLessDart>();
  late final _lessConst = _lib.lookup<ffi.NativeFunction<VipsLessConstNative>>('vips_less_const').asFunction<VipsLessConstDart>();
  late final _lessConst1 = _lib.lookup<ffi.NativeFunction<VipsLessConst1Native>>('vips_less_const1').asFunction<VipsLessConst1Dart>();
  late final _lesseq = _lib.lookup<ffi.NativeFunction<VipsLesseqNative>>('vips_lesseq').asFunction<VipsLesseqDart>();
  late final _lesseqConst = _lib.lookup<ffi.NativeFunction<VipsLesseqConstNative>>('vips_lesseq_const').asFunction<VipsLesseqConstDart>();
  late final _lesseqConst1 = _lib.lookup<ffi.NativeFunction<VipsLesseqConst1Native>>('vips_lesseq_const1').asFunction<VipsLesseqConst1Dart>();
  late final _more = _lib.lookup<ffi.NativeFunction<VipsMoreNative>>('vips_more').asFunction<VipsMoreDart>();
  late final _moreConst = _lib.lookup<ffi.NativeFunction<VipsMoreConstNative>>('vips_more_const').asFunction<VipsMoreConstDart>();
  late final _moreConst1 = _lib.lookup<ffi.NativeFunction<VipsMoreConst1Native>>('vips_more_const1').asFunction<VipsMoreConst1Dart>();
  late final _moreeq = _lib.lookup<ffi.NativeFunction<VipsMoreeqNative>>('vips_moreeq').asFunction<VipsMoreeqDart>();
  late final _moreeqConst = _lib.lookup<ffi.NativeFunction<VipsMoreeqConstNative>>('vips_moreeq_const').asFunction<VipsMoreeqConstDart>();
  late final _moreeqConst1 = _lib.lookup<ffi.NativeFunction<VipsMoreeqConst1Native>>('vips_moreeq_const1').asFunction<VipsMoreeqConst1Dart>();

  int equal(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _equal(left, right, out, ffi.nullptr);
  int equalConst(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<ffi.Double> c, int n) => _equalConst(in$, out, c, n, ffi.nullptr);
  int equalConst1(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, double c) => _equalConst1(in$, out, c, ffi.nullptr);
  int notequal(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _notequal(left, right, out, ffi.nullptr);
  int notequalConst(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<ffi.Double> c, int n) => _notequalConst(in$, out, c, n, ffi.nullptr);
  int notequalConst1(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, double c) => _notequalConst1(in$, out, c, ffi.nullptr);
  int less(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _less(left, right, out, ffi.nullptr);
  int lessConst(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<ffi.Double> c, int n) => _lessConst(in$, out, c, n, ffi.nullptr);
  int lessConst1(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, double c) => _lessConst1(in$, out, c, ffi.nullptr);
  int lesseq(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _lesseq(left, right, out, ffi.nullptr);
  int lesseqConst(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<ffi.Double> c, int n) => _lesseqConst(in$, out, c, n, ffi.nullptr);
  int lesseqConst1(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, double c) => _lesseqConst1(in$, out, c, ffi.nullptr);
  int more(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _more(left, right, out, ffi.nullptr);
  int moreConst(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<ffi.Double> c, int n) => _moreConst(in$, out, c, n, ffi.nullptr);
  int moreConst1(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, double c) => _moreConst1(in$, out, c, ffi.nullptr);
  int moreeq(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _moreeq(left, right, out, ffi.nullptr);
  int moreeqConst(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<ffi.Double> c, int n) => _moreeqConst(in$, out, c, n, ffi.nullptr);
  int moreeqConst1(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, double c) => _moreeqConst1(in$, out, c, ffi.nullptr);

  // Boolean operations
  late final _andimage = _lib.lookup<ffi.NativeFunction<VipsAndimageNative>>('vips_andimage').asFunction<VipsAndimageDart>();
  late final _andimageConst = _lib.lookup<ffi.NativeFunction<VipsAndimageConstNative>>('vips_andimage_const').asFunction<VipsAndimageConstDart>();
  late final _andimageConst1 = _lib.lookup<ffi.NativeFunction<VipsAndimageConst1Native>>('vips_andimage_const1').asFunction<VipsAndimageConst1Dart>();
  late final _orimage = _lib.lookup<ffi.NativeFunction<VipsOrimageNative>>('vips_orimage').asFunction<VipsOrimageDart>();
  late final _orimageConst = _lib.lookup<ffi.NativeFunction<VipsOrimageConstNative>>('vips_orimage_const').asFunction<VipsOrimageConstDart>();
  late final _orimageConst1 = _lib.lookup<ffi.NativeFunction<VipsOrimageConst1Native>>('vips_orimage_const1').asFunction<VipsOrimageConst1Dart>();
  late final _eorimage = _lib.lookup<ffi.NativeFunction<VipsEorimageNative>>('vips_eorimage').asFunction<VipsEorimageDart>();
  late final _lshift = _lib.lookup<ffi.NativeFunction<VipsLshiftNative>>('vips_lshift').asFunction<VipsLshiftDart>();
  late final _lshiftConst = _lib.lookup<ffi.NativeFunction<VipsLshiftConstNative>>('vips_lshift_const').asFunction<VipsLshiftConstDart>();
  late final _lshiftConst1 = _lib.lookup<ffi.NativeFunction<VipsLshiftConst1Native>>('vips_lshift_const1').asFunction<VipsLshiftConst1Dart>();
  late final _rshift = _lib.lookup<ffi.NativeFunction<VipsRshiftNative>>('vips_rshift').asFunction<VipsRshiftDart>();
  late final _rshiftConst = _lib.lookup<ffi.NativeFunction<VipsRshiftConstNative>>('vips_rshift_const').asFunction<VipsRshiftConstDart>();
  late final _rshiftConst1 = _lib.lookup<ffi.NativeFunction<VipsRshiftConst1Native>>('vips_rshift_const1').asFunction<VipsRshiftConst1Dart>();
  late final _ifthenelse = _lib.lookup<ffi.NativeFunction<VipsIfthenelseNative>>('vips_ifthenelse').asFunction<VipsIftheneIseDart>();

  int andimage(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _andimage(left, right, out, ffi.nullptr);
  int andimageConst(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<ffi.Double> c, int n) => _andimageConst(in$, out, c, n, ffi.nullptr);
  int andimageConst1(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, double c) => _andimageConst1(in$, out, c, ffi.nullptr);
  int orimage(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _orimage(left, right, out, ffi.nullptr);
  int orimageConst(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<ffi.Double> c, int n) => _orimageConst(in$, out, c, n, ffi.nullptr);
  int orimageConst1(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, double c) => _orimageConst1(in$, out, c, ffi.nullptr);
  int eorimage(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _eorimage(left, right, out, ffi.nullptr);
  int lshift(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _lshift(left, right, out, ffi.nullptr);
  int lshiftConst(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<ffi.Double> c, int n) => _lshiftConst(in$, out, c, n, ffi.nullptr);
  int lshiftConst1(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, double c) => _lshiftConst1(in$, out, c, ffi.nullptr);
  int rshift(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _rshift(left, right, out, ffi.nullptr);
  int rshiftConst(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<ffi.Double> c, int n) => _rshiftConst(in$, out, c, n, ffi.nullptr);
  int rshiftConst1(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, double c) => _rshiftConst1(in$, out, c, ffi.nullptr);
  int ifthenelse(ffi.Pointer<VipsImage> cond, ffi.Pointer<VipsImage> in1, ffi.Pointer<VipsImage> in2, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _ifthenelse(cond, in1, in2, out, ffi.nullptr);
}
