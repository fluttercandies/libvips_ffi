import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import 'types/morphology_types.dart';

/// Morphology operation bindings.
class VipsMorphologyBindings {
  final ffi.DynamicLibrary _lib;

  VipsMorphologyBindings(this._lib);

  late final _morph = _lib.lookup<ffi.NativeFunction<VipsMorphNative>>('vips_morph').asFunction<VipsMorphDart>();
  late final _rank = _lib.lookup<ffi.NativeFunction<VipsRankNative>>('vips_rank').asFunction<VipsRankDart>();
  late final _median = _lib.lookup<ffi.NativeFunction<VipsMedianNative>>('vips_median').asFunction<VipsMedianDart>();
  late final _countlines = _lib.lookup<ffi.NativeFunction<VipsCountlinesNative>>('vips_countlines').asFunction<VipsCountlinesDart>();
  late final _labelregions = _lib.lookup<ffi.NativeFunction<VipsLabelregionsNative>>('vips_labelregions').asFunction<VipsLabelregionsDart>();
  late final _fillNearest = _lib.lookup<ffi.NativeFunction<VipsFillNearestNative>>('vips_fill_nearest').asFunction<VipsFillNearestDart>();

  int morph(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<VipsImage> mask, int morphOp) =>
      _morph(in$, out, mask, morphOp, ffi.nullptr);

  int rank(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height, int index) =>
      _rank(in$, out, width, height, index, ffi.nullptr);

  int median(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, int size) =>
      _median(in$, out, size, ffi.nullptr);

  int countlines(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Double> nolines, int direction) =>
      _countlines(in$, nolines, direction, ffi.nullptr);

  int labelregions(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> mask) =>
      _labelregions(in$, mask, ffi.nullptr);

  int fillNearest(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _fillNearest(in$, out, ffi.nullptr);
}
