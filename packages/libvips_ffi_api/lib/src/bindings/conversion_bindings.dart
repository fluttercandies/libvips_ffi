import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import 'types/conversion_types.dart';

/// Conversion operation bindings.
class VipsConversionBindings {
  final ffi.DynamicLibrary _lib;

  VipsConversionBindings(this._lib);

  late final _addalpha = _lib.lookup<ffi.NativeFunction<VipsAddAlphaNative>>('vips_addalpha').asFunction<VipsAddAlphaDart>();
  late final _bandfold = _lib.lookup<ffi.NativeFunction<VipsBandfoldNative>>('vips_bandfold').asFunction<VipsBandfoldDart>();
  late final _bandjoin = _lib.lookup<ffi.NativeFunction<VipsBandjoinNative>>('vips_bandjoin').asFunction<VipsBandjoinDart>();
  late final _bandjoin2 = _lib.lookup<ffi.NativeFunction<VipsBandjoin2Native>>('vips_bandjoin2').asFunction<VipsBandjoin2Dart>();
  late final _bandmean = _lib.lookup<ffi.NativeFunction<VipsBandmeanNative>>('vips_bandmean').asFunction<VipsBandmeanDart>();
  late final _bandunfold = _lib.lookup<ffi.NativeFunction<VipsBandunfoldNative>>('vips_bandunfold').asFunction<VipsBandunfoldDart>();
  late final _byteswap = _lib.lookup<ffi.NativeFunction<VipsByteswapNative>>('vips_byteswap').asFunction<VipsByteswapDart>();
  late final _copy = _lib.lookup<ffi.NativeFunction<VipsCopyNative>>('vips_copy').asFunction<VipsCopyDart>();
  late final _grid = _lib.lookup<ffi.NativeFunction<VipsGridNative>>('vips_grid').asFunction<VipsGridDart>();
  late final _msb = _lib.lookup<ffi.NativeFunction<VipsMsbNative>>('vips_msb').asFunction<VipsMsbDart>();
  late final _premultiply = _lib.lookup<ffi.NativeFunction<VipsPremultiplyNative>>('vips_premultiply').asFunction<VipsPremultiplyDart>();
  late final _replicate = _lib.lookup<ffi.NativeFunction<VipsReplicateNative>>('vips_replicate').asFunction<VipsReplicateDart>();
  late final _rot = _lib.lookup<ffi.NativeFunction<VipsRotNative>>('vips_rot').asFunction<VipsRotDart>();
  late final _rot45 = _lib.lookup<ffi.NativeFunction<VipsRot45Native>>('vips_rot45').asFunction<VipsRot45Dart>();
  late final _scale = _lib.lookup<ffi.NativeFunction<VipsScaleNative>>('vips_scale').asFunction<VipsScaleDart>();
  late final _sequential = _lib.lookup<ffi.NativeFunction<VipsSequentialNative>>('vips_sequential').asFunction<VipsSequentialDart>();
  late final _subsample = _lib.lookup<ffi.NativeFunction<VipsSubsampleNative>>('vips_subsample').asFunction<VipsSubsampleDart>();
  late final _transpose3d = _lib.lookup<ffi.NativeFunction<VipsTranspose3dNative>>('vips_transpose3d').asFunction<VipsTranspose3dDart>();
  late final _unpremultiply = _lib.lookup<ffi.NativeFunction<VipsUnpremultiplyNative>>('vips_unpremultiply').asFunction<VipsUnpremultiplyDart>();
  late final _wrap = _lib.lookup<ffi.NativeFunction<VipsWrapNative>>('vips_wrap').asFunction<VipsWrapDart>();

  int addalpha(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _addalpha(in$, out, ffi.nullptr);
  int bandfold(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _bandfold(in$, out, ffi.nullptr);
  int bandjoin(ffi.Pointer<ffi.Pointer<VipsImage>> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, int n) => _bandjoin(in$, out, n, ffi.nullptr);
  int bandjoin2(ffi.Pointer<VipsImage> in1, ffi.Pointer<VipsImage> in2, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _bandjoin2(in1, in2, out, ffi.nullptr);
  int bandmean(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _bandmean(in$, out, ffi.nullptr);
  int bandunfold(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _bandunfold(in$, out, ffi.nullptr);
  int byteswap(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _byteswap(in$, out, ffi.nullptr);
  int copy(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _copy(in$, out, ffi.nullptr);
  int grid(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, int tileHeight, int across, int down) => _grid(in$, out, tileHeight, across, down, ffi.nullptr);
  int msb(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _msb(in$, out, ffi.nullptr);
  int premultiply(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _premultiply(in$, out, ffi.nullptr);
  int replicate(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, int across, int down) => _replicate(in$, out, across, down, ffi.nullptr);
  int rot(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, int angle) => _rot(in$, out, angle, ffi.nullptr);
  int rot45(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _rot45(in$, out, ffi.nullptr);
  int scale(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _scale(in$, out, ffi.nullptr);
  int sequential(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _sequential(in$, out, ffi.nullptr);
  int subsample(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, int xfac, int yfac) => _subsample(in$, out, xfac, yfac, ffi.nullptr);
  int transpose3d(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _transpose3d(in$, out, ffi.nullptr);
  int unpremultiply(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _unpremultiply(in$, out, ffi.nullptr);
  int wrap(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _wrap(in$, out, ffi.nullptr);

  late final _rot90 = _lib.lookup<ffi.NativeFunction<VipsRot90Native>>('vips_rot90').asFunction<VipsRot90Dart>();
  late final _rot180 = _lib.lookup<ffi.NativeFunction<VipsRot180Native>>('vips_rot180').asFunction<VipsRot180Dart>();
  late final _rot270 = _lib.lookup<ffi.NativeFunction<VipsRot270Native>>('vips_rot270').asFunction<VipsRot270Dart>();

  int rot90(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _rot90(in$, out, ffi.nullptr);
  int rot180(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _rot180(in$, out, ffi.nullptr);
  int rot270(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _rot270(in$, out, ffi.nullptr);
}
