import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import 'types/colour_types.dart';

/// Colour operation bindings.
class VipsColourBindings {
  final ffi.DynamicLibrary _lib;

  VipsColourBindings(this._lib);

  // Color space conversions
  late final _cmc2LCh = _lib.lookup<ffi.NativeFunction<VipsCMC2LChNative>>('vips_CMC2LCh').asFunction<VipsCMC2LChDart>();
  late final _cmyk2XYZ = _lib.lookup<ffi.NativeFunction<VipsCMYK2XYZNative>>('vips_CMYK2XYZ').asFunction<VipsCMYK2XYZDart>();
  late final _hsv2sRGB = _lib.lookup<ffi.NativeFunction<VipsHSV2sRGBNative>>('vips_HSV2sRGB').asFunction<VipsHSV2sRGBDart>();
  late final _lch2CMC = _lib.lookup<ffi.NativeFunction<VipsLCh2CMCNative>>('vips_LCh2CMC').asFunction<VipsLCh2CMCDart>();
  late final _lch2Lab = _lib.lookup<ffi.NativeFunction<VipsLCh2LabNative>>('vips_LCh2Lab').asFunction<VipsLCh2LabDart>();
  late final _lab2LCh = _lib.lookup<ffi.NativeFunction<VipsLab2LChNative>>('vips_Lab2LCh').asFunction<VipsLab2LChDart>();
  late final _lab2LabQ = _lib.lookup<ffi.NativeFunction<VipsLab2LabQNative>>('vips_Lab2LabQ').asFunction<VipsLab2LabQDart>();
  late final _lab2LabS = _lib.lookup<ffi.NativeFunction<VipsLab2LabSNative>>('vips_Lab2LabS').asFunction<VipsLab2LabSDart>();
  late final _lab2XYZ = _lib.lookup<ffi.NativeFunction<VipsLab2XYZNative>>('vips_Lab2XYZ').asFunction<VipsLab2XYZDart>();
  late final _labQ2Lab = _lib.lookup<ffi.NativeFunction<VipsLabQ2LabNative>>('vips_LabQ2Lab').asFunction<VipsLabQ2LabDart>();
  late final _labQ2LabS = _lib.lookup<ffi.NativeFunction<VipsLabQ2LabSNative>>('vips_LabQ2LabS').asFunction<VipsLabQ2LabSDart>();
  late final _labQ2sRGB = _lib.lookup<ffi.NativeFunction<VipsLabQ2sRGBNative>>('vips_LabQ2sRGB').asFunction<VipsLabQ2sRGBDart>();
  late final _labS2Lab = _lib.lookup<ffi.NativeFunction<VipsLabS2LabNative>>('vips_LabS2Lab').asFunction<VipsLabS2LabDart>();
  late final _labS2LabQ = _lib.lookup<ffi.NativeFunction<VipsLabS2LabQNative>>('vips_LabS2LabQ').asFunction<VipsLabS2LabQDart>();
  late final _xyz2CMYK = _lib.lookup<ffi.NativeFunction<VipsXYZ2CMYKNative>>('vips_XYZ2CMYK').asFunction<VipsXYZ2CMYKDart>();
  late final _xyz2Lab = _lib.lookup<ffi.NativeFunction<VipsXYZ2LabNative>>('vips_XYZ2Lab').asFunction<VipsXYZ2LabDart>();
  late final _xyz2Yxy = _lib.lookup<ffi.NativeFunction<VipsXYZ2YxyNative>>('vips_XYZ2Yxy').asFunction<VipsXYZ2YxyDart>();
  late final _xyz2scRGB = _lib.lookup<ffi.NativeFunction<VipsXYZ2scRGBNative>>('vips_XYZ2scRGB').asFunction<VipsXYZ2scRGBDart>();
  late final _yxy2XYZ = _lib.lookup<ffi.NativeFunction<VipsYxy2XYZNative>>('vips_Yxy2XYZ').asFunction<VipsYxy2XYZDart>();
  late final _sRGB2HSV = _lib.lookup<ffi.NativeFunction<VipsSRGB2HSVNative>>('vips_sRGB2HSV').asFunction<VipsSRGB2HSVDart>();
  late final _sRGB2scRGB = _lib.lookup<ffi.NativeFunction<VipsSRGB2scRGBNative>>('vips_sRGB2scRGB').asFunction<VipsSRGB2scRGBDart>();
  late final _scRGB2BW = _lib.lookup<ffi.NativeFunction<VipsScRGB2BWNative>>('vips_scRGB2BW').asFunction<VipsScRGB2BWDart>();
  late final _scRGB2XYZ = _lib.lookup<ffi.NativeFunction<VipsScRGB2XYZNative>>('vips_scRGB2XYZ').asFunction<VipsScRGB2XYZDart>();
  late final _scRGB2sRGB = _lib.lookup<ffi.NativeFunction<VipsScRGB2sRGBNative>>('vips_scRGB2sRGB').asFunction<VipsScRGB2sRGBDart>();

  int cmc2LCh(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _cmc2LCh(in$, out, ffi.nullptr);
  int cmyk2XYZ(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _cmyk2XYZ(in$, out, ffi.nullptr);
  int hsv2sRGB(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _hsv2sRGB(in$, out, ffi.nullptr);
  int lch2CMC(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _lch2CMC(in$, out, ffi.nullptr);
  int lch2Lab(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _lch2Lab(in$, out, ffi.nullptr);
  int lab2LCh(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _lab2LCh(in$, out, ffi.nullptr);
  int lab2LabQ(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _lab2LabQ(in$, out, ffi.nullptr);
  int lab2LabS(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _lab2LabS(in$, out, ffi.nullptr);
  int lab2XYZ(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _lab2XYZ(in$, out, ffi.nullptr);
  int labQ2Lab(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _labQ2Lab(in$, out, ffi.nullptr);
  int labQ2LabS(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _labQ2LabS(in$, out, ffi.nullptr);
  int labQ2sRGB(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _labQ2sRGB(in$, out, ffi.nullptr);
  int labS2Lab(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _labS2Lab(in$, out, ffi.nullptr);
  int labS2LabQ(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _labS2LabQ(in$, out, ffi.nullptr);
  int xyz2CMYK(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _xyz2CMYK(in$, out, ffi.nullptr);
  int xyz2Lab(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _xyz2Lab(in$, out, ffi.nullptr);
  int xyz2Yxy(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _xyz2Yxy(in$, out, ffi.nullptr);
  int xyz2scRGB(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _xyz2scRGB(in$, out, ffi.nullptr);
  int yxy2XYZ(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _yxy2XYZ(in$, out, ffi.nullptr);
  int sRGB2HSV(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _sRGB2HSV(in$, out, ffi.nullptr);
  int sRGB2scRGB(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _sRGB2scRGB(in$, out, ffi.nullptr);
  int scRGB2BW(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _scRGB2BW(in$, out, ffi.nullptr);
  int scRGB2XYZ(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _scRGB2XYZ(in$, out, ffi.nullptr);
  int scRGB2sRGB(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _scRGB2sRGB(in$, out, ffi.nullptr);

  // ICC Profile operations
  late final _iccImport = _lib.lookup<ffi.NativeFunction<VipsIccImportNative>>('vips_icc_import').asFunction<VipsIccImportDart>();
  late final _iccExport = _lib.lookup<ffi.NativeFunction<VipsIccExportNative>>('vips_icc_export').asFunction<VipsIccExportDart>();
  late final _iccTransform = _lib.lookup<ffi.NativeFunction<VipsIccTransformNative>>('vips_icc_transform').asFunction<VipsIccTransformDart>();

  int iccImport(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _iccImport(in$, out, ffi.nullptr);

  int iccExport(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _iccExport(in$, out, ffi.nullptr);

  int iccTransform(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<ffi.Char> outputProfile) =>
      _iccTransform(in$, out, outputProfile, ffi.nullptr);

  // Delta E operations
  late final _dE00 = _lib.lookup<ffi.NativeFunction<VipsDE00Native>>('vips_dE00').asFunction<VipsDE00Dart>();
  late final _dE76 = _lib.lookup<ffi.NativeFunction<VipsDE76Native>>('vips_dE76').asFunction<VipsDE76Dart>();
  late final _dECMC = _lib.lookup<ffi.NativeFunction<VipsDECMCNative>>('vips_dECMC').asFunction<VipsDECMCDart>();

  int dE00(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _dE00(left, right, out, ffi.nullptr);

  int dE76(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _dE76(left, right, out, ffi.nullptr);

  int dECMC(ffi.Pointer<VipsImage> left, ffi.Pointer<VipsImage> right, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _dECMC(left, right, out, ffi.nullptr);

  // Other colour operations
  late final _recomb = _lib.lookup<ffi.NativeFunction<VipsRecombNative>>('vips_recomb').asFunction<VipsRecombDart>();
  late final _falsecolour = _lib.lookup<ffi.NativeFunction<VipsFalsecolourNative>>('vips_falsecolour').asFunction<VipsFalsecolourDart>();

  int recomb(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<VipsImage> m) =>
      _recomb(in$, out, m, ffi.nullptr);

  int falsecolour(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _falsecolour(in$, out, ffi.nullptr);

  // Histogram operations
  late final _histEqual = _lib.lookup<ffi.NativeFunction<VipsHistEqualNative>>('vips_hist_equal').asFunction<VipsHistEqualDart>();
  late final _histNorm = _lib.lookup<ffi.NativeFunction<VipsHistNormNative>>('vips_hist_norm').asFunction<VipsHistNormDart>();
  late final _histMatch = _lib.lookup<ffi.NativeFunction<VipsHistMatchNative>>('vips_hist_match').asFunction<VipsHistMatchDart>();
  late final _histPlot = _lib.lookup<ffi.NativeFunction<VipsHistPlotNative>>('vips_hist_plot').asFunction<VipsHistPlotDart>();
  late final _histLocal = _lib.lookup<ffi.NativeFunction<VipsHistLocalNative>>('vips_hist_local').asFunction<VipsHistLocalDart>();
  late final _histFind = _lib.lookup<ffi.NativeFunction<VipsHistFindNative>>('vips_hist_find').asFunction<VipsHistFindDart>();
  late final _histFindNdim = _lib.lookup<ffi.NativeFunction<VipsHistFindNdimNative>>('vips_hist_find_ndim').asFunction<VipsHistFindNdimDart>();
  late final _histFindIndexed = _lib.lookup<ffi.NativeFunction<VipsHistFindIndexedNative>>('vips_hist_find_indexed').asFunction<VipsHistFindIndexedDart>();
  late final _histCum = _lib.lookup<ffi.NativeFunction<VipsHistCumNative>>('vips_hist_cum').asFunction<VipsHistCumDart>();
  late final _histIsmonotonic = _lib.lookup<ffi.NativeFunction<VipsHistIsmonotonicNative>>('vips_hist_ismonotonic').asFunction<VipsHistIsmonotonicDart>();
  late final _histEntropy = _lib.lookup<ffi.NativeFunction<VipsHistEntropyNative>>('vips_hist_entropy').asFunction<VipsHistEntropyDart>();
  late final _maplut = _lib.lookup<ffi.NativeFunction<VipsMaplutNative>>('vips_maplut').asFunction<VipsMaplutDart>();
  late final _percent = _lib.lookup<ffi.NativeFunction<VipsPercentNative>>('vips_percent').asFunction<VipsPercentDart>();
  late final _stdif = _lib.lookup<ffi.NativeFunction<VipsStdifNative>>('vips_stdif').asFunction<VipsStdifDart>();

  int histEqual(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _histEqual(in$, out, ffi.nullptr);

  int histNorm(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _histNorm(in$, out, ffi.nullptr);

  int histMatch(ffi.Pointer<VipsImage> in$, ffi.Pointer<VipsImage> ref, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _histMatch(in$, ref, out, ffi.nullptr);

  int histPlot(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _histPlot(in$, out, ffi.nullptr);

  int histLocal(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height) =>
      _histLocal(in$, out, width, height, ffi.nullptr);

  int histFind(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _histFind(in$, out, ffi.nullptr);

  int histFindNdim(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _histFindNdim(in$, out, ffi.nullptr);

  int histFindIndexed(ffi.Pointer<VipsImage> in$, ffi.Pointer<VipsImage> index, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _histFindIndexed(in$, index, out, ffi.nullptr);

  int histCum(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _histCum(in$, out, ffi.nullptr);

  int histIsmonotonic(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Int> out) =>
      _histIsmonotonic(in$, out, ffi.nullptr);

  int histEntropy(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Double> out) =>
      _histEntropy(in$, out, ffi.nullptr);

  int maplut(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<VipsImage> lut) =>
      _maplut(in$, out, lut, ffi.nullptr);

  int percent(ffi.Pointer<VipsImage> in$, double percentVal, ffi.Pointer<ffi.Int> threshold) =>
      _percent(in$, percentVal, threshold, ffi.nullptr);

  int stdif(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height) =>
      _stdif(in$, out, width, height, ffi.nullptr);
}
