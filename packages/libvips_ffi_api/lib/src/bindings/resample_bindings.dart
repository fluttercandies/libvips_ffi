import 'dart:ffi' as ffi;

import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import 'types/resample_types.dart';

/// Resample operation bindings.
class VipsResampleBindings {
  final ffi.DynamicLibrary _lib;

  VipsResampleBindings(this._lib);

  late final _affine = _lib.lookup<ffi.NativeFunction<VipsAffineNative>>('vips_affine').asFunction<VipsAffineDart>();
  late final _mapim = _lib.lookup<ffi.NativeFunction<VipsMapimNative>>('vips_mapim').asFunction<VipsMapimDart>();
  late final _quadratic = _lib.lookup<ffi.NativeFunction<VipsQuadraticNative>>('vips_quadratic').asFunction<VipsQuadraticDart>();
  late final _reduceh = _lib.lookup<ffi.NativeFunction<VipsReducehNative>>('vips_reduceh').asFunction<VipsReducehDart>();
  late final _reducev = _lib.lookup<ffi.NativeFunction<VipsReducevNative>>('vips_reducev').asFunction<VipsReducevDart>();
  late final _shrinkh = _lib.lookup<ffi.NativeFunction<VipsShrinkhNative>>('vips_shrinkh').asFunction<VipsShrinkhDart>();
  late final _shrinkv = _lib.lookup<ffi.NativeFunction<VipsShrinkVNative>>('vips_shrinkv').asFunction<VipsShrinkVDart>();
  late final _similarity = _lib.lookup<ffi.NativeFunction<VipsSimilarityNative>>('vips_similarity').asFunction<VipsSimilarityDart>();
  late final _thumbnail = _lib.lookup<ffi.NativeFunction<VipsThumbnailNative>>('vips_thumbnail').asFunction<VipsThumbnailDart>();
  late final _thumbnailBuffer = _lib.lookup<ffi.NativeFunction<VipsThumbnailBufferNative>>('vips_thumbnail_buffer').asFunction<VipsThumbnailBufferDart>();
  late final _thumbnailSource = _lib.lookup<ffi.NativeFunction<VipsThumbnailSourceNative>>('vips_thumbnail_source').asFunction<VipsThumbnailSourceDart>();

  int affine(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, double a, double b, double c, double d) => _affine(in$, out, a, b, c, d, ffi.nullptr);
  int mapim(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<VipsImage> index) => _mapim(in$, out, index, ffi.nullptr);
  int quadratic(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, ffi.Pointer<VipsImage> coeff) => _quadratic(in$, out, coeff, ffi.nullptr);
  int reduceh(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, double hshrink) => _reduceh(in$, out, hshrink, ffi.nullptr);
  int reducev(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, double vshrink) => _reducev(in$, out, vshrink, ffi.nullptr);
  int shrinkh(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, int hshrink) => _shrinkh(in$, out, hshrink, ffi.nullptr);
  int shrinkv(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out, int vshrink) => _shrinkv(in$, out, vshrink, ffi.nullptr);
  int similarity(ffi.Pointer<VipsImage> in$, ffi.Pointer<ffi.Pointer<VipsImage>> out) => _similarity(in$, out, ffi.nullptr);
  int thumbnail(ffi.Pointer<ffi.Char> filename, ffi.Pointer<ffi.Pointer<VipsImage>> out, int width) => _thumbnail(filename, out, width, ffi.nullptr);
  int thumbnailBuffer(ffi.Pointer<ffi.Void> buf, int len, ffi.Pointer<ffi.Pointer<VipsImage>> out, int width) => _thumbnailBuffer(buf, len, out, width, ffi.nullptr);
  int thumbnailSource(ffi.Pointer<VipsSource> source, ffi.Pointer<ffi.Pointer<VipsImage>> out, int width) => _thumbnailSource(source, out, width, ffi.nullptr);
}
