import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

// I/O variadic function types

// ============ JPEG ============
typedef VipsJpegloadNative = ffi.Int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsJpegloadDart = int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsJpegloadBufferNative = ffi.Int Function(
  ffi.Pointer<ffi.Void> buf,
  ffi.Size len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsJpegloadBufferDart = int Function(
  ffi.Pointer<ffi.Void> buf,
  int len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsJpegsaveNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsJpegsaveDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsJpegsaveBufferNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<ffi.Void>> buf,
  ffi.Pointer<ffi.Size> len,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsJpegsaveBufferDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<ffi.Void>> buf,
  ffi.Pointer<ffi.Size> len,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ PNG ============
typedef VipsPngloadNative = ffi.Int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsPngloadDart = int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsPngloadBufferNative = ffi.Int Function(
  ffi.Pointer<ffi.Void> buf,
  ffi.Size len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsPngloadBufferDart = int Function(
  ffi.Pointer<ffi.Void> buf,
  int len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsPngsaveNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsPngsaveDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsPngsaveBufferNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<ffi.Void>> buf,
  ffi.Pointer<ffi.Size> len,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsPngsaveBufferDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<ffi.Void>> buf,
  ffi.Pointer<ffi.Size> len,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ WebP ============
typedef VipsWebploadNative = ffi.Int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsWebploadDart = int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsWebploadBufferNative = ffi.Int Function(
  ffi.Pointer<ffi.Void> buf,
  ffi.Size len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsWebploadBufferDart = int Function(
  ffi.Pointer<ffi.Void> buf,
  int len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsWebpsaveNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsWebpsaveDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsWebpsaveBufferNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<ffi.Void>> buf,
  ffi.Pointer<ffi.Size> len,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsWebpsaveBufferDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<ffi.Void>> buf,
  ffi.Pointer<ffi.Size> len,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ TIFF ============
typedef VipsTiffloadNative = ffi.Int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsTiffloadDart = int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsTiffloadBufferNative = ffi.Int Function(
  ffi.Pointer<ffi.Void> buf,
  ffi.Size len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsTiffloadBufferDart = int Function(
  ffi.Pointer<ffi.Void> buf,
  int len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsTiffsaveNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsTiffsaveDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsTiffsaveBufferNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<ffi.Void>> buf,
  ffi.Pointer<ffi.Size> len,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsTiffsaveBufferDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<ffi.Void>> buf,
  ffi.Pointer<ffi.Size> len,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ GIF ============
typedef VipsGifloadNative = ffi.Int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsGifloadDart = int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsGifloadBufferNative = ffi.Int Function(
  ffi.Pointer<ffi.Void> buf,
  ffi.Size len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsGifloadBufferDart = int Function(
  ffi.Pointer<ffi.Void> buf,
  int len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsGifsaveNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsGifsaveDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsGifsaveBufferNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<ffi.Void>> buf,
  ffi.Pointer<ffi.Size> len,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsGifsaveBufferDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<ffi.Void>> buf,
  ffi.Pointer<ffi.Size> len,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ HEIF/AVIF ============
typedef VipsHeifloadNative = ffi.Int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsHeifloadDart = int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsHeifloadBufferNative = ffi.Int Function(
  ffi.Pointer<ffi.Void> buf,
  ffi.Size len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsHeifloadBufferDart = int Function(
  ffi.Pointer<ffi.Void> buf,
  int len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsHeifsaveNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsHeifsaveDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsHeifsaveBufferNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<ffi.Void>> buf,
  ffi.Pointer<ffi.Size> len,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsHeifsaveBufferDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Pointer<ffi.Void>> buf,
  ffi.Pointer<ffi.Size> len,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ PDF/SVG ============
typedef VipsPdfloadNative = ffi.Int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsPdfloadDart = int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsPdfloadBufferNative = ffi.Int Function(
  ffi.Pointer<ffi.Void> buf,
  ffi.Size len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsPdfloadBufferDart = int Function(
  ffi.Pointer<ffi.Void> buf,
  int len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsSvgloadNative = ffi.Int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsSvgloadDart = int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsSvgloadBufferNative = ffi.Int Function(
  ffi.Pointer<ffi.Void> buf,
  ffi.Size len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsSvgloadBufferDart = int Function(
  ffi.Pointer<ffi.Void> buf,
  int len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ JPEG 2000 ============
typedef VipsJp2kloadNative = ffi.Int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsJp2kloadDart = int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsJp2ksaveNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsJp2ksaveDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ JPEG XL ============
typedef VipsJxlloadNative = ffi.Int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsJxlloadDart = int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsJxlsaveNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsJxlsaveDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ ImageMagick ============
typedef VipsMagickloadNative = ffi.Int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMagickloadDart = int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsMagicksaveNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsMagicksaveDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ NIfTI ============
typedef VipsNiftiloadNative = ffi.Int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsNiftiloadDart = int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsNiftisaveNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsNiftisaveDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ OpenEXR ============
typedef VipsOpenexrloadNative = ffi.Int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsOpenexrloadDart = int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ OpenSlide ============
typedef VipsOpenslideloadNative = ffi.Int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsOpenslideloadDart = int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ Radiance HDR ============
typedef VipsRadloadNative = ffi.Int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsRadloadDart = int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsRadsaveNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsRadsaveDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Void> terminator,
);

// ============ Raw ============
typedef VipsRawloadNative = ffi.Int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.Int bands,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsRawloadDart = int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  int bands,
  ffi.Pointer<ffi.Void> terminator,
);

typedef VipsRawsaveNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.VarArgs<(ffi.Pointer<ffi.Void>,)>,
);
typedef VipsRawsaveDart = int Function(
  ffi.Pointer<VipsImage> in$,
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Void> terminator,
);
