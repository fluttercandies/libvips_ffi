import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import 'types/convolution_types.dart';

/// Convolution operation bindings.
class VipsConvolutionBindings {
  final ffi.DynamicLibrary _lib;

  VipsConvolutionBindings(this._lib);

  late final _compass = _lib.lookup<ffi.NativeFunction<VipsCompassNative>>('vips_compass').asFunction<VipsCompassDart>();
  late final _conv = _lib.lookup<ffi.NativeFunction<VipsConvNative>>('vips_conv').asFunction<VipsConvDart>();
  late final _conva = _lib.lookup<ffi.NativeFunction<VipsConvaNative>>('vips_conva').asFunction<VipsConvaDart>();
  late final _convasep = _lib.lookup<ffi.NativeFunction<VipsConvasepNative>>('vips_convasep').asFunction<VipsConvasepDart>();
  late final _convf = _lib.lookup<ffi.NativeFunction<VipsConvfNative>>('vips_convf').asFunction<VipsConvfDart>();
  late final _convi = _lib.lookup<ffi.NativeFunction<VipsConviNative>>('vips_convi').asFunction<VipsConviDart>();
  late final _convsep = _lib.lookup<ffi.NativeFunction<VipsConvsepNative>>('vips_convsep').asFunction<VipsConvsepDart>();
  late final _fastcor = _lib.lookup<ffi.NativeFunction<VipsFastcorNative>>('vips_fastcor').asFunction<VipsFastcorDart>();
  late final _prewitt = _lib.lookup<ffi.NativeFunction<VipsPrewittNative>>('vips_prewitt').asFunction<VipsPrewittDart>();
  late final _scharr = _lib.lookup<ffi.NativeFunction<VipsScharrNative>>('vips_scharr').asFunction<VipsScharrDart>();
  late final _spcor = _lib.lookup<ffi.NativeFunction<VipsSpcorNative>>('vips_spcor').asFunction<VipsSpcorDart>();

  int compass(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<VipsImage> mask) => _compass(in$, out, mask, ffi.nullptr);
  int conv(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<VipsImage> mask) => _conv(in$, out, mask, ffi.nullptr);
  int conva(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<VipsImage> mask) => _conva(in$, out, mask, ffi.nullptr);
  int convasep(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<VipsImage> mask) => _convasep(in$, out, mask, ffi.nullptr);
  int convf(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<VipsImage> mask) => _convf(in$, out, mask, ffi.nullptr);
  int convi(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<VipsImage> mask) => _convi(in$, out, mask, ffi.nullptr);
  int convsep(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<VipsImage> mask) => _convsep(in$, out, mask, ffi.nullptr);
  int fastcor(ffi.Pointer<VipsImage> in$, ffi.Pointer<VipsImage> ref, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _fastcor(in$, ref, out, ffi.nullptr);
  int prewitt(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _prewitt(in$, out, ffi.nullptr);
  int scharr(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _scharr(in$, out, ffi.nullptr);
  int spcor(ffi.Pointer<VipsImage> in$, ffi.Pointer<VipsImage> ref, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _spcor(in$, ref, out, ffi.nullptr);
}
