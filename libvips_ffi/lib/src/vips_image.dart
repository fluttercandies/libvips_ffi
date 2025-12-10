import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import 'bindings/vips_bindings_generated.dart';
import 'vips_library.dart';

/// Global libvips bindings instance.
///
/// 全局 libvips 绑定实例。
final VipsBindings _bindings = VipsBindings(vipsLibrary);

// Custom function types for variadic functions that need NULL termination.
// 需要 NULL 终止的可变参数函数的自定义函数类型。
typedef _VipsImageNewFromFileNative = ffi.Pointer<VipsImage> Function(
  ffi.Pointer<ffi.Char> name,
  ffi.Pointer<ffi.Void> terminator, // NULL terminator
);
typedef _VipsImageNewFromFileDart = ffi.Pointer<VipsImage> Function(
  ffi.Pointer<ffi.Char> name,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsImageWriteToFileNative = ffi.Int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Char> name,
  ffi.Pointer<ffi.Void> terminator, // NULL terminator
);
typedef _VipsImageWriteToFileDart = int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Char> name,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsImageWriteToBufferNative = ffi.Int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Char> suffix,
  ffi.Pointer<ffi.Pointer<ffi.Void>> buf,
  ffi.Pointer<ffi.Size> size,
  ffi.Pointer<ffi.Void> terminator, // NULL terminator
);
typedef _VipsImageWriteToBufferDart = int Function(
  ffi.Pointer<VipsImage> image,
  ffi.Pointer<ffi.Char> suffix,
  ffi.Pointer<ffi.Pointer<ffi.Void>> buf,
  ffi.Pointer<ffi.Size> size,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsImageNewFromBufferNative = ffi.Pointer<VipsImage> Function(
  ffi.Pointer<ffi.Void> buf,
  ffi.Size len,
  ffi.Pointer<ffi.Char> optionString,
  ffi.Pointer<ffi.Void> terminator, // NULL terminator
);
typedef _VipsImageNewFromBufferDart = ffi.Pointer<VipsImage> Function(
  ffi.Pointer<ffi.Void> buf,
  int len,
  ffi.Pointer<ffi.Char> optionString,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsResizeNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double scale,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsResizeDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double scale,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsRotateNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double angle,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsRotateDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double angle,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsCropNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int left,
  ffi.Int top,
  ffi.Int width,
  ffi.Int height,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsCropDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int left,
  int top,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsThumbnailImageNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsThumbnailImageDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsThumbnailNative = ffi.Int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsThumbnailDart = int Function(
  ffi.Pointer<ffi.Char> filename,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsThumbnailBufferNative = ffi.Int Function(
  ffi.Pointer<ffi.Void> buf,
  ffi.Size len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsThumbnailBufferDart = int Function(
  ffi.Pointer<ffi.Void> buf,
  int len,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsFlipNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int direction,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsFlipDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int direction,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsGaussblurNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double sigma,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsGaussblurDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double sigma,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsSharpenNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsSharpenDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsInvertNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsInvertDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsFlattenNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsFlattenDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsGammaNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsGammaDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsAutorotNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsAutorotDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsSmartcropNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int width,
  ffi.Int height,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsSmartcropDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsGravityNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int direction,
  ffi.Int width,
  ffi.Int height,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsGravityDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int direction,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsEmbedNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int x,
  ffi.Int y,
  ffi.Int width,
  ffi.Int height,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsEmbedDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int x,
  int y,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsExtractAreaNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int left,
  ffi.Int top,
  ffi.Int width,
  ffi.Int height,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsExtractAreaDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int left,
  int top,
  int width,
  int height,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsColourspaceNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int space,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsColourspaceDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int space,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsCastNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Int format,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsCastDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  int format,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsCopyNative = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsCopyDart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Pointer<ffi.Void> terminator,
);

typedef _VipsLinear1Native = ffi.Int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ffi.Double a,
  ffi.Double b,
  ffi.Pointer<ffi.Void> terminator,
);
typedef _VipsLinear1Dart = int Function(
  ffi.Pointer<VipsImage> in1,
  ffi.Pointer<ffi.Pointer<VipsImage>> out,
  double a,
  double b,
  ffi.Pointer<ffi.Void> terminator,
);

/// Custom bindings for variadic functions that need NULL termination.
///
/// 需要 NULL 终止的可变参数函数的自定义绑定。
///
/// These bindings wrap libvips C functions that use variadic arguments,
/// providing proper NULL termination for safe FFI calls.
/// 这些绑定封装了使用可变参数的 libvips C 函数，
/// 为安全的 FFI 调用提供正确的 NULL 终止。
class _VipsVariadicBindings {
  final ffi.DynamicLibrary _lib;
  
  _VipsVariadicBindings(this._lib);
  
  late final _vipsImageNewFromFile = _lib
      .lookup<ffi.NativeFunction<_VipsImageNewFromFileNative>>('vips_image_new_from_file')
      .asFunction<_VipsImageNewFromFileDart>();
  
  late final _vipsImageWriteToFile = _lib
      .lookup<ffi.NativeFunction<_VipsImageWriteToFileNative>>('vips_image_write_to_file')
      .asFunction<_VipsImageWriteToFileDart>();
  
  late final _vipsImageWriteToBuffer = _lib
      .lookup<ffi.NativeFunction<_VipsImageWriteToBufferNative>>('vips_image_write_to_buffer')
      .asFunction<_VipsImageWriteToBufferDart>();
  
  late final _vipsImageNewFromBuffer = _lib
      .lookup<ffi.NativeFunction<_VipsImageNewFromBufferNative>>('vips_image_new_from_buffer')
      .asFunction<_VipsImageNewFromBufferDart>();
  
  late final _vipsResize = _lib
      .lookup<ffi.NativeFunction<_VipsResizeNative>>('vips_resize')
      .asFunction<_VipsResizeDart>();
  
  late final _vipsRotate = _lib
      .lookup<ffi.NativeFunction<_VipsRotateNative>>('vips_rotate')
      .asFunction<_VipsRotateDart>();
  
  late final _vipsCrop = _lib
      .lookup<ffi.NativeFunction<_VipsCropNative>>('vips_crop')
      .asFunction<_VipsCropDart>();
  
  late final _vipsThumbnailImage = _lib
      .lookup<ffi.NativeFunction<_VipsThumbnailImageNative>>('vips_thumbnail_image')
      .asFunction<_VipsThumbnailImageDart>();
  
  late final _vipsThumbnail = _lib
      .lookup<ffi.NativeFunction<_VipsThumbnailNative>>('vips_thumbnail')
      .asFunction<_VipsThumbnailDart>();
  
  late final _vipsThumbnailBuffer = _lib
      .lookup<ffi.NativeFunction<_VipsThumbnailBufferNative>>('vips_thumbnail_buffer')
      .asFunction<_VipsThumbnailBufferDart>();
  
  ffi.Pointer<VipsImage> imageNewFromFile(ffi.Pointer<ffi.Char> name) {
    return _vipsImageNewFromFile(name, ffi.nullptr);
  }
  
  int imageWriteToFile(ffi.Pointer<VipsImage> image, ffi.Pointer<ffi.Char> name) {
    return _vipsImageWriteToFile(image, name, ffi.nullptr);
  }
  
  int imageWriteToBuffer(
    ffi.Pointer<VipsImage> image,
    ffi.Pointer<ffi.Char> suffix,
    ffi.Pointer<ffi.Pointer<ffi.Void>> buf,
    ffi.Pointer<ffi.Size> size,
  ) {
    return _vipsImageWriteToBuffer(image, suffix, buf, size, ffi.nullptr);
  }
  
  ffi.Pointer<VipsImage> imageNewFromBuffer(
    ffi.Pointer<ffi.Void> buf,
    int len,
    ffi.Pointer<ffi.Char> optionString,
  ) {
    return _vipsImageNewFromBuffer(buf, len, optionString, ffi.nullptr);
  }
  
  int resize(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    double scale,
  ) {
    return _vipsResize(in1, out, scale, ffi.nullptr);
  }
  
  int rotate(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    double angle,
  ) {
    return _vipsRotate(in1, out, angle, ffi.nullptr);
  }
  
  int crop(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    int left,
    int top,
    int width,
    int height,
  ) {
    return _vipsCrop(in1, out, left, top, width, height, ffi.nullptr);
  }
  
  int thumbnailImage(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    int width,
  ) {
    return _vipsThumbnailImage(in1, out, width, ffi.nullptr);
  }
  
  int thumbnail(
    ffi.Pointer<ffi.Char> filename,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    int width,
  ) {
    return _vipsThumbnail(filename, out, width, ffi.nullptr);
  }
  
  int thumbnailBuffer(
    ffi.Pointer<ffi.Void> buf,
    int len,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    int width,
  ) {
    return _vipsThumbnailBuffer(buf, len, out, width, ffi.nullptr);
  }
  
  // Additional image processing functions
  
  late final _vipsFlip = _lib
      .lookup<ffi.NativeFunction<_VipsFlipNative>>('vips_flip')
      .asFunction<_VipsFlipDart>();
  
  late final _vipsGaussblur = _lib
      .lookup<ffi.NativeFunction<_VipsGaussblurNative>>('vips_gaussblur')
      .asFunction<_VipsGaussblurDart>();
  
  late final _vipsSharpen = _lib
      .lookup<ffi.NativeFunction<_VipsSharpenNative>>('vips_sharpen')
      .asFunction<_VipsSharpenDart>();
  
  late final _vipsInvert = _lib
      .lookup<ffi.NativeFunction<_VipsInvertNative>>('vips_invert')
      .asFunction<_VipsInvertDart>();
  
  late final _vipsFlatten = _lib
      .lookup<ffi.NativeFunction<_VipsFlattenNative>>('vips_flatten')
      .asFunction<_VipsFlattenDart>();
  
  late final _vipsGamma = _lib
      .lookup<ffi.NativeFunction<_VipsGammaNative>>('vips_gamma')
      .asFunction<_VipsGammaDart>();
  
  late final _vipsAutorot = _lib
      .lookup<ffi.NativeFunction<_VipsAutorotNative>>('vips_autorot')
      .asFunction<_VipsAutorotDart>();
  
  late final _vipsSmartcrop = _lib
      .lookup<ffi.NativeFunction<_VipsSmartcropNative>>('vips_smartcrop')
      .asFunction<_VipsSmartcropDart>();
  
  late final _vipsGravity = _lib
      .lookup<ffi.NativeFunction<_VipsGravityNative>>('vips_gravity')
      .asFunction<_VipsGravityDart>();
  
  late final _vipsEmbed = _lib
      .lookup<ffi.NativeFunction<_VipsEmbedNative>>('vips_embed')
      .asFunction<_VipsEmbedDart>();
  
  late final _vipsExtractArea = _lib
      .lookup<ffi.NativeFunction<_VipsExtractAreaNative>>('vips_extract_area')
      .asFunction<_VipsExtractAreaDart>();
  
  late final _vipsColourspace = _lib
      .lookup<ffi.NativeFunction<_VipsColourspaceNative>>('vips_colourspace')
      .asFunction<_VipsColourspaceDart>();
  
  late final _vipsCast = _lib
      .lookup<ffi.NativeFunction<_VipsCastNative>>('vips_cast')
      .asFunction<_VipsCastDart>();
  
  late final _vipsCopy = _lib
      .lookup<ffi.NativeFunction<_VipsCopyNative>>('vips_copy')
      .asFunction<_VipsCopyDart>();
  
  late final _vipsLinear1 = _lib
      .lookup<ffi.NativeFunction<_VipsLinear1Native>>('vips_linear1')
      .asFunction<_VipsLinear1Dart>();
  
  int flip(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    int direction,
  ) {
    return _vipsFlip(in1, out, direction, ffi.nullptr);
  }
  
  int gaussblur(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    double sigma,
  ) {
    return _vipsGaussblur(in1, out, sigma, ffi.nullptr);
  }
  
  int sharpen(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ) {
    return _vipsSharpen(in1, out, ffi.nullptr);
  }
  
  int invert(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ) {
    return _vipsInvert(in1, out, ffi.nullptr);
  }
  
  int flatten(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ) {
    return _vipsFlatten(in1, out, ffi.nullptr);
  }
  
  int gamma(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ) {
    return _vipsGamma(in1, out, ffi.nullptr);
  }
  
  int autorot(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ) {
    return _vipsAutorot(in1, out, ffi.nullptr);
  }
  
  int smartcrop(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    int width,
    int height,
  ) {
    return _vipsSmartcrop(in1, out, width, height, ffi.nullptr);
  }
  
  int gravity(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    int direction,
    int width,
    int height,
  ) {
    return _vipsGravity(in1, out, direction, width, height, ffi.nullptr);
  }
  
  int embed(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    int x,
    int y,
    int width,
    int height,
  ) {
    return _vipsEmbed(in1, out, x, y, width, height, ffi.nullptr);
  }
  
  int extractArea(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    int left,
    int top,
    int width,
    int height,
  ) {
    return _vipsExtractArea(in1, out, left, top, width, height, ffi.nullptr);
  }
  
  int colourspace(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    int space,
  ) {
    return _vipsColourspace(in1, out, space, ffi.nullptr);
  }
  
  int cast(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    int format,
  ) {
    return _vipsCast(in1, out, format, ffi.nullptr);
  }
  
  int copy(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
  ) {
    return _vipsCopy(in1, out, ffi.nullptr);
  }
  
  int linear1(
    ffi.Pointer<VipsImage> in1,
    ffi.Pointer<ffi.Pointer<VipsImage>> out,
    double a,
    double b,
  ) {
    return _vipsLinear1(in1, out, a, b, ffi.nullptr);
  }
}

/// Custom variadic bindings instance.
///
/// 自定义可变参数绑定实例。
final _VipsVariadicBindings _variadicBindings = _VipsVariadicBindings(vipsLibrary);

/// Whether libvips has been initialized.
///
/// libvips 是否已初始化。
bool _initialized = false;

/// Initializes libvips.
///
/// 初始化 libvips。
///
/// This must be called before using any other libvips functions.
/// It's safe to call multiple times - subsequent calls are no-ops.
/// 在使用任何其他 libvips 函数之前必须调用此函数。
/// 多次调用是安全的 - 后续调用不执行任何操作。
///
/// [appName] is the application name for libvips logging.
/// [appName] 是用于 libvips 日志记录的应用程序名称。
///
/// Throws [VipsException] if initialization fails.
/// 如果初始化失败，则抛出 [VipsException]。
void initVips([String appName = 'libvips_ffi']) {
  if (_initialized) return;

  final appNamePtr = appName.toNativeUtf8();
  try {
    final result = _bindings.vips_init(appNamePtr.cast());
    if (result != 0) {
      throw VipsException('Failed to initialize libvips: ${getVipsError()}');
    }
    _initialized = true;
  } finally {
    calloc.free(appNamePtr);
  }
}

/// Shuts down libvips and frees resources.
///
/// 关闭 libvips 并释放资源。
///
/// Call this when you're done using libvips.
/// 当你完成 libvips 的使用时调用此函数。
///
/// It's safe to call multiple times - subsequent calls are no-ops.
/// 多次调用是安全的 - 后续调用不执行任何操作。
void shutdownVips() {
  if (!_initialized) return;
  _bindings.vips_shutdown();
  _initialized = false;
}

/// Gets the current libvips error message.
///
/// 获取当前的 libvips 错误消息。
///
/// Returns the error message string, or `null` if no error.
/// 返回错误消息字符串，如果没有错误则返回 `null`。
///
/// The error buffer may contain non-UTF-8 characters, which are handled gracefully.
/// 错误缓冲区可能包含非 UTF-8 字符，这些字符会被优雅地处理。
String? getVipsError() {
  final errorPtr = _bindings.vips_error_buffer();
  if (errorPtr == ffi.nullptr) return null;
  
  try {
    // Try to decode as UTF-8, but handle potential encoding issues
    return errorPtr.cast<Utf8>().toDartString();
  } catch (e) {
    // If UTF-8 decoding fails, try to read as raw bytes and convert
    // This can happen if the error message contains non-UTF-8 characters
    try {
      // Read bytes until null terminator
      final bytes = <int>[];
      var i = 0;
      while (true) {
        final byte = errorPtr.cast<ffi.Uint8>()[i];
        if (byte == 0) break;
        bytes.add(byte);
        i++;
        if (i > 4096) break; // Safety limit
      }
      // Replace invalid UTF-8 sequences
      return String.fromCharCodes(bytes.where((b) => b < 128));
    } catch (_) {
      return 'Error reading vips error buffer';
    }
  }
}

/// Clears the libvips error buffer.
///
/// 清除 libvips 错误缓冲区。
///
/// Call this before operations to ensure you get fresh error messages.
/// 在操作前调用此函数以确保获取最新的错误消息。
void clearVipsError() {
  _bindings.vips_error_clear();
}

/// Gets libvips version information.
///
/// 获取 libvips 版本信息。
///
/// [flag] determines what version info to return:
/// [flag] 决定返回什么版本信息：
///
/// - 0: major version / 主版本号
/// - 1: minor version / 次版本号
/// - 2: micro version / 微版本号
/// - 3: library current / 库当前版本
/// - 4: library revision / 库修订版本
/// - 5: library age / 库年龄
///
/// Returns the requested version number.
/// 返回请求的版本号。
int vipsVersion(int flag) {
  return _bindings.vips_version(flag);
}

/// Gets libvips version as a string (e.g., "8.15.0").
///
/// 以字符串形式获取 libvips 版本（例如 "8.15.0"）。
///
/// Returns a formatted version string in "major.minor.micro" format.
/// 返回格式化的版本字符串，格式为 "主版本.次版本.微版本"。
String get vipsVersionString {
  return '${vipsVersion(0)}.${vipsVersion(1)}.${vipsVersion(2)}';
}

/// Exception thrown by libvips operations.
///
/// libvips 操作抛出的异常。
///
/// This exception is thrown when a libvips operation fails.
/// 当 libvips 操作失败时抛出此异常。
class VipsException implements Exception {
  /// The error message describing what went wrong.
  ///
  /// 描述错误原因的错误消息。
  final String message;

  /// Creates a new [VipsException] with the given [message].
  ///
  /// 使用给定的 [message] 创建新的 [VipsException]。
  VipsException(this.message);

  @override
  String toString() => 'VipsException: $message';
}

/// High-level wrapper for VipsImage.
///
/// VipsImage 的高级封装。
///
/// This class provides a safe, Dart-friendly interface to libvips images.
/// Resources are automatically managed - call [dispose] when done.
/// 此类提供了一个安全的、对 Dart 友好的 libvips 图像接口。
/// 资源自动管理 - 完成后调用 [dispose]。
///
/// ## Example / 示例
///
/// ```dart
/// final image = VipsImageWrapper.fromFile('input.jpg');
/// try {
///   final resized = image.resize(0.5);
///   resized.writeToFile('output.jpg');
///   resized.dispose();
/// } finally {
///   image.dispose();
/// }
/// ```
class VipsImageWrapper {
  final ffi.Pointer<VipsImage> _pointer;
  bool _disposed = false;
  
  /// Buffer pointer that must be kept alive for the lifetime of the image.
  ///
  /// 必须在图像生命周期内保持活动的缓冲区指针。
  ///
  /// This is needed because vips_image_new_from_buffer does lazy loading
  /// and requires the buffer to remain valid until the image is disposed.
  /// 这是必需的，因为 vips_image_new_from_buffer 执行延迟加载，
  /// 需要缓冲区在图像被释放之前保持有效。
  ffi.Pointer<ffi.Uint8>? _bufferPtr;

  VipsImageWrapper._(this._pointer, [this._bufferPtr]);

  /// Whether this image has been disposed.
  ///
  /// 此图像是否已被释放。
  bool get isDisposed => _disposed;

  /// Whether the underlying pointer is null.
  ///
  /// 底层指针是否为空。
  bool get isNull => _pointer == ffi.nullptr;

  /// Gets the underlying pointer (for advanced use).
  ///
  /// 获取底层指针（用于高级用法）。
  ///
  /// Throws [StateError] if the image has been disposed.
  /// 如果图像已被释放，则抛出 [StateError]。
  ffi.Pointer<VipsImage> get pointer {
    _checkDisposed();
    return _pointer;
  }

  /// Loads an image from a file.
  ///
  /// 从文件加载图像。
  ///
  /// [filename] is the path to the image file.
  /// [filename] 是图像文件的路径。
  ///
  /// Throws [VipsException] if loading fails.
  /// 如果加载失败，则抛出 [VipsException]。
  factory VipsImageWrapper.fromFile(String filename) {
    initVips();
    clearVipsError();

    final filenamePtr = filename.toNativeUtf8();
    try {
      // Use custom binding with NULL terminator for variadic function
      final imagePtr = _variadicBindings.imageNewFromFile(filenamePtr.cast());

      if (imagePtr == ffi.nullptr) {
        final error = getVipsError();
        clearVipsError();
        throw VipsException(
          'Failed to load image: $filename. ${error ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(imagePtr);
    } finally {
      calloc.free(filenamePtr);
    }
  }

  /// Loads an image from memory buffer.
  ///
  /// 从内存缓冲区加载图像。
  ///
  /// [data] is the image data in any supported format (JPEG, PNG, etc.).
  /// [data] 是任何支持格式（JPEG、PNG 等）的图像数据。
  ///
  /// [optionString] can specify format options.
  /// [optionString] 可以指定格式选项。
  ///
  /// Throws [VipsException] if loading fails.
  /// 如果加载失败，则抛出 [VipsException]。
  factory VipsImageWrapper.fromBuffer(
    Uint8List data, {
    String optionString = '',
  }) {
    initVips();
    clearVipsError();

    final dataPtr = calloc<ffi.Uint8>(data.length);
    final optionPtr = optionString.toNativeUtf8();

    try {
      // Copy data to native memory
      for (var i = 0; i < data.length; i++) {
        dataPtr[i] = data[i];
      }

      // Use custom binding with NULL terminator for variadic function
      final imagePtr = _variadicBindings.imageNewFromBuffer(
        dataPtr.cast(),
        data.length,
        optionPtr.cast(),
      );

      if (imagePtr == ffi.nullptr) {
        // Free buffer on error
        calloc.free(dataPtr);
        throw VipsException(
          'Failed to load image from buffer. ${getVipsError() ?? "Unknown error"}',
        );
      }

      // IMPORTANT: Do NOT free dataPtr here!
      // vips_image_new_from_buffer does lazy loading and requires the buffer
      // to remain valid until the image is disposed. The buffer will be freed
      // in dispose().
      return VipsImageWrapper._(imagePtr, dataPtr);
    } finally {
      // Only free optionPtr, NOT dataPtr - it must stay alive for lazy loading
      calloc.free(optionPtr);
    }
  }

  /// Gets image width in pixels.
  ///
  /// 获取图像宽度（以像素为单位）。
  int get width {
    _checkDisposed();
    return _bindings.vips_image_get_width(_pointer);
  }

  /// Gets image height in pixels.
  ///
  /// 获取图像高度（以像素为单位）。
  int get height {
    _checkDisposed();
    return _bindings.vips_image_get_height(_pointer);
  }

  /// Gets number of bands (channels) in the image.
  ///
  /// 获取图像的通道数。
  int get bands {
    _checkDisposed();
    return _bindings.vips_image_get_bands(_pointer);
  }

  /// Writes the image to a file.
  ///
  /// 将图像写入文件。
  ///
  /// The format is determined by the file extension.
  /// 格式由文件扩展名决定。
  ///
  /// [filename] is the path to write the image to.
  /// [filename] 是要写入图像的路径。
  ///
  /// Throws [VipsException] if writing fails.
  /// 如果写入失败，则抛出 [VipsException]。
  void writeToFile(String filename) {
    _checkDisposed();
    clearVipsError();

    final filenamePtr = filename.toNativeUtf8();
    try {
      // Use custom binding with NULL terminator for variadic function
      final result = _variadicBindings.imageWriteToFile(_pointer, filenamePtr.cast());

      if (result != 0) {
        throw VipsException(
          'Failed to write image: $filename. ${getVipsError() ?? "Unknown error"}',
        );
      }
    } finally {
      calloc.free(filenamePtr);
    }
  }

  /// Writes the image to a memory buffer.
  ///
  /// 将图像写入内存缓冲区。
  ///
  /// [suffix] determines the format (e.g., '.jpg', '.png', '.webp').
  /// [suffix] 决定格式（例如 '.jpg'、'.png'、'.webp'）。
  ///
  /// Returns the encoded image data.
  /// 返回编码后的图像数据。
  ///
  /// Throws [VipsException] if encoding fails.
  /// 如果编码失败，则抛出 [VipsException]。
  Uint8List writeToBuffer(String suffix) {
    _checkDisposed();
    clearVipsError();

    final suffixPtr = suffix.toNativeUtf8();
    final bufPtr = calloc<ffi.Pointer<ffi.Void>>();
    final sizePtr = calloc<ffi.Size>();

    try {
      // Use custom binding with NULL terminator for variadic function
      final result = _variadicBindings.imageWriteToBuffer(
        _pointer,
        suffixPtr.cast(),
        bufPtr,
        sizePtr,
      );

      if (result != 0) {
        throw VipsException(
          'Failed to write image to buffer. ${getVipsError() ?? "Unknown error"}',
        );
      }

      final size = sizePtr.value;
      final data = Uint8List(size);
      final dataPtr = bufPtr.value.cast<ffi.Uint8>();

      for (var i = 0; i < size; i++) {
        data[i] = dataPtr[i];
      }

      // Free the buffer allocated by vips
      _bindings.g_free(bufPtr.value);

      return data;
    } finally {
      calloc.free(suffixPtr);
      calloc.free(bufPtr);
      calloc.free(sizePtr);
    }
  }

  // ============ Image Processing Operations ============
  // ============ 图像处理操作 ============

  /// Resizes the image by a scale factor.
  ///
  /// 按比例因子调整图像大小。
  ///
  /// [scale] is the resize factor (e.g., 0.5 for half size, 2.0 for double).
  /// [scale] 是调整大小的因子（例如 0.5 表示一半大小，2.0 表示两倍）。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  VipsImageWrapper resize(double scale) {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      // Use custom binding with NULL terminator for variadic function
      final result = _variadicBindings.resize(_pointer, outPtr, scale);

      if (result != 0) {
        throw VipsException(
          'Failed to resize image. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Rotates the image by an angle in degrees.
  ///
  /// 按角度旋转图像。
  ///
  /// [angle] is the rotation angle in degrees (positive = counter-clockwise).
  /// [angle] 是旋转角度（度数，正值 = 逆时针）。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  VipsImageWrapper rotate(double angle) {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      // Use custom binding with NULL terminator for variadic function
      final result = _variadicBindings.rotate(_pointer, outPtr, angle);

      if (result != 0) {
        throw VipsException(
          'Failed to rotate image. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Crops a region from the image.
  ///
  /// 从图像裁剪一个区域。
  ///
  /// [left], [top] specify the top-left corner of the crop region.
  /// [left]、[top] 指定裁剪区域的左上角。
  ///
  /// [width], [height] specify the size of the crop region.
  /// [width]、[height] 指定裁剪区域的大小。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  VipsImageWrapper crop(int left, int top, int width, int height) {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      // Use custom binding with NULL terminator for variadic function
      final result = _variadicBindings.crop(_pointer, outPtr, left, top, width, height);

      if (result != 0) {
        throw VipsException(
          'Failed to crop image. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Creates a thumbnail of the image with a target width.
  ///
  /// 创建指定宽度的图像缩略图。
  ///
  /// This is optimized for creating thumbnails - it will shrink the image
  /// as it loads, making it much faster than loading then resizing.
  /// 这是为创建缩略图优化的 - 它会在加载时缩小图像，
  /// 比先加载再调整大小快得多。
  ///
  /// [targetWidth] is the desired width in pixels. Height is calculated
  /// to maintain aspect ratio.
  /// [targetWidth] 是期望的宽度（像素）。高度会自动计算以保持宽高比。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  VipsImageWrapper thumbnail(int targetWidth) {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      // Use custom binding with NULL terminator for variadic function
      final result = _variadicBindings.thumbnailImage(_pointer, outPtr, targetWidth);

      if (result != 0) {
        throw VipsException(
          'Failed to create thumbnail. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  // ============ Static Factory Methods ============
  // ============ 静态工厂方法 ============

  /// Creates a thumbnail directly from a file path.
  ///
  /// 直接从文件路径创建缩略图。
  ///
  /// This is more efficient than loading then thumbnailing, as it
  /// shrinks the image during load.
  /// 这比先加载再创建缩略图更高效，因为它在加载时就缩小图像。
  ///
  /// [filename] is the path to the image file.
  /// [filename] 是图像文件的路径。
  ///
  /// [targetWidth] is the desired width in pixels.
  /// [targetWidth] 是期望的宽度（像素）。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  static VipsImageWrapper thumbnailFromFile(String filename, int targetWidth) {
    initVips();
    clearVipsError();

    final filenamePtr = filename.toNativeUtf8();
    final outPtr = calloc<ffi.Pointer<VipsImage>>();

    try {
      // Use custom binding with NULL terminator for variadic function
      final result = _variadicBindings.thumbnail(filenamePtr.cast(), outPtr, targetWidth);

      if (result != 0) {
        throw VipsException(
          'Failed to create thumbnail from file: $filename. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(filenamePtr);
      calloc.free(outPtr);
    }
  }

  /// Creates a thumbnail directly from a memory buffer.
  ///
  /// 直接从内存缓冲区创建缩略图。
  ///
  /// This is more efficient than loading then thumbnailing, as it
  /// shrinks the image during load.
  /// 这比先加载再创建缩略图更高效，因为它在加载时就缩小图像。
  ///
  /// [data] is the image data in any supported format.
  /// [data] 是任何支持格式的图像数据。
  ///
  /// [targetWidth] is the desired width in pixels.
  /// [targetWidth] 是期望的宽度（像素）。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  static VipsImageWrapper thumbnailFromBuffer(Uint8List data, int targetWidth) {
    initVips();
    clearVipsError();

    final dataPtr = calloc<ffi.Uint8>(data.length);
    final outPtr = calloc<ffi.Pointer<VipsImage>>();

    try {
      // Copy data to native memory
      for (var i = 0; i < data.length; i++) {
        dataPtr[i] = data[i];
      }

      // Use custom binding with NULL terminator for variadic function
      final result = _variadicBindings.thumbnailBuffer(
        dataPtr.cast(),
        data.length,
        outPtr,
        targetWidth,
      );

      if (result != 0) {
        // Free buffer on error
        calloc.free(dataPtr);
        throw VipsException(
          'Failed to create thumbnail from buffer. ${getVipsError() ?? "Unknown error"}',
        );
      }

      // IMPORTANT: Do NOT free dataPtr here!
      // vips_thumbnail_buffer does lazy loading and requires the buffer
      // to remain valid until the image is disposed. The buffer will be freed
      // in dispose().
      return VipsImageWrapper._(outPtr.value, dataPtr);
    } finally {
      // Only free outPtr, NOT dataPtr - it must stay alive for lazy loading
      calloc.free(outPtr);
    }
  }

  // ============ Additional Image Processing Operations ============
  // ============ 额外的图像处理操作 ============

  /// Flips the image horizontally or vertically.
  ///
  /// 水平或垂直翻转图像。
  ///
  /// [direction] determines the flip direction:
  /// [direction] 决定翻转方向：
  ///
  /// - [VipsDirection.horizontal] (0): flip left-right / 左右翻转
  /// - [VipsDirection.vertical] (1): flip top-bottom / 上下翻转
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  VipsImageWrapper flip(VipsDirection direction) {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = _variadicBindings.flip(_pointer, outPtr, direction.index);

      if (result != 0) {
        throw VipsException(
          'Failed to flip image. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Applies Gaussian blur to the image.
  ///
  /// 对图像应用高斯模糊。
  ///
  /// [sigma] is the standard deviation of the Gaussian (larger = more blur).
  /// Typical values are 1.0 to 10.0.
  /// [sigma] 是高斯分布的标准差（越大 = 越模糊）。
  /// 典型值为 1.0 到 10.0。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  VipsImageWrapper gaussianBlur(double sigma) {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = _variadicBindings.gaussblur(_pointer, outPtr, sigma);

      if (result != 0) {
        throw VipsException(
          'Failed to blur image. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Sharpens the image using unsharp masking.
  ///
  /// 使用反锐化蒙版锐化图像。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  VipsImageWrapper sharpen() {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = _variadicBindings.sharpen(_pointer, outPtr);

      if (result != 0) {
        throw VipsException(
          'Failed to sharpen image. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Inverts the image colors (creates a negative).
  ///
  /// 反转图像颜色（创建负片效果）。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  VipsImageWrapper invert() {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = _variadicBindings.invert(_pointer, outPtr);

      if (result != 0) {
        throw VipsException(
          'Failed to invert image. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Flattens an image with alpha channel to RGB.
  ///
  /// 将带有 alpha 通道的图像平坦化为 RGB。
  ///
  /// The alpha channel is removed and the image is composited against
  /// a white background.
  /// alpha 通道被移除，图像与白色背景合成。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  VipsImageWrapper flatten() {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = _variadicBindings.flatten(_pointer, outPtr);

      if (result != 0) {
        throw VipsException(
          'Failed to flatten image. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Applies gamma correction to the image.
  ///
  /// 对图像应用伽马校正。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  VipsImageWrapper gamma() {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = _variadicBindings.gamma(_pointer, outPtr);

      if (result != 0) {
        throw VipsException(
          'Failed to apply gamma. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Auto-rotates the image based on EXIF orientation tag.
  ///
  /// 根据 EXIF 方向标签自动旋转图像。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  VipsImageWrapper autoRotate() {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = _variadicBindings.autorot(_pointer, outPtr);

      if (result != 0) {
        throw VipsException(
          'Failed to auto-rotate image. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Smart crops the image to the specified size.
  ///
  /// 智能裁剪图像到指定大小。
  ///
  /// Uses attention-based cropping to find the most interesting part
  /// of the image.
  /// 使用基于注意力的裁剪来找到图像中最有趣的部分。
  ///
  /// [width], [height] specify the target size.
  /// [width]、[height] 指定目标大小。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  VipsImageWrapper smartCrop(int width, int height) {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = _variadicBindings.smartcrop(_pointer, outPtr, width, height);

      if (result != 0) {
        throw VipsException(
          'Failed to smart crop image. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Embeds the image in a larger canvas.
  ///
  /// 将图像嵌入到更大的画布中。
  ///
  /// [x], [y] specify the position of the image in the new canvas.
  /// [x]、[y] 指定图像在新画布中的位置。
  ///
  /// [width], [height] specify the size of the new canvas.
  /// [width]、[height] 指定新画布的大小。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  VipsImageWrapper embed(int x, int y, int width, int height) {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = _variadicBindings.embed(_pointer, outPtr, x, y, width, height);

      if (result != 0) {
        throw VipsException(
          'Failed to embed image. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Extracts an area from the image (alias for crop).
  ///
  /// 从图像提取一个区域（crop 的别名）。
  ///
  /// [left], [top] specify the top-left corner.
  /// [left]、[top] 指定左上角。
  ///
  /// [width], [height] specify the size of the area.
  /// [width]、[height] 指定区域的大小。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  VipsImageWrapper extractArea(int left, int top, int width, int height) {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = _variadicBindings.extractArea(_pointer, outPtr, left, top, width, height);

      if (result != 0) {
        throw VipsException(
          'Failed to extract area. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Converts the image to a different colour space.
  ///
  /// 将图像转换为不同的色彩空间。
  ///
  /// [space] is the target colour space (see [VipsInterpretation]).
  /// [space] 是目标色彩空间（参见 [VipsInterpretation]）。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  VipsImageWrapper colourspace(VipsInterpretation space) {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = _variadicBindings.colourspace(_pointer, outPtr, space.value);

      if (result != 0) {
        throw VipsException(
          'Failed to convert colour space. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Applies a linear transformation to the image: out = in * a + b.
  ///
  /// 对图像应用线性变换：out = in * a + b。
  ///
  /// [a] is the multiplier (e.g., 1.2 for 20% brighter).
  /// [a] 是乘数（例如 1.2 表示亮度增加 20%）。
  ///
  /// [b] is the offset (e.g., 10 to add brightness).
  /// [b] 是偏移量（例如 10 表示增加亮度）。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  VipsImageWrapper linear(double a, double b) {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = _variadicBindings.linear1(_pointer, outPtr, a, b);

      if (result != 0) {
        throw VipsException(
          'Failed to apply linear transformation. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Adjusts brightness of the image.
  ///
  /// 调整图像亮度。
  ///
  /// [factor] is the brightness factor:
  /// [factor] 是亮度因子：
  ///
  /// - 1.0 = no change / 无变化
  /// - > 1.0 = brighter / 更亮
  /// - < 1.0 = darker / 更暗
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  VipsImageWrapper brightness(double factor) {
    return linear(factor, 0);
  }

  /// Adjusts contrast of the image.
  ///
  /// 调整图像对比度。
  ///
  /// [factor] is the contrast factor:
  /// [factor] 是对比度因子：
  ///
  /// - 1.0 = no change / 无变化
  /// - > 1.0 = more contrast / 更高对比度
  /// - < 1.0 = less contrast / 更低对比度
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  VipsImageWrapper contrast(double factor) {
    // Contrast adjustment: out = (in - 128) * factor + 128
    return linear(factor, 128 * (1 - factor));
  }

  /// Creates a copy of the image.
  ///
  /// 创建图像的副本。
  ///
  /// Returns a new [VipsImageWrapper]. Remember to dispose it when done.
  /// 返回新的 [VipsImageWrapper]。完成后记得调用 dispose。
  ///
  /// Throws [VipsException] if the operation fails.
  /// 如果操作失败，则抛出 [VipsException]。
  VipsImageWrapper copy() {
    _checkDisposed();
    clearVipsError();

    final outPtr = calloc<ffi.Pointer<VipsImage>>();
    try {
      final result = _variadicBindings.copy(_pointer, outPtr);

      if (result != 0) {
        throw VipsException(
          'Failed to copy image. ${getVipsError() ?? "Unknown error"}',
        );
      }

      return VipsImageWrapper._(outPtr.value);
    } finally {
      calloc.free(outPtr);
    }
  }

  /// Releases the image resources.
  ///
  /// 释放图像资源。
  ///
  /// After calling dispose, this object should not be used anymore.
  /// 调用 dispose 后，此对象不应再被使用。
  void dispose() {
    if (_disposed) return;
    _bindings.g_object_unref(_pointer.cast());
    // Free the buffer pointer if it was allocated (from fromBuffer constructor)
    if (_bufferPtr != null) {
      calloc.free(_bufferPtr!);
      _bufferPtr = null;
    }
    _disposed = true;
  }

  void _checkDisposed() {
    if (_disposed) {
      throw StateError('VipsImage has been disposed');
    }
  }
}

/// Direction for flip operations.
///
/// 翻转操作的方向。
enum VipsDirection {
  /// Flip left-right (horizontal).
  ///
  /// 左右翻转（水平）。
  horizontal,

  /// Flip top-bottom (vertical).
  ///
  /// 上下翻转（垂直）。
  vertical,
}

/// Colour space / interpretation.
///
/// 色彩空间 / 解释。
///
/// This enum represents the various colour spaces and interpretations
/// that libvips supports for image processing.
/// 此枚举表示 libvips 支持的各种色彩空间和图像处理解释。
enum VipsInterpretation {
  /// Error value. / 错误值。
  error(-1),

  /// Many-band image. / 多通道图像。
  multiband(0),

  /// Some kind of single-band image. / 某种单通道图像。
  bw(1),

  /// Histogram or lookup table. / 直方图或查找表。
  histogram(10),

  /// The first three bands are CIE XYZ. / 前三个通道是 CIE XYZ。
  xyz(12),

  /// Pixels are in CIE Lab space. / 像素在 CIE Lab 空间中。
  lab(13),

  /// The first four bands are in CMYK space. / 前四个通道在 CMYK 空间中。
  cmyk(15),

  /// Pixels are CIE LCh space. / 像素在 CIE LCh 空间中。
  labq(16),

  /// Pixels are sRGB. / 像素是 sRGB。
  srgb(22),

  /// Pixels are CIE Yxy. / 像素是 CIE Yxy。
  yxy(23),

  /// Image is in fourier space. / 图像在傅里叶空间中。
  fourier(24),

  /// Generic RGB space. / 通用 RGB 空间。
  rgb(25),

  /// A generic single-channel image. / 通用单通道图像。
  grey16(27),

  /// A generic many-band image. / 通用多通道图像。
  matrix(28),

  /// Pixels are scRGB. / 像素是 scRGB。
  scrgb(29),

  /// Pixels are HSV. / 像素是 HSV。
  hsv(30),

  /// Pixels are in CIE LCh space. / 像素在 CIE LCh 空间中。
  lch(31),

  /// CIE CMC(l:c). / CIE CMC(l:c)。
  cmc(32),

  /// Pixels are in CIE Labs space. / 像素在 CIE Labs 空间中。
  labs(33),

  /// Pixels are sRGB with alpha. / 像素是带 alpha 的 sRGB。
  srgba(34);

  /// Creates a [VipsInterpretation] with the given [value].
  ///
  /// 使用给定的 [value] 创建 [VipsInterpretation]。
  const VipsInterpretation(this.value);

  /// The integer value of this interpretation.
  ///
  /// 此解释的整数值。
  final int value;
}
