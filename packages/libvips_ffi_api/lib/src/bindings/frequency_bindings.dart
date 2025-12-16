import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import 'types/frequency_types.dart';

/// Frequency domain operation bindings.
class VipsFrequencyBindings {
  final ffi.DynamicLibrary _lib;

  VipsFrequencyBindings(this._lib);

  late final _fwfft = _lib.lookup<ffi.NativeFunction<VipsFwfftNative>>('vips_fwfft').asFunction<VipsFwfftDart>();
  late final _invfft = _lib.lookup<ffi.NativeFunction<VipsInvfftNative>>('vips_invfft').asFunction<VipsInvfftDart>();
  late final _freqmult = _lib.lookup<ffi.NativeFunction<VipsFreqmultNative>>('vips_freqmult').asFunction<VipsFreqmultDart>();
  late final _spectrum = _lib.lookup<ffi.NativeFunction<VipsSpectrumNative>>('vips_spectrum').asFunction<VipsSpectrumDart>();
  late final _phasecor = _lib.lookup<ffi.NativeFunction<VipsPhasecorNative>>('vips_phasecor').asFunction<VipsPhasecorDart>();

  int fwfft(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _fwfft(in$, out, ffi.nullptr);

  int invfft(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _invfft(in$, out, ffi.nullptr);

  int freqmult(ffi.Pointer<VipsImage> in$, ffi.Pointer<VipsImage> mask, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _freqmult(in$, mask, out, ffi.nullptr);

  int spectrum(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _spectrum(in$, out, ffi.nullptr);

  int phasecor(ffi.Pointer<VipsImage> in1, ffi.Pointer<VipsImage> in2, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _phasecor(in1, in2, out, ffi.nullptr);
}
