import 'package:flutter/foundation.dart';
import 'package:libvips_ffi_core/libvips_ffi_core.dart';

import 'platform_loader.dart';

/// Parameters for compute operations.
///
/// 计算操作的参数。
class _ComputeParams {
  final String? filePath;
  final Uint8List? imageData;
  final Map<String, dynamic> args;

  _ComputeParams({
    this.filePath,
    this.imageData,
    required this.args,
  });
}

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

/// Parameters for collage creation.
///
/// 创建拼接的参数。
class _CollageParams {
  final List<CollageItemData> items;
  final int canvasWidth;
  final int canvasHeight;
  final int backgroundColor;

  _CollageParams({
    required this.items,
    required this.canvasWidth,
    required this.canvasHeight,
    required this.backgroundColor,
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
    return compute(_processFileIsolate, _ProcessFileParams(filePath, operation));
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
    return compute(_processDataIsolate, _ProcessDataParams(imageData, operation));
  }

  // ============ Convenience methods ============
  // ============ 便捷方法 ============

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
    return compute(_resizeFile, _ComputeParams(filePath: filePath, args: {'scale': scale}));
  }

  /// Resizes image from data.
  ///
  /// 从数据调整图像大小。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  /// [scale] is the resize factor. / [scale] 是调整大小的因子。
  static Future<VipsComputeResult> resizeData(Uint8List data, double scale) {
    return compute(_resizeData, _ComputeParams(imageData: data, args: {'scale': scale}));
  }

  /// Creates thumbnail from file.
  ///
  /// 从文件创建缩略图。
  ///
  /// [filePath] is the path to the image file. / [filePath] 是图像文件的路径。
  /// [width] is the target width in pixels. / [width] 是目标宽度（像素）。
  static Future<VipsComputeResult> thumbnailFile(String filePath, int width) {
    return compute(_thumbnailFile, _ComputeParams(filePath: filePath, args: {'width': width}));
  }

  /// Creates thumbnail from data.
  ///
  /// 从数据创建缩略图。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  /// [width] is the target width in pixels. / [width] 是目标宽度（像素）。
  static Future<VipsComputeResult> thumbnailData(Uint8List data, int width) {
    return compute(_thumbnailData, _ComputeParams(imageData: data, args: {'width': width}));
  }

  /// Rotates image from file.
  ///
  /// 从文件旋转图像。
  ///
  /// [filePath] is the path to the image file. / [filePath] 是图像文件的路径。
  /// [angle] is the rotation angle in degrees. / [angle] 是旋转角度（度数）。
  static Future<VipsComputeResult> rotateFile(String filePath, double angle) {
    return compute(_rotateFile, _ComputeParams(filePath: filePath, args: {'angle': angle}));
  }

  /// Rotates image from data.
  ///
  /// 从数据旋转图像。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  /// [angle] is the rotation angle in degrees. / [angle] 是旋转角度（度数）。
  static Future<VipsComputeResult> rotateData(Uint8List data, double angle) {
    return compute(_rotateData, _ComputeParams(imageData: data, args: {'angle': angle}));
  }

  /// Crops image from file.
  ///
  /// 从文件裁剪图像。
  ///
  /// [filePath] is the path to the image file. / [filePath] 是图像文件的路径。
  /// [left], [top] specify the top-left corner. / [left]、[top] 指定左上角。
  /// [width], [height] specify the crop size. / [width]、[height] 指定裁剪大小。
  static Future<VipsComputeResult> cropFile(String filePath, int left, int top, int width, int height) {
    return compute(_cropFile, _ComputeParams(filePath: filePath, args: {
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
    return compute(_cropData, _ComputeParams(imageData: data, args: {
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
    return compute(_flipFile, _ComputeParams(filePath: filePath, args: {'direction': direction.index}));
  }

  /// Flips image from data.
  ///
  /// 从数据翻转图像。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  /// [direction] is the flip direction. / [direction] 是翻转方向。
  static Future<VipsComputeResult> flipData(Uint8List data, VipsDirection direction) {
    return compute(_flipData, _ComputeParams(imageData: data, args: {'direction': direction.index}));
  }

  /// Applies Gaussian blur from file.
  ///
  /// 从文件应用高斯模糊。
  ///
  /// [filePath] is the path to the image file. / [filePath] 是图像文件的路径。
  /// [sigma] is the blur amount. / [sigma] 是模糊程度。
  static Future<VipsComputeResult> blurFile(String filePath, double sigma) {
    return compute(_blurFile, _ComputeParams(filePath: filePath, args: {'sigma': sigma}));
  }

  /// Applies Gaussian blur from data.
  ///
  /// 从数据应用高斯模糊。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  /// [sigma] is the blur amount. / [sigma] 是模糊程度。
  static Future<VipsComputeResult> blurData(Uint8List data, double sigma) {
    return compute(_blurData, _ComputeParams(imageData: data, args: {'sigma': sigma}));
  }

  /// Sharpens image from file.
  ///
  /// 从文件锐化图像。
  ///
  /// [filePath] is the path to the image file. / [filePath] 是图像文件的路径。
  static Future<VipsComputeResult> sharpenFile(String filePath) {
    return compute(_sharpenFile, _ComputeParams(filePath: filePath, args: {}));
  }

  /// Sharpens image from data.
  ///
  /// 从数据锐化图像。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  static Future<VipsComputeResult> sharpenData(Uint8List data) {
    return compute(_sharpenData, _ComputeParams(imageData: data, args: {}));
  }

  /// Inverts image from file.
  ///
  /// 从文件反转图像颜色。
  ///
  /// [filePath] is the path to the image file. / [filePath] 是图像文件的路径。
  static Future<VipsComputeResult> invertFile(String filePath) {
    return compute(_invertFile, _ComputeParams(filePath: filePath, args: {}));
  }

  /// Inverts image from data.
  ///
  /// 从数据反转图像颜色。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  static Future<VipsComputeResult> invertData(Uint8List data) {
    return compute(_invertData, _ComputeParams(imageData: data, args: {}));
  }

  /// Adjusts brightness from file.
  ///
  /// 从文件调整亮度。
  ///
  /// [filePath] is the path to the image file. / [filePath] 是图像文件的路径。
  /// [factor] is the brightness factor (1.0 = no change). / [factor] 是亮度因子（1.0 = 无变化）。
  static Future<VipsComputeResult> brightnessFile(String filePath, double factor) {
    return compute(_brightnessFile, _ComputeParams(filePath: filePath, args: {'factor': factor}));
  }

  /// Adjusts brightness from data.
  ///
  /// 从数据调整亮度。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  /// [factor] is the brightness factor (1.0 = no change). / [factor] 是亮度因子（1.0 = 无变化）。
  static Future<VipsComputeResult> brightnessData(Uint8List data, double factor) {
    return compute(_brightnessData, _ComputeParams(imageData: data, args: {'factor': factor}));
  }

  /// Adjusts contrast from file.
  ///
  /// 从文件调整对比度。
  ///
  /// [filePath] is the path to the image file. / [filePath] 是图像文件的路径。
  /// [factor] is the contrast factor (1.0 = no change). / [factor] 是对比度因子（1.0 = 无变化）。
  static Future<VipsComputeResult> contrastFile(String filePath, double factor) {
    return compute(_contrastFile, _ComputeParams(filePath: filePath, args: {'factor': factor}));
  }

  /// Adjusts contrast from data.
  ///
  /// 从数据调整对比度。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  /// [factor] is the contrast factor (1.0 = no change). / [factor] 是对比度因子（1.0 = 无变化）。
  static Future<VipsComputeResult> contrastData(Uint8List data, double factor) {
    return compute(_contrastData, _ComputeParams(imageData: data, args: {'factor': factor}));
  }

  /// Auto-rotates image from file based on EXIF orientation.
  ///
  /// 根据 EXIF 方向从文件自动旋转图像。
  ///
  /// [filePath] is the path to the image file. / [filePath] 是图像文件的路径。
  static Future<VipsComputeResult> autoRotateFile(String filePath) {
    return compute(_autoRotateFile, _ComputeParams(filePath: filePath, args: {}));
  }

  /// Auto-rotates image from data based on EXIF orientation.
  ///
  /// 根据 EXIF 方向从数据自动旋转图像。
  ///
  /// [data] is the image data. / [data] 是图像数据。
  static Future<VipsComputeResult> autoRotateData(Uint8List data) {
    return compute(_autoRotateData, _ComputeParams(imageData: data, args: {}));
  }

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
    return compute(_createCollage, _CollageParams(
      items: items,
      canvasWidth: canvasWidth,
      canvasHeight: canvasHeight,
      backgroundColor: backgroundColor,
    ));
  }
}

// ============ Isolate entry points ============
// ============ Isolate 入口点 ============

/// Parameters for processing a file.
///
/// 处理文件的参数。
class _ProcessFileParams {
  final String filePath;
  final VipsImageWrapper Function(VipsImageWrapper) operation;
  _ProcessFileParams(this.filePath, this.operation);
}

/// Parameters for processing image data.
///
/// 处理图像数据的参数。
class _ProcessDataParams {
  final Uint8List imageData;
  final VipsImageWrapper Function(VipsImageWrapper) operation;
  _ProcessDataParams(this.imageData, this.operation);
}

VipsComputeResult _processFileIsolate(_ProcessFileParams params) {
  initVips();
  final image = VipsImageWrapper.fromFile(params.filePath);
  final result = params.operation(image);
  final data = result.writeToBuffer('.png');
  final output = VipsComputeResult(
    data: data,
    width: result.width,
    height: result.height,
    bands: result.bands,
  );
  result.dispose();
  image.dispose();
  return output;
}

VipsComputeResult _processDataIsolate(_ProcessDataParams params) {
  initVips();
  final image = VipsImageWrapper.fromBuffer(params.imageData);
  final result = params.operation(image);
  final data = result.writeToBuffer('.png');
  final output = VipsComputeResult(
    data: data,
    width: result.width,
    height: result.height,
    bands: result.bands,
  );
  result.dispose();
  image.dispose();
  return output;
}

// Helper to process from file.
// 从文件处理的辅助函数。
VipsComputeResult _processFromFile(String filePath, VipsImageWrapper Function(VipsImageWrapper) op) {
  initVips();
  final image = VipsImageWrapper.fromFile(filePath);
  final result = op(image);
  final data = result.writeToBuffer('.png');
  final output = VipsComputeResult(
    data: data,
    width: result.width,
    height: result.height,
    bands: result.bands,
  );
  result.dispose();
  image.dispose();
  return output;
}

// Helper to process from data.
// 从数据处理的辅助函数。
VipsComputeResult _processFromData(Uint8List imageData, VipsImageWrapper Function(VipsImageWrapper) op) {
  initVips();
  final image = VipsImageWrapper.fromBuffer(imageData);
  final result = op(image);
  final data = result.writeToBuffer('.png');
  final output = VipsComputeResult(
    data: data,
    width: result.width,
    height: result.height,
    bands: result.bands,
  );
  result.dispose();
  image.dispose();
  return output;
}

// Specific operation isolate functions.
// 特定操作的 isolate 函数。
VipsComputeResult _resizeFile(_ComputeParams p) =>
    _processFromFile(p.filePath!, (img) => img.resize(p.args['scale'] as double));

VipsComputeResult _resizeData(_ComputeParams p) =>
    _processFromData(p.imageData!, (img) => img.resize(p.args['scale'] as double));

VipsComputeResult _thumbnailFile(_ComputeParams p) =>
    _processFromFile(p.filePath!, (img) => img.thumbnail(p.args['width'] as int));

VipsComputeResult _thumbnailData(_ComputeParams p) =>
    _processFromData(p.imageData!, (img) => img.thumbnail(p.args['width'] as int));

VipsComputeResult _rotateFile(_ComputeParams p) =>
    _processFromFile(p.filePath!, (img) => img.rotate(p.args['angle'] as double));

VipsComputeResult _rotateData(_ComputeParams p) =>
    _processFromData(p.imageData!, (img) => img.rotate(p.args['angle'] as double));

VipsComputeResult _cropFile(_ComputeParams p) =>
    _processFromFile(p.filePath!, (img) => img.crop(
      p.args['left'] as int,
      p.args['top'] as int,
      p.args['width'] as int,
      p.args['height'] as int,
    ));

VipsComputeResult _cropData(_ComputeParams p) =>
    _processFromData(p.imageData!, (img) => img.crop(
      p.args['left'] as int,
      p.args['top'] as int,
      p.args['width'] as int,
      p.args['height'] as int,
    ));

VipsComputeResult _flipFile(_ComputeParams p) =>
    _processFromFile(p.filePath!, (img) => img.flip(VipsDirection.values[p.args['direction'] as int]));

VipsComputeResult _flipData(_ComputeParams p) =>
    _processFromData(p.imageData!, (img) => img.flip(VipsDirection.values[p.args['direction'] as int]));

VipsComputeResult _blurFile(_ComputeParams p) =>
    _processFromFile(p.filePath!, (img) => img.gaussianBlur(p.args['sigma'] as double));

VipsComputeResult _blurData(_ComputeParams p) =>
    _processFromData(p.imageData!, (img) => img.gaussianBlur(p.args['sigma'] as double));

VipsComputeResult _sharpenFile(_ComputeParams p) =>
    _processFromFile(p.filePath!, (img) => img.sharpen());

VipsComputeResult _sharpenData(_ComputeParams p) =>
    _processFromData(p.imageData!, (img) => img.sharpen());

VipsComputeResult _invertFile(_ComputeParams p) =>
    _processFromFile(p.filePath!, (img) => img.invert());

VipsComputeResult _invertData(_ComputeParams p) =>
    _processFromData(p.imageData!, (img) => img.invert());

VipsComputeResult _brightnessFile(_ComputeParams p) =>
    _processFromFile(p.filePath!, (img) => img.brightness(p.args['factor'] as double));

VipsComputeResult _brightnessData(_ComputeParams p) =>
    _processFromData(p.imageData!, (img) => img.brightness(p.args['factor'] as double));

VipsComputeResult _contrastFile(_ComputeParams p) =>
    _processFromFile(p.filePath!, (img) => img.contrast(p.args['factor'] as double));

VipsComputeResult _contrastData(_ComputeParams p) =>
    _processFromData(p.imageData!, (img) => img.contrast(p.args['factor'] as double));

VipsComputeResult _autoRotateFile(_ComputeParams p) =>
    _processFromFile(p.filePath!, (img) => img.autoRotate());

VipsComputeResult _autoRotateData(_ComputeParams p) =>
    _processFromData(p.imageData!, (img) => img.autoRotate());

/// Creates a collage from multiple images.
///
/// 从多张图像创建拼接。
VipsComputeResult _createCollage(_CollageParams p) {
  initVips();
  
  // Extract RGB from background color
  final r = (p.backgroundColor >> 16) & 0xFF;
  final g = (p.backgroundColor >> 8) & 0xFF;
  final b = p.backgroundColor & 0xFF;
  
  // Create canvas with solid color background (3-band RGB)
  var canvas = VipsImageWrapper.solidColor(p.canvasWidth, p.canvasHeight, r: r, g: g, b: b);
  
  // Debug: print canvas info
  // ignore: avoid_print
  print('[_createCollage] Canvas created: ${canvas.width}x${canvas.height}, bands=${canvas.bands}');
  
  // Keep track of all images to dispose after writing
  // This is important because libvips uses lazy loading
  final imagesToDispose = <VipsImageWrapper>[canvas];
  
  // Insert each image onto the canvas
  for (int i = 0; i < p.items.length; i++) {
    final item = p.items[i];
    // Load the image
    var img = VipsImageWrapper.fromBuffer(item.imageData);
    imagesToDispose.add(img);
    
    // ignore: avoid_print
    print('[_createCollage] Image $i loaded: ${img.width}x${img.height}, bands=${img.bands}');
    
    // Convert to 3-band sRGB if needed
    // First, convert to sRGB color space to handle CMYK and other formats
    if (img.bands >= 3) {
      try {
        final srgb = img.colourspace(VipsInterpretation.srgb);
        imagesToDispose.add(srgb);
        // ignore: avoid_print
        print('[_createCollage] Image $i converted to sRGB: ${srgb.bands} bands');
        
        // If still has alpha (4 bands), flatten it
        if (srgb.bands == 4) {
          final flattened = srgb.flatten();
          imagesToDispose.add(flattened);
          img = flattened;
          // ignore: avoid_print
          print('[_createCollage] Image $i flattened to ${img.bands} bands');
        } else {
          img = srgb;
        }
      } catch (e) {
        // ignore: avoid_print
        print('[_createCollage] Image $i colourspace conversion failed: $e');
      }
    }
    
    // Calculate scale to fit target dimensions
    final scaleX = item.width / img.width;
    final scaleY = item.height / img.height;
    final scale = scaleX < scaleY ? scaleX : scaleY;
    
    // Resize if needed
    VipsImageWrapper resized;
    if ((scale - 1.0).abs() > 0.01) {
      resized = img.resize(scale);
      imagesToDispose.add(resized);
      // ignore: avoid_print
      print('[_createCollage] Image $i resized: ${resized.width}x${resized.height} (scale=$scale)');
    } else {
      resized = img;
    }
    
    // ignore: avoid_print
    print('[_createCollage] Inserting image $i at (${item.x}, ${item.y})');
    
    // Insert into canvas
    final newCanvas = canvas.insert(resized, item.x, item.y);
    imagesToDispose.add(newCanvas);
    canvas = newCanvas;
    
    // ignore: avoid_print
    print('[_createCollage] Canvas after insert: ${canvas.width}x${canvas.height}');
  }
  
  // Write result to buffer BEFORE disposing any images
  final data = canvas.writeToBuffer('.png');
  final output = VipsComputeResult(
    data: data,
    width: canvas.width,
    height: canvas.height,
    bands: canvas.bands,
  );
  
  // Now dispose all images
  for (final img in imagesToDispose) {
    img.dispose();
  }
  
  return output;
}
