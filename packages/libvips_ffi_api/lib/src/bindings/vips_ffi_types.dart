import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

// Custom function types for variadic functions using VarArgs (Dart 3.0+).
// 使用 VarArgs 的可变参数函数自定义类型（需要 Dart 3.0+）。
//
// VarArgs<(Pointer<Void>,)> is used to pass NULL terminator explicitly.
// 使用 VarArgs<(Pointer<Void>,)> 显式传递 NULL 终止符。

// ============ Image I/O ============

typedef VipsImageNewFromFileNative = ffi.Pointer<VipsImage> Function(
  ffi.Pointer<ffi.Char> name,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsImageNewFromFileDart = ffi.Pointer<VipsImage> Function(
  ffi.Pointer<ffi.Char> name,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsImageWriteToFileNative = ffi.Int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Char> name,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsImageWriteToFileDart = int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Char> name,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsImageWriteToBufferNative = ffi.Int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Char> suffix,
  ffi.Pointer<ffi.Pointer<ffi.Void>> buf,
  ffi.Pointer<ffi.Size> size,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsImageWriteToBufferDart = int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Char> suffix,
  ffi.Pointer<ffi.Pointer<ffi.Void>> buf,
  ffi.Pointer<ffi.Size> size,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsImageNewFromBufferNative = ffi.Pointer<VipsImage> Function(
  ffi.Pointer<ffi.Void> buf,
  ffi.Size len,
  ffi.Pointer<ffi.Char> optionString,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsImageNewFromBufferDart = ffi.Pointer<VipsImage> Function(
  ffi.Pointer<ffi.Void> buf,
  int len,
  ffi.Pointer<ffi.Char> optionString,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ Resample ============

typedef VipsResizeNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double scale,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsResizeDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double scale,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsRotateNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double angle,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsRotateDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double angle,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsThumbnailImageNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsThumbnailImageDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsThumbnailNative = ffi.Int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsThumbnailDart = int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsThumbnailBufferNative = ffi.Int Function(
  ffi.Pointer<ffi.Void> buf,
  ffi.Size len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsThumbnailBufferDart = int Function(
  ffi.Pointer<ffi.Void> buf,
  int len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsReduceNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double hshrink,
  ffi.Double vshrink,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsReduceDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double hshrink,
  double vshrink,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsShrinkNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double hshrink,
  ffi.Double vshrink,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsShrinkDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double hshrink,
  double vshrink,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ Geometry ============

typedef VipsCropNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int left,
  ffi.Int top,
  ffi.Int width,
  ffi.Int height,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsCropDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int left,
  int top,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsFlipNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int direction,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsFlipDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int direction,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsEmbedNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int x,
  ffi.Int y,
  ffi.Int width,
  ffi.Int height,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsEmbedDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int x,
  int y,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsExtractAreaNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int left,
  ffi.Int top,
  ffi.Int width,
  ffi.Int height,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsExtractAreaDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int left,
  int top,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsSmartcropNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsSmartcropDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsGravityNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int direction,
  ffi.Int width,
  ffi.Int height,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsGravityDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int direction,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsZoomNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int xfac,
  ffi.Int yfac,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsZoomDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int xfac,
  int yfac,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ Convolution ============

typedef VipsGaussblurNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double sigma,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsGaussblurDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double sigma,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsSharpenNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsSharpenDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsSobelNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsSobelDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsCannyNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsCannyDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ Filter ============

typedef VipsInvertNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsInvertDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsFlattenNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsFlattenDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsGammaNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsGammaDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsAutorotNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsAutorotDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ Colour ============

typedef VipsColourspaceNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int space,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsColourspaceDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int space,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsLinear1Native = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double a,
  ffi.Double b,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsLinear1Dart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double a,
  double b,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsLinearNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> a,
  ffi.Pointer<ffi.Double> b,
  ffi.Int n,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsLinearDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> a,
  ffi.Pointer<ffi.Double> b,
  int n,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ Conversion ============

typedef VipsCastNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int format,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsCastDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int format,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsCopyNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsCopyDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsBandjoinConstNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  ffi.Int n,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsBandjoinConstDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Double> c,
  int n,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsExtractBandNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int band,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsExtractBandDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int band,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ Composite ============

typedef VipsInsertNative = ffi.Int Function(
  ffi.Pointer<VipsImage> main,
  ffi.Pointer<VipsImage> sub,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int x,
  ffi.Int y,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsInsertDart = int Function(
  ffi.Pointer<VipsImage> main,
  ffi.Pointer<VipsImage> sub,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int x,
  int y,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsJoinNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<VipsImage> in2,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int direction,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsJoinDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<VipsImage> in2,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int direction,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsComposite2Native = ffi.Int Function(
  ffi.Pointer<VipsImage> base,
  ffi.Pointer<VipsImage> overlay,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int mode,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsComposite2Dart = int Function(
  ffi.Pointer<VipsImage> base,
  ffi.Pointer<VipsImage> overlay,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int mode,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ Create ============

typedef VipsBlackNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsBlackDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsTextNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Char> text,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsTextDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Char> text,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsGaussnoiseNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsGaussnoiseDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsXyzNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsXyzDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsGreyNative = ffi.Int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsGreyDart = int Function(
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);
