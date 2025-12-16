import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import 'types/mosaicing_types.dart';

/// Mosaicing operation bindings.
class VipsMosaicingBindings {
  final ffi.DynamicLibrary _lib;

  VipsMosaicingBindings(this._lib);

  late final _globalbalance = _lib.lookup<ffi.NativeFunction<VipsGlobalbalanceNative>>('vips_globalbalance').asFunction<VipsGlobalbalanceDart>();
  late final _match = _lib.lookup<ffi.NativeFunction<VipsMatchNative>>('vips_match').asFunction<VipsMatchDart>();
  late final _merge = _lib.lookup<ffi.NativeFunction<VipsMergeNative>>('vips_merge').asFunction<VipsMergeDart>();
  late final _mosaic = _lib.lookup<ffi.NativeFunction<VipsMosaicNative>>('vips_mosaic').asFunction<VipsMosaicDart>();
  late final _mosaic1 = _lib.lookup<ffi.NativeFunction<VipsMosaic1Native>>('vips_mosaic1').asFunction<VipsMosaic1Dart>();
  late final _remosaic = _lib.lookup<ffi.NativeFunction<VipsRemosaicNative>>('vips_remosaic').asFunction<VipsRemosaicDart>();

  int globalbalance(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _globalbalance(in$, out, ffi.nullptr);
  int match(ffi.Pointer<VipsImage> ref, ffi.Pointer<VipsImage> sec, ffi.Pointer<ffi.Pointer<VipsImage>> out, int xr1, int yr1, int xs1, int ys1, int xr2, int yr2, int xs2, int ys2) => _match(ref, sec, out, xr1, yr1, xs1, ys1, xr2, yr2, xs2, ys2, ffi.nullptr);
  int merge(ffi.Pointer<VipsImage> ref, ffi.Pointer<VipsImage> sec, ffi.Pointer<ffi.Pointer<VipsImage>> out, int direction, int dx, int dy) => _merge(ref, sec, out, direction, dx, dy, ffi.nullptr);
  int mosaic(ffi.Pointer<VipsImage> ref, ffi.Pointer<VipsImage> sec, ffi.Pointer<ffi.Pointer<VipsImage>> out, int direction, int xref, int yref, int xsec, int ysec) => _mosaic(ref, sec, out, direction, xref, yref, xsec, ysec, ffi.nullptr);
  int mosaic1(ffi.Pointer<VipsImage> ref, ffi.Pointer<VipsImage> sec, ffi.Pointer<ffi.Pointer<VipsImage>> out, int direction, int xr1, int yr1, int xs1, int ys1, int xr2, int yr2, int xs2, int ys2) => _mosaic1(ref, sec, out, direction, xr1, yr1, xs1, ys1, xr2, yr2, xs2, ys2, ffi.nullptr);
  int remosaic(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<ffi.Char> oldStr, ffi.Pointer<ffi.Char> newStr) => _remosaic(in$, out, oldStr, newStr, ffi.nullptr);
}
