import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import 'types/complex_types.dart';

/// Complex operation bindings.
class VipsComplexBindings {
  final ffi.DynamicLibrary _lib;

  VipsComplexBindings(this._lib);

  late final _complex = _lib.lookup<ffi.NativeFunction<VipsComplexNative>>('vips_complex').asFunction<VipsComplexDart>();
  late final _complex2 = _lib.lookup<ffi.NativeFunction<VipsComplex2Native>>('vips_complex2').asFunction<VipsComplex2Dart>();
  late final _complexform = _lib.lookup<ffi.NativeFunction<VipsComplexformNative>>('vips_complexform').asFunction<VipsComplexformDart>();
  late final _complexget = _lib.lookup<ffi.NativeFunction<VipsComplexgetNative>>('vips_complexget').asFunction<VipsComplexgetDart>();
  late final _polar = _lib.lookup<ffi.NativeFunction<VipsPolarNative>>('vips_polar').asFunction<VipsPolarDart>();
  late final _rect = _lib.lookup<ffi.NativeFunction<VipsRectNative>>('vips_rect').asFunction<VipsRectDart>();
  late final _conj = _lib.lookup<ffi.NativeFunction<VipsConjNative>>('vips_conj').asFunction<VipsConjDart>();
  late final _real = _lib.lookup<ffi.NativeFunction<VipsRealNative>>('vips_real').asFunction<VipsRealDart>();
  late final _imag = _lib.lookup<ffi.NativeFunction<VipsImagNative>>('vips_imag').asFunction<VipsImagDart>();
  late final _crossPhase = _lib.lookup<ffi.NativeFunction<VipsCrossPhaseNative>>('vips_cross_phase').asFunction<VipsCrossPhaseDart>();

  int complex(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, int cmplx) => _complex(in$, out, cmplx, ffi.nullptr);
  int complex2(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out, int cmplx) => _complex2(left, right, out, cmplx, ffi.nullptr);
  int complexform(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _complexform(left, right, out, ffi.nullptr);
  int complexget(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, int get) => _complexget(in$, out, get, ffi.nullptr);
  int polar(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _polar(in$, out, ffi.nullptr);
  int rect(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _rect(in$, out, ffi.nullptr);
  int conj(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _conj(in$, out, ffi.nullptr);
  int real(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _real(in$, out, ffi.nullptr);
  int imag(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _imag(in$, out, ffi.nullptr);
  int crossPhase(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _crossPhase(left, right, out, ffi.nullptr);
}
