import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import 'types/create_types.dart';

/// Create operation bindings.
class VipsCreateBindings {
  final ffi.DynamicLibrary _lib;

  VipsCreateBindings(this._lib);

  late final _sines = _lib.lookup<ffi.NativeFunction<VipsSinesNative>>('vips_sines').asFunction<VipsSinesDart>();
  late final _composite = _lib.lookup<ffi.NativeFunction<VipsCompositeNative>>('vips_composite').asFunction<VipsCompositeDart>();
  late final _eye = _lib.lookup<ffi.NativeFunction<VipsEyeNative>>('vips_eye').asFunction<VipsEyeDart>();
  late final _zone = _lib.lookup<ffi.NativeFunction<VipsZoneNative>>('vips_zone').asFunction<VipsZoneDart>();
  late final _perlin = _lib.lookup<ffi.NativeFunction<VipsPerlinNative>>('vips_perlin').asFunction<VipsPerlinDart>();
  late final _worley = _lib.lookup<ffi.NativeFunction<VipsWorleyNative>>('vips_worley').asFunction<VipsWorleyDart>();
  late final _fractsurf = _lib.lookup<ffi.NativeFunction<VipsFractsurfNative>>('vips_fractsurf').asFunction<VipsFractsurfDart>();
  late final _sdf = _lib.lookup<ffi.NativeFunction<VipsSdfNative>>('vips_sdf').asFunction<VipsSdfDart>();
  late final _identity = _lib.lookup<ffi.NativeFunction<VipsIdentityNative>>('vips_identity').asFunction<VipsIdentityDart>();
  late final _buildlut = _lib.lookup<ffi.NativeFunction<VipsBuildlutNative>>('vips_buildlut').asFunction<VipsBuildlutDart>();
  late final _invertlut = _lib.lookup<ffi.NativeFunction<VipsInvertlutNative>>('vips_invertlut').asFunction<VipsInvertlutDart>();
  late final _tonelut = _lib.lookup<ffi.NativeFunction<VipsTonelutNative>>('vips_tonelut').asFunction<VipsTonelutDart>();
  late final _maskIdeal = _lib.lookup<ffi.NativeFunction<VipsMaskIdealNative>>('vips_mask_ideal').asFunction<VipsMaskIdealDart>();
  late final _maskIdealRing = _lib.lookup<ffi.NativeFunction<VipsMaskIdealRingNative>>('vips_mask_ideal_ring').asFunction<VipsMaskIdealRingDart>();
  late final _maskIdealBand = _lib.lookup<ffi.NativeFunction<VipsMaskIdealBandNative>>('vips_mask_ideal_band').asFunction<VipsMaskIdealBandDart>();
  late final _maskButterworth = _lib.lookup<ffi.NativeFunction<VipsMaskButterworthNative>>('vips_mask_butterworth').asFunction<VipsMaskButterworthDart>();
  late final _maskButterworthRing = _lib.lookup<ffi.NativeFunction<VipsMaskButterworthRingNative>>('vips_mask_butterworth_ring').asFunction<VipsMaskButterworthRingDart>();
  late final _maskButterworthBand = _lib.lookup<ffi.NativeFunction<VipsMaskButterworthBandNative>>('vips_mask_butterworth_band').asFunction<VipsMaskButterworthBandDart>();
  late final _maskGaussian = _lib.lookup<ffi.NativeFunction<VipsMaskGaussianNative>>('vips_mask_gaussian').asFunction<VipsMaskGaussianDart>();
  late final _maskGaussianRing = _lib.lookup<ffi.NativeFunction<VipsMaskGaussianRingNative>>('vips_mask_gaussian_ring').asFunction<VipsMaskGaussianRingDart>();
  late final _maskGaussianBand = _lib.lookup<ffi.NativeFunction<VipsMaskGaussianBandNative>>('vips_mask_gaussian_band').asFunction<VipsMaskGaussianBandDart>();
  late final _maskFractal = _lib.lookup<ffi.NativeFunction<VipsMaskFractalNative>>('vips_mask_fractal').asFunction<VipsMaskFractalDart>();
  late final _gaussmat = _lib.lookup<ffi.NativeFunction<VipsGaussmatNative>>('vips_gaussmat').asFunction<VipsGaussmatDart>();
  late final _logmat = _lib.lookup<ffi.NativeFunction<VipsLogmatNative>>('vips_logmat').asFunction<VipsLogmatDart>();

  int sines(ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height) => _sines(out, width, height, ffi.nullptr);
  int composite(ffi.Pointer<ffi.Pointer<VipsImage>> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, int n, ffi.Pointer<ffi.Int> mode) => _composite(in$, out, n, mode, ffi.nullptr);
  int eye(ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height) => _eye(out, width, height, ffi.nullptr);
  int zone(ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height) => _zone(out, width, height, ffi.nullptr);
  int perlin(ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height) => _perlin(out, width, height, ffi.nullptr);
  int worley(ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height) => _worley(out, width, height, ffi.nullptr);
  int fractsurf(ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height, double fractalDimension) => _fractsurf(out, width, height, fractalDimension, ffi.nullptr);
  int sdf(ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height, int shape) => _sdf(out, width, height, shape, ffi.nullptr);
  int identity(ffi.Pointer<ffi.Pointer<VipsImage>> out) => _identity(out, ffi.nullptr);
  int buildlut(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _buildlut(in$, out, ffi.nullptr);
  int invertlut(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _invertlut(in$, out, ffi.nullptr);
  int tonelut(ffi.Pointer<ffi.Pointer<VipsImage>> out) => _tonelut(out, ffi.nullptr);
  int maskIdeal(ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height, double frequencyCutoff) => _maskIdeal(out, width, height, frequencyCutoff, ffi.nullptr);
  int maskIdealRing(ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height, double frequencyCutoff, double ringwidth) => _maskIdealRing(out, width, height, frequencyCutoff, ringwidth, ffi.nullptr);
  int maskIdealBand(ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height, double frequencyCutoffX, double frequencyCutoffY, double radius) => _maskIdealBand(out, width, height, frequencyCutoffX, frequencyCutoffY, radius, ffi.nullptr);
  int maskButterworth(ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height, double order, double frequencyCutoff, double amplitudeCutoff) => _maskButterworth(out, width, height, order, frequencyCutoff, amplitudeCutoff, ffi.nullptr);
  int maskButterworthRing(ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height, double order, double frequencyCutoff, double amplitudeCutoff, double ringwidth) => _maskButterworthRing(out, width, height, order, frequencyCutoff, amplitudeCutoff, ringwidth, ffi.nullptr);
  int maskButterworthBand(ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height, double order, double frequencyCutoffX, double frequencyCutoffY, double radius, double amplitudeCutoff) => _maskButterworthBand(out, width, height, order, frequencyCutoffX, frequencyCutoffY, radius, amplitudeCutoff, ffi.nullptr);
  int maskGaussian(ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height, double frequencyCutoff, double amplitudeCutoff) => _maskGaussian(out, width, height, frequencyCutoff, amplitudeCutoff, ffi.nullptr);
  int maskGaussianRing(ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height, double frequencyCutoff, double amplitudeCutoff, double ringwidth) => _maskGaussianRing(out, width, height, frequencyCutoff, amplitudeCutoff, ringwidth, ffi.nullptr);
  int maskGaussianBand(ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height, double frequencyCutoffX, double frequencyCutoffY, double radius, double amplitudeCutoff) => _maskGaussianBand(out, width, height, frequencyCutoffX, frequencyCutoffY, radius, amplitudeCutoff, ffi.nullptr);
  int maskFractal(ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height, double fractalDimension) => _maskFractal(out, width, height, fractalDimension, ffi.nullptr);
  int gaussmat(ffi.Pointer<ffi.Pointer<VipsImage>> out, double sigma, double minAmpl) => _gaussmat(out, sigma, minAmpl, ffi.nullptr);
  int logmat(ffi.Pointer<ffi.Pointer<VipsImage>> out, double sigma, double minAmpl) => _logmat(out, sigma, minAmpl, ffi.nullptr);
}
