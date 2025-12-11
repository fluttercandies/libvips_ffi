/// 单文件最简 demo - 测试使用 VarArgs 调用 libvips variadic 函数
///
/// 根据 https://github.com/dart-lang/sdk/issues/38578 的讨论，
/// Dart FFI 现在支持 VarArgs 类来处理 variadic 函数。
///
/// 运行: dart run bin/varargs_test.dart <input_image> <output_image>

import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

// ============ 类型定义 ============

// VipsImage 是一个 opaque struct
final class VipsImage extends Opaque {}

// ============ Native 函数类型 (使用 VarArgs) ============

// int vips_init(const char *argv0)
typedef VipsInitNative = Int Function(Pointer<Char>);
typedef VipsInitDart = int Function(Pointer<Char>);

// void vips_shutdown(void)
typedef VipsShutdownNative = Void Function();
typedef VipsShutdownDart = void Function();

// int vips_version(int flag)
typedef VipsVersionNative = Int Function(Int);
typedef VipsVersionDart = int Function(int);

// VipsImage *vips_image_new_from_file(const char *name, ...)
// 使用 VarArgs<(Pointer<Void>,)> 显式传递 NULL 指针作为终止符
typedef VipsImageNewFromFileNative = Pointer<VipsImage> Function(
  Pointer<Char>,
  VarArgs<(Pointer<Void>,)>, // NULL 终止符
);
typedef VipsImageNewFromFileDart = Pointer<VipsImage> Function(
  Pointer<Char>,
  Pointer<Void>, // NULL 终止符
);

// int vips_image_write_to_file(VipsImage *image, const char *name, ...)
typedef VipsImageWriteToFileNative = Int Function(
  Pointer<VipsImage>,
  Pointer<Char>,
  VarArgs<(Pointer<Void>,)>,
);
typedef VipsImageWriteToFileDart = int Function(
  Pointer<VipsImage>,
  Pointer<Char>,
  Pointer<Void>,
);

// int vips_resize(VipsImage *in, VipsImage **out, double scale, ...)
typedef VipsResizeNative = Int Function(
  Pointer<VipsImage>,
  Pointer<Pointer<VipsImage>>,
  Double,
  VarArgs<(Pointer<Void>,)>,
);
typedef VipsResizeDart = int Function(
  Pointer<VipsImage>,
  Pointer<Pointer<VipsImage>>,
  double,
  Pointer<Void>,
);

// int vips_image_get_width(VipsImage *image)
typedef VipsImageGetWidthNative = Int Function(Pointer<VipsImage>);
typedef VipsImageGetWidthDart = int Function(Pointer<VipsImage>);

// int vips_image_get_height(VipsImage *image)
typedef VipsImageGetHeightNative = Int Function(Pointer<VipsImage>);
typedef VipsImageGetHeightDart = int Function(Pointer<VipsImage>);

// void g_object_unref(gpointer object)
typedef GObjectUnrefNative = Void Function(Pointer<Void>);
typedef GObjectUnrefDart = void Function(Pointer<Void>);

// const char *vips_error_buffer(void)
typedef VipsErrorBufferNative = Pointer<Char> Function();
typedef VipsErrorBufferDart = Pointer<Char> Function();

// void vips_error_clear(void)
typedef VipsErrorClearNative = Void Function();
typedef VipsErrorClearDart = void Function();

// ============ 主程序 ============

void main(List<String> args) {
  print('=== VarArgs Test - libvips variadic functions ===\n');

  if (args.length < 2) {
    print('Usage: dart run bin/varargs_test.dart <input> <output>');
    print('Example: dart run bin/varargs_test.dart photo.jpg resized.jpg');
    return;
  }

  final inputPath = args[0];
  final outputPath = args[1];

  // 加载 libvips
  print('Loading libvips...');
  late DynamicLibrary lib;
  try {
    if (Platform.isMacOS) {
      // 尝试多个可能的路径
      final paths = [
        '/opt/homebrew/lib/libvips.dylib', // Apple Silicon
        '/usr/local/lib/libvips.dylib', // Intel
        'libvips.dylib',
      ];
      for (final path in paths) {
        try {
          lib = DynamicLibrary.open(path);
          print('  Loaded from: $path');
          break;
        } catch (_) {
          continue;
        }
      }
    } else if (Platform.isLinux) {
      lib = DynamicLibrary.open('libvips.so.42');
    } else if (Platform.isWindows) {
      lib = DynamicLibrary.open('libvips-42.dll');
    } else {
      print('Unsupported platform');
      return;
    }
    print('  libvips loaded successfully');
  } catch (e) {
    print('  Failed to load libvips: $e');
    return;
  }

  // 绑定函数
  final vipsInit = lib
      .lookup<NativeFunction<VipsInitNative>>('vips_init')
      .asFunction<VipsInitDart>();

  final vipsShutdown = lib
      .lookup<NativeFunction<VipsShutdownNative>>('vips_shutdown')
      .asFunction<VipsShutdownDart>();

  final vipsVersion = lib
      .lookup<NativeFunction<VipsVersionNative>>('vips_version')
      .asFunction<VipsVersionDart>();

  final vipsImageNewFromFile = lib
      .lookup<NativeFunction<VipsImageNewFromFileNative>>(
          'vips_image_new_from_file')
      .asFunction<VipsImageNewFromFileDart>();

  final vipsImageWriteToFile = lib
      .lookup<NativeFunction<VipsImageWriteToFileNative>>(
          'vips_image_write_to_file')
      .asFunction<VipsImageWriteToFileDart>();

  final vipsResize = lib
      .lookup<NativeFunction<VipsResizeNative>>('vips_resize')
      .asFunction<VipsResizeDart>();

  final vipsImageGetWidth = lib
      .lookup<NativeFunction<VipsImageGetWidthNative>>('vips_image_get_width')
      .asFunction<VipsImageGetWidthDart>();

  final vipsImageGetHeight = lib
      .lookup<NativeFunction<VipsImageGetHeightNative>>('vips_image_get_height')
      .asFunction<VipsImageGetHeightDart>();

  final gObjectUnref = lib
      .lookup<NativeFunction<GObjectUnrefNative>>('g_object_unref')
      .asFunction<GObjectUnrefDart>();

  final vipsErrorBuffer = lib
      .lookup<NativeFunction<VipsErrorBufferNative>>('vips_error_buffer')
      .asFunction<VipsErrorBufferDart>();

  final vipsErrorClear = lib
      .lookup<NativeFunction<VipsErrorClearNative>>('vips_error_clear')
      .asFunction<VipsErrorClearDart>();

  // 初始化 libvips
  print('\nInitializing libvips...');
  final appName = 'varargs_test'.toNativeUtf8();
  final initResult = vipsInit(appName.cast());
  calloc.free(appName);

  if (initResult != 0) {
    print('  Failed to initialize libvips');
    return;
  }

  final major = vipsVersion(0);
  final minor = vipsVersion(1);
  final micro = vipsVersion(2);
  print('  libvips version: $major.$minor.$micro');

  // 加载图片
  print('\nLoading image: $inputPath');
  vipsErrorClear();
  final inputPathPtr = inputPath.toNativeUtf8();
  final image = vipsImageNewFromFile(inputPathPtr.cast(), nullptr);
  calloc.free(inputPathPtr);

  if (image == nullptr) {
    final errorPtr = vipsErrorBuffer();
    String error = 'Unknown error';
    if (errorPtr != nullptr) {
      try {
        error = errorPtr.cast<Utf8>().toDartString();
      } catch (_) {
        error = 'Error buffer not readable';
      }
    }
    print('  Failed to load image: $error');
    vipsShutdown();
    return;
  }

  final width = vipsImageGetWidth(image);
  final height = vipsImageGetHeight(image);
  print('  Original size: ${width}x$height');

  // 缩放图片
  print('\nResizing to 50%...');
  vipsErrorClear();
  final outPtr = calloc<Pointer<VipsImage>>();
  final resizeResult = vipsResize(image, outPtr, 0.5, nullptr);

  if (resizeResult != 0) {
    final error = vipsErrorBuffer().cast<Utf8>().toDartString();
    print('  Failed to resize: $error');
    gObjectUnref(image.cast());
    calloc.free(outPtr);
    vipsShutdown();
    return;
  }

  final resized = outPtr.value;
  final newWidth = vipsImageGetWidth(resized);
  final newHeight = vipsImageGetHeight(resized);
  print('  Resized size: ${newWidth}x$newHeight');

  // 保存图片
  print('\nSaving to: $outputPath');
  vipsErrorClear();
  final outputPathPtr = outputPath.toNativeUtf8();
  final writeResult = vipsImageWriteToFile(resized, outputPathPtr.cast(), nullptr);
  calloc.free(outputPathPtr);

  if (writeResult != 0) {
    final error = vipsErrorBuffer().cast<Utf8>().toDartString();
    print('  Failed to save: $error');
  } else {
    print('  Saved successfully!');
  }

  // 清理
  gObjectUnref(resized.cast());
  gObjectUnref(image.cast());
  calloc.free(outPtr);

  vipsShutdown();
  print('\nlibvips shutdown.');
}
