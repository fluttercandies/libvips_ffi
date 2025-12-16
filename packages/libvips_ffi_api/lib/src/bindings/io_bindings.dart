import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import 'types/io_types.dart';

/// I/O bindings for format-specific load/save operations.
class VipsIoBindings {
  final ffi.DynamicLibrary _lib;

  VipsIoBindings(this._lib);

  // ============ JPEG ============
  late final _jpegload = _lib
      .lookup<ffi.NativeFunction<VipsJpegloadNative>>('vips_jpegload')
      .asFunction<VipsJpegloadDart>();

  late final _jpegloadBuffer = _lib
      .lookup<ffi.NativeFunction<VipsJpegloadBufferNative>>('vips_jpegload_buffer')
      .asFunction<VipsJpegloadBufferDart>();

  late final _jpegsave = _lib
      .lookup<ffi.NativeFunction<VipsJpegsaveNative>>('vips_jpegsave')
      .asFunction<VipsJpegsaveDart>();

  late final _jpegsaveBuffer = _lib
      .lookup<ffi.NativeFunction<VipsJpegsaveBufferNative>>('vips_jpegsave_buffer')
      .asFunction<VipsJpegsaveBufferDart>();

  int jpegload(ffi.Pointer<ffi.Char> filename, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _jpegload(filename, out, ffi.nullptr);

  int jpegloadBuffer(ffi.Pointer<ffi.Void> buf, int len, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _jpegloadBuffer(buf, len, out, ffi.nullptr);

  int jpegsave(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Char> filename) =>
      _jpegsave(in$, filename, ffi.nullptr);

  int jpegsaveBuffer(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<ffi.Void>> buf, ffi.Pointer<ffi.Size> len) =>
      _jpegsaveBuffer(in$, buf, len, ffi.nullptr);

  // ============ PNG ============
  late final _pngload = _lib
      .lookup<ffi.NativeFunction<VipsPngloadNative>>('vips_pngload')
      .asFunction<VipsPngloadDart>();

  late final _pngloadBuffer = _lib
      .lookup<ffi.NativeFunction<VipsPngloadBufferNative>>('vips_pngload_buffer')
      .asFunction<VipsPngloadBufferDart>();

  late final _pngsave = _lib
      .lookup<ffi.NativeFunction<VipsPngsaveNative>>('vips_pngsave')
      .asFunction<VipsPngsaveDart>();

  late final _pngsaveBuffer = _lib
      .lookup<ffi.NativeFunction<VipsPngsaveBufferNative>>('vips_pngsave_buffer')
      .asFunction<VipsPngsaveBufferDart>();

  int pngload(ffi.Pointer<ffi.Char> filename, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _pngload(filename, out, ffi.nullptr);

  int pngloadBuffer(ffi.Pointer<ffi.Void> buf, int len, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _pngloadBuffer(buf, len, out, ffi.nullptr);

  int pngsave(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Char> filename) =>
      _pngsave(in$, filename, ffi.nullptr);

  int pngsaveBuffer(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<ffi.Void>> buf, ffi.Pointer<ffi.Size> len) =>
      _pngsaveBuffer(in$, buf, len, ffi.nullptr);

  // ============ WebP ============
  late final _webpload = _lib
      .lookup<ffi.NativeFunction<VipsWebploadNative>>('vips_webpload')
      .asFunction<VipsWebploadDart>();

  late final _webploadBuffer = _lib
      .lookup<ffi.NativeFunction<VipsWebploadBufferNative>>('vips_webpload_buffer')
      .asFunction<VipsWebploadBufferDart>();

  late final _webpsave = _lib
      .lookup<ffi.NativeFunction<VipsWebpsaveNative>>('vips_webpsave')
      .asFunction<VipsWebpsaveDart>();

  late final _webpsaveBuffer = _lib
      .lookup<ffi.NativeFunction<VipsWebpsaveBufferNative>>('vips_webpsave_buffer')
      .asFunction<VipsWebpsaveBufferDart>();

  int webpload(ffi.Pointer<ffi.Char> filename, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _webpload(filename, out, ffi.nullptr);

  int webploadBuffer(ffi.Pointer<ffi.Void> buf, int len, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _webploadBuffer(buf, len, out, ffi.nullptr);

  int webpsave(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Char> filename) =>
      _webpsave(in$, filename, ffi.nullptr);

  int webpsaveBuffer(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<ffi.Void>> buf, ffi.Pointer<ffi.Size> len) =>
      _webpsaveBuffer(in$, buf, len, ffi.nullptr);

  // ============ TIFF ============
  late final _tiffload = _lib
      .lookup<ffi.NativeFunction<VipsTiffloadNative>>('vips_tiffload')
      .asFunction<VipsTiffloadDart>();

  late final _tiffloadBuffer = _lib
      .lookup<ffi.NativeFunction<VipsTiffloadBufferNative>>('vips_tiffload_buffer')
      .asFunction<VipsTiffloadBufferDart>();

  late final _tiffsave = _lib
      .lookup<ffi.NativeFunction<VipsTiffsaveNative>>('vips_tiffsave')
      .asFunction<VipsTiffsaveDart>();

  late final _tiffsaveBuffer = _lib
      .lookup<ffi.NativeFunction<VipsTiffsaveBufferNative>>('vips_tiffsave_buffer')
      .asFunction<VipsTiffsaveBufferDart>();

  int tiffload(ffi.Pointer<ffi.Char> filename, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _tiffload(filename, out, ffi.nullptr);

  int tiffloadBuffer(ffi.Pointer<ffi.Void> buf, int len, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _tiffloadBuffer(buf, len, out, ffi.nullptr);

  int tiffsave(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Char> filename) =>
      _tiffsave(in$, filename, ffi.nullptr);

  int tiffsaveBuffer(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<ffi.Void>> buf, ffi.Pointer<ffi.Size> len) =>
      _tiffsaveBuffer(in$, buf, len, ffi.nullptr);

  // ============ GIF ============
  late final _gifload = _lib
      .lookup<ffi.NativeFunction<VipsGifloadNative>>('vips_gifload')
      .asFunction<VipsGifloadDart>();

  late final _gifloadBuffer = _lib
      .lookup<ffi.NativeFunction<VipsGifloadBufferNative>>('vips_gifload_buffer')
      .asFunction<VipsGifloadBufferDart>();

  late final _gifsave = _lib
      .lookup<ffi.NativeFunction<VipsGifsaveNative>>('vips_gifsave')
      .asFunction<VipsGifsaveDart>();

  late final _gifsaveBuffer = _lib
      .lookup<ffi.NativeFunction<VipsGifsaveBufferNative>>('vips_gifsave_buffer')
      .asFunction<VipsGifsaveBufferDart>();

  int gifload(ffi.Pointer<ffi.Char> filename, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _gifload(filename, out, ffi.nullptr);

  int gifloadBuffer(ffi.Pointer<ffi.Void> buf, int len, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _gifloadBuffer(buf, len, out, ffi.nullptr);

  int gifsave(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Char> filename) =>
      _gifsave(in$, filename, ffi.nullptr);

  int gifsaveBuffer(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<ffi.Void>> buf, ffi.Pointer<ffi.Size> len) =>
      _gifsaveBuffer(in$, buf, len, ffi.nullptr);

  // ============ HEIF/AVIF ============
  late final _heifload = _lib
      .lookup<ffi.NativeFunction<VipsHeifloadNative>>('vips_heifload')
      .asFunction<VipsHeifloadDart>();

  late final _heifloadBuffer = _lib
      .lookup<ffi.NativeFunction<VipsHeifloadBufferNative>>('vips_heifload_buffer')
      .asFunction<VipsHeifloadBufferDart>();

  late final _heifsave = _lib
      .lookup<ffi.NativeFunction<VipsHeifsaveNative>>('vips_heifsave')
      .asFunction<VipsHeifsaveDart>();

  late final _heifsaveBuffer = _lib
      .lookup<ffi.NativeFunction<VipsHeifsaveBufferNative>>('vips_heifsave_buffer')
      .asFunction<VipsHeifsaveBufferDart>();

  int heifload(ffi.Pointer<ffi.Char> filename, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _heifload(filename, out, ffi.nullptr);

  int heifloadBuffer(ffi.Pointer<ffi.Void> buf, int len, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _heifloadBuffer(buf, len, out, ffi.nullptr);

  int heifsave(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Char> filename) =>
      _heifsave(in$, filename, ffi.nullptr);

  int heifsaveBuffer(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<ffi.Void>> buf, ffi.Pointer<ffi.Size> len) =>
      _heifsaveBuffer(in$, buf, len, ffi.nullptr);

  // ============ PDF/SVG ============
  late final _pdfload = _lib
      .lookup<ffi.NativeFunction<VipsPdfloadNative>>('vips_pdfload')
      .asFunction<VipsPdfloadDart>();

  late final _pdfloadBuffer = _lib
      .lookup<ffi.NativeFunction<VipsPdfloadBufferNative>>('vips_pdfload_buffer')
      .asFunction<VipsPdfloadBufferDart>();

  late final _svgload = _lib
      .lookup<ffi.NativeFunction<VipsSvgloadNative>>('vips_svgload')
      .asFunction<VipsSvgloadDart>();

  late final _svgloadBuffer = _lib
      .lookup<ffi.NativeFunction<VipsSvgloadBufferNative>>('vips_svgload_buffer')
      .asFunction<VipsSvgloadBufferDart>();

  int pdfload(ffi.Pointer<ffi.Char> filename, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _pdfload(filename, out, ffi.nullptr);

  int pdfloadBuffer(ffi.Pointer<ffi.Void> buf, int len, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _pdfloadBuffer(buf, len, out, ffi.nullptr);

  int svgload(ffi.Pointer<ffi.Char> filename, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _svgload(filename, out, ffi.nullptr);

  int svgloadBuffer(ffi.Pointer<ffi.Void> buf, int len, ffi.Pointer<ffi.Pointer<VipsImage>> out) =>
      _svgloadBuffer(buf, len, out, ffi.nullptr);

  // ============ JPEG 2000 ============
  late final _jp2kload = _lib.lookup<ffi.NativeFunction<VipsJp2kloadNative>>('vips_jp2kload').asFunction<VipsJp2kloadDart>();
  late final _jp2ksave = _lib.lookup<ffi.NativeFunction<VipsJp2ksaveNative>>('vips_jp2ksave').asFunction<VipsJp2ksaveDart>();

  int jp2kload(ffi.Pointer<ffi.Char> filename, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _jp2kload(filename, out, ffi.nullptr);
  int jp2ksave(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Char> filename) => _jp2ksave(in$, filename, ffi.nullptr);

  // ============ JPEG XL ============
  late final _jxlload = _lib.lookup<ffi.NativeFunction<VipsJxlloadNative>>('vips_jxlload').asFunction<VipsJxlloadDart>();
  late final _jxlsave = _lib.lookup<ffi.NativeFunction<VipsJxlsaveNative>>('vips_jxlsave').asFunction<VipsJxlsaveDart>();

  int jxlload(ffi.Pointer<ffi.Char> filename, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _jxlload(filename, out, ffi.nullptr);
  int jxlsave(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Char> filename) => _jxlsave(in$, filename, ffi.nullptr);

  // ============ ImageMagick ============
  late final _magickload = _lib.lookup<ffi.NativeFunction<VipsMagickloadNative>>('vips_magickload').asFunction<VipsMagickloadDart>();
  late final _magicksave = _lib.lookup<ffi.NativeFunction<VipsMagicksaveNative>>('vips_magicksave').asFunction<VipsMagicksaveDart>();

  int magickload(ffi.Pointer<ffi.Char> filename, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _magickload(filename, out, ffi.nullptr);
  int magicksave(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Char> filename) => _magicksave(in$, filename, ffi.nullptr);

  // ============ NIfTI ============
  late final _niftiload = _lib.lookup<ffi.NativeFunction<VipsNiftiloadNative>>('vips_niftiload').asFunction<VipsNiftiloadDart>();
  late final _niftisave = _lib.lookup<ffi.NativeFunction<VipsNiftisaveNative>>('vips_niftisave').asFunction<VipsNiftisaveDart>();

  int niftiload(ffi.Pointer<ffi.Char> filename, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _niftiload(filename, out, ffi.nullptr);
  int niftisave(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Char> filename) => _niftisave(in$, filename, ffi.nullptr);

  // ============ OpenEXR ============
  late final _openexrload = _lib.lookup<ffi.NativeFunction<VipsOpenexrloadNative>>('vips_openexrload').asFunction<VipsOpenexrloadDart>();

  int openexrload(ffi.Pointer<ffi.Char> filename, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _openexrload(filename, out, ffi.nullptr);

  // ============ OpenSlide ============
  late final _openslideload = _lib.lookup<ffi.NativeFunction<VipsOpenslideloadNative>>('vips_openslideload').asFunction<VipsOpenslideloadDart>();

  int openslideload(ffi.Pointer<ffi.Char> filename, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _openslideload(filename, out, ffi.nullptr);

  // ============ Radiance HDR ============
  late final _radload = _lib.lookup<ffi.NativeFunction<VipsRadloadNative>>('vips_radload').asFunction<VipsRadloadDart>();
  late final _radsave = _lib.lookup<ffi.NativeFunction<VipsRadsaveNative>>('vips_radsave').asFunction<VipsRadsaveDart>();

  int radload(ffi.Pointer<ffi.Char> filename, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _radload(filename, out, ffi.nullptr);
  int radsave(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Char> filename) => _radsave(in$, filename, ffi.nullptr);

  // ============ Raw ============
  late final _rawload = _lib.lookup<ffi.NativeFunction<VipsRawloadNative>>('vips_rawload').asFunction<VipsRawloadDart>();
  late final _rawsave = _lib.lookup<ffi.NativeFunction<VipsRawsaveNative>>('vips_rawsave').asFunction<VipsRawsaveDart>();

  int rawload(ffi.Pointer<ffi.Char> filename, ffi.Pointer<ffi.Pointer<VipsImage>> out, int width, int height, int bands) => _rawload(filename, out, width, height, bands, ffi.nullptr);
  int rawsave(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Char> filename) => _rawsave(in$, filename, ffi.nullptr);
}
