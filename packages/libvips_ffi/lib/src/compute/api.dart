import 'package:flutter/foundation.dart';
import 'package:libvips_ffi_core/libvips_ffi_core.dart';

import 'color.dart' as color_ops;
import 'composite.dart' as composite_ops;
import 'filter.dart' as filter_ops;
import 'isolates.dart';
import 'transform.dart' as transform_ops;
import 'types.dart';

/// High-level async API using Flutter's compute function.
///
/// 使用 Flutter 的 compute 函数的高级异步 API。
///
/// This is simpler than the isolate-based API and suitable for
/// one-off operations. For batch processing, consider using
/// [VipsImageAsync] instead.
/// 这比基于 isolate 的 API 更简单，适合一次性操作。
/// 对于批量处理，请考虑使用 [VipsImageAsync]。
///
/// ## Example / 示例
///
/// ```dart
/// // Resize an image from file
/// final result = await VipsCompute.resizeFile('input.jpg', 0.5);
/// print('Resized to ${result.width}x${result.height}');
/// ```
class VipsCompute {
  /// Loads and processes an image from file.
  ///
  /// 从文件加载并处理图像。
  ///
  /// [filePath] is the path to the image file.
  /// [filePath] 是图像文件的路径。
  ///
  /// [operation] is a function that takes a [VipsImageWrapper] and returns
  /// a processed [VipsImageWrapper].
  /// [operation] 是一个接受 [VipsImageWrapper] 并返回处理后的
  /// [VipsImageWrapper] 的函数。
  static Future<VipsComputeResult> processFile(
    String filePath,
    VipsImageWrapper Function(VipsImageWrapper) operation,
  ) async {
    return compute(processFileIsolate, ProcessFileParams(filePath, operation));
  }

  /// Processes image data.
  ///
  /// 处理图像数据。
  ///
  /// [imageData] is the image data in any supported format.
  /// [imageData] 是任何支持格式的图像数据。
  ///
  /// [operation] is a function that takes a [VipsImageWrapper] and returns
  /// a processed [VipsImageWrapper].
  /// [operation] 是一个接受 [VipsImageWrapper] 并返回处理后的
  /// [VipsImageWrapper] 的函数。
  static Future<VipsComputeResult> processData(
    Uint8List imageData,
    VipsImageWrapper Function(VipsImageWrapper) operation,
  ) async {
    return compute(processDataIsolate, ProcessDataParams(imageData, operation));
  }

  // ============ Transform Operations ============
  // ============ 变换操作 ============

  /// Resizes image from file.
  ///
  /// 从文件调整图像大小。
  ///
  /// [filePath] is the path to the image file.
  /// [filePath] 是图像文件的路径。
  ///
  /// [scale] is the resize factor (e.g., 0.5 for half size).
  /// [scale] 是调整大小的因子（例如 0.5 表示一半大小）。
  static Future<VipsComputeResult> resizeFile(String filePath, double scale) {
    return compute(transform_ops.resizeFile, ComputeParams(filePath: filePath, args: {'scale': scale}));
  }

  /// Resizes image from data.
  ///
  /// 从数据调整图像大小。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  /// [scale] is the resize factor. / [scale] 是调整大小的因子。
  static Future<VipsComputeResult> resizeData(Uint8List data, double scale) {
    return compute(transform_ops.resizeData, ComputeParams(imageData: data, args: {'scale': scale}));
  }

  /// Creates thumbnail from file.
  ///
  /// 从文件创建缩略图。
  ///
  /// [filePath] is the path to the image file. / [filePath] 是图像文件的路径。
  /// [width] is the target width in pixels. / [width] 是目标宽度（像素）。
  static Future<VipsComputeResult> thumbnailFile(String filePath, int width) {
    return compute(transform_ops.thumbnailFile, ComputeParams(filePath: filePath, args: {'width': width}));
  }

  /// Creates thumbnail from data.
  ///
  /// 从数据创建缩略图。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  /// [width] is the target width in pixels. / [width] 是目标宽度（像素）。
  static Future<VipsComputeResult> thumbnailData(Uint8List data, int width) {
    return compute(transform_ops.thumbnailData, ComputeParams(imageData: data, args: {'width': width}));
  }

  /// Rotates image from file.
  ///
  /// 从文件旋转图像。
  ///
  /// [filePath] is the path to the image file. / [filePath] 是图像文件的路径。
  /// [angle] is the rotation angle in degrees. / [angle] 是旋转角度（度数）。
  static Future<VipsComputeResult> rotateFile(String filePath, double angle) {
    return compute(transform_ops.rotateFile, ComputeParams(filePath: filePath, args: {'angle': angle}));
  }

  /// Rotates image from data.
  ///
  /// 从数据旋转图像。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  /// [angle] is the rotation angle in degrees. / [angle] 是旋转角度（度数）。
  static Future<VipsComputeResult> rotateData(Uint8List data, double angle) {
    return compute(transform_ops.rotateData, ComputeParams(imageData: data, args: {'angle': angle}));
  }

  /// Crops image from file.
  ///
  /// 从文件裁剪图像。
  ///
  /// [filePath] is the path to the image file. / [filePath] 是图像文件的路径。
  /// [left], [top] specify the top-left corner. / [left]、[top] 指定左上角。
  /// [width], [height] specify the crop size. / [width]、[height] 指定裁剪大小。
  static Future<VipsComputeResult> cropFile(String filePath, int left, int top, int width, int height) {
    return compute(transform_ops.cropFile, ComputeParams(filePath: filePath, args: {
      'left': left, 'top': top, 'width': width, 'height': height,
    }));
  }

  /// Crops image from data.
  ///
  /// 从数据裁剪图像。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  /// [left], [top] specify the top-left corner. / [left]、[top] 指定左上角。
  /// [width], [height] specify the crop size. / [width]、[height] 指定裁剪大小。
  static Future<VipsComputeResult> cropData(Uint8List data, int left, int top, int width, int height) {
    return compute(transform_ops.cropData, ComputeParams(imageData: data, args: {
      'left': left, 'top': top, 'width': width, 'height': height,
    }));
  }

  /// Flips image from file.
  ///
  /// 从文件翻转图像。
  ///
  /// [filePath] is the path to the image file. / [filePath] 是图像文件的路径。
  /// [direction] is the flip direction. / [direction] 是翻转方向。
  static Future<VipsComputeResult> flipFile(String filePath, VipsDirection direction) {
    return compute(transform_ops.flipFile, ComputeParams(filePath: filePath, args: {'direction': direction.index}));
  }

  /// Flips image from data.
  ///
  /// 从数据翻转图像。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  /// [direction] is the flip direction. / [direction] 是翻转方向。
  static Future<VipsComputeResult> flipData(Uint8List data, VipsDirection direction) {
    return compute(transform_ops.flipData, ComputeParams(imageData: data, args: {'direction': direction.index}));
  }

  // ============ Filter Operations ============
  // ============ 滤镜操作 ============

  /// Applies Gaussian blur to image from file.
  ///
  /// 对文件中的图像应用高斯模糊。
  ///
  /// [filePath] is the path to the image file. / [filePath] 是图像文件的路径。
  /// [sigma] is the blur radius. / [sigma] 是模糊半径。
  static Future<VipsComputeResult> blurFile(String filePath, double sigma) {
    return compute(filter_ops.blurFile, ComputeParams(filePath: filePath, args: {'sigma': sigma}));
  }

  /// Applies Gaussian blur to image from data.
  ///
  /// 对数据中的图像应用高斯模糊。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  /// [sigma] is the blur radius. / [sigma] 是模糊半径。
  static Future<VipsComputeResult> blurData(Uint8List data, double sigma) {
    return compute(filter_ops.blurData, ComputeParams(imageData: data, args: {'sigma': sigma}));
  }

  /// Sharpens image from file.
  ///
  /// 从文件锐化图像。
  ///
  /// [filePath] is the path to the image file. / [filePath] 是图像文件的路径。
  static Future<VipsComputeResult> sharpenFile(String filePath) {
    return compute(filter_ops.sharpenFile, ComputeParams(filePath: filePath, args: {}));
  }

  /// Sharpens image from data.
  ///
  /// 从数据锐化图像。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  static Future<VipsComputeResult> sharpenData(Uint8List data) {
    return compute(filter_ops.sharpenData, ComputeParams(imageData: data, args: {}));
  }

  /// Inverts image from file.
  ///
  /// 从文件反转图像颜色。
  ///
  /// [filePath] is the path to the image file. / [filePath] 是图像文件的路径。
  static Future<VipsComputeResult> invertFile(String filePath) {
    return compute(filter_ops.invertFile, ComputeParams(filePath: filePath, args: {}));
  }

  /// Inverts image from data.
  ///
  /// 从数据反转图像颜色。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  static Future<VipsComputeResult> invertData(Uint8List data) {
    return compute(filter_ops.invertData, ComputeParams(imageData: data, args: {}));
  }

  // ============ Color Operations ============
  // ============ 颜色操作 ============

  /// Adjusts brightness of image from file.
  ///
  /// 调整文件中图像的亮度。
  ///
  /// [filePath] is the path to the image file. / [filePath] 是图像文件的路径。
  /// [factor] is the brightness factor (1.0 = no change). / [factor] 是亮度因子（1.0 = 无变化）。
  static Future<VipsComputeResult> brightnessFile(String filePath, double factor) {
    return compute(color_ops.brightnessFile, ComputeParams(filePath: filePath, args: {'factor': factor}));
  }

  /// Adjusts brightness of image from data.
  ///
  /// 调整数据中图像的亮度。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  /// [factor] is the brightness factor (1.0 = no change). / [factor] 是亮度因子（1.0 = 无变化）。
  static Future<VipsComputeResult> brightnessData(Uint8List data, double factor) {
    return compute(color_ops.brightnessData, ComputeParams(imageData: data, args: {'factor': factor}));
  }

  /// Adjusts contrast of image from file.
  ///
  /// 调整文件中图像的对比度。
  ///
  /// [filePath] is the path to the image file. / [filePath] 是图像文件的路径。
  /// [factor] is the contrast factor (1.0 = no change). / [factor] 是对比度因子（1.0 = 无变化）。
  static Future<VipsComputeResult> contrastFile(String filePath, double factor) {
    return compute(color_ops.contrastFile, ComputeParams(filePath: filePath, args: {'factor': factor}));
  }

  /// Adjusts contrast of image from data.
  ///
  /// 调整数据中图像的对比度。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  /// [factor] is the contrast factor (1.0 = no change). / [factor] 是对比度因子（1.0 = 无变化）。
  static Future<VipsComputeResult> contrastData(Uint8List data, double factor) {
    return compute(color_ops.contrastData, ComputeParams(imageData: data, args: {'factor': factor}));
  }

  /// Auto-rotates image from file based on EXIF orientation.
  ///
  /// 根据 EXIF 方向自动旋转文件中的图像。
  ///
  /// [filePath] is the path to the image file. / [filePath] 是图像文件的路径。
  static Future<VipsComputeResult> autoRotateFile(String filePath) {
    return compute(color_ops.autoRotateFile, ComputeParams(filePath: filePath, args: {}));
  }

  /// Auto-rotates image from data based on EXIF orientation.
  ///
  /// 根据 EXIF 方向自动旋转数据中的图像。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  static Future<VipsComputeResult> autoRotateData(Uint8List data) {
    return compute(color_ops.autoRotateData, ComputeParams(imageData: data, args: {}));
  }

  // ============ Composite Operations ============
  // ============ 合成操作 ============

  /// Creates a collage from multiple images.
  ///
  /// 从多张图像创建拼接。
  ///
  /// [items] is the list of images with their positions and sizes.
  /// [items] 是包含位置和大小的图像列表。
  ///
  /// [canvasWidth] is the width of the output canvas.
  /// [canvasWidth] 是输出画布的宽度。
  ///
  /// [canvasHeight] is the height of the output canvas.
  /// [canvasHeight] 是输出画布的高度。
  ///
  /// [backgroundColor] is the background color as RGB hex (e.g., 0xFFFFFF for white).
  /// [backgroundColor] 是背景颜色的 RGB 十六进制值（例如 0xFFFFFF 表示白色）。
  static Future<VipsComputeResult> createCollage(
    List<CollageItemData> items,
    int canvasWidth,
    int canvasHeight, {
    int backgroundColor = 0xFFFFFF,
  }) {
    return compute(composite_ops.createCollage, composite_ops.CollageParams(
      items: items,
      canvasWidth: canvasWidth,
      canvasHeight: canvasHeight,
      backgroundColor: backgroundColor,
    ));
  }
}
