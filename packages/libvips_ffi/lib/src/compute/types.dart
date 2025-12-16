import 'package:flutter/foundation.dart';

/// Data for a single image in a collage.
///
/// 拼接中单个图像的数据。
class CollageItemData {
  /// The image data in any supported format.
  ///
  /// 任何支持格式的图像数据。
  final Uint8List imageData;

  /// The x position on the canvas.
  ///
  /// 在画布上的 x 位置。
  final int x;

  /// The y position on the canvas.
  ///
  /// 在画布上的 y 位置。
  final int y;

  /// The target width for the image.
  ///
  /// 图像的目标宽度。
  final int width;

  /// The target height for the image.
  ///
  /// 图像的目标高度。
  final int height;

  /// Creates a [CollageItemData] with the given parameters.
  ///
  /// 使用给定的参数创建 [CollageItemData]。
  CollageItemData({
    required this.imageData,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });
}

/// Result from compute operations.
///
/// 计算操作的结果。
///
/// Contains the processed image data along with its dimensions.
/// 包含处理后的图像数据及其尺寸。
class VipsComputeResult {
  /// The processed image data in PNG format.
  ///
  /// 处理后的图像数据（PNG 格式）。
  final Uint8List data;

  /// The width of the processed image in pixels.
  ///
  /// 处理后图像的宽度（像素）。
  final int width;

  /// The height of the processed image in pixels.
  ///
  /// 处理后图像的高度（像素）。
  final int height;

  /// The number of bands (channels) in the processed image.
  ///
  /// 处理后图像的通道数。
  final int bands;

  /// Creates a [VipsComputeResult] with the given parameters.
  ///
  /// 使用给定的参数创建 [VipsComputeResult]。
  VipsComputeResult({
    required this.data,
    required this.width,
    required this.height,
    required this.bands,
  });
}
