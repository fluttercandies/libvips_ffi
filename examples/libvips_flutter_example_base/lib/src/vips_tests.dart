import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:libvips_ffi/libvips_ffi.dart';
import 'package:path_provider/path_provider.dart';

/// Test result callback
typedef TestResultCallback = void Function(String result, Uint8List? imageData);

/// Log callback
typedef LogCallback = void Function(String message);

/// PipelineSpec test operation type (takes file path, returns image data)
typedef PipelineSpecTestOperation = Future<Uint8List> Function(String filePath);

/// Pipeline callback test operation type
typedef PipelineCallbackOperation = VipsPipeline Function(VipsPipeline pipeline);

/// Vips test runner using async API (runs in isolate)
class VipsTestRunner {
  final LogCallback? onLog;

  VipsTestRunner({this.onLog});

  void _log(String message) {
    onLog?.call(message);
  }

  /// Gets the current pointer leak report.
  ///
  /// 获取当前指针泄漏报告。
  String getLeakReport() {
    return VipsPointerManager.instance.getLeakReport();
  }

  /// Gets the number of active (potentially leaked) pointers.
  ///
  /// 获取活跃（可能泄漏）的指针数量。
  int get activePointerCount => VipsPointerManager.instance.activeCount;

  /// Whether there are any potential memory leaks.
  ///
  /// 是否有任何潜在的内存泄漏。
  bool get hasLeaks => VipsPointerManager.instance.hasLeaks;

  /// Enables stack trace tracking for leak debugging.
  ///
  /// 启用堆栈跟踪以进行泄漏调试。
  void enableStackTraceTracking() {
    VipsPointerManager.instance.trackStackTraces = true;
  }

  /// Disables stack trace tracking.
  ///
  /// 禁用堆栈跟踪。
  void disableStackTraceTracking() {
    VipsPointerManager.instance.trackStackTraces = false;
  }

  /// Forces disposal of all active pointers (emergency cleanup).
  ///
  /// 强制释放所有活跃指针（紧急清理）。
  ///
  /// Returns the number of pointers that were disposed.
  /// 返回已释放的指针数量。
  int forceDisposeAll() {
    _log('WARNING: Force disposing all active pointers!');
    final count = VipsPointerManager.instance.forceDisposeAll();
    _log('Disposed $count pointers');
    return count;
  }

  /// Resets the pointer manager state.
  ///
  /// 重置指针管理器状态。
  void resetPointerManager() {
    VipsPointerManager.instance.reset();
  }

  /// Gets pointer usage statistics.
  ///
  /// 获取指针使用统计信息。
  Map<String, dynamic> getPointerStatistics() {
    return VipsPointerManager.instance.getStatistics();
  }

  /// Run all tests using VipsPipelineCompute
  Future<(String, Uint8List?)> runAllTests(String imagePath) async {
    _log('=== Running All Tests (VipsPipelineCompute) ===');
    _log('Image path: $imagePath');

    final result = StringBuffer();
    final stopwatch = Stopwatch()..start();

    // Load the image to get dimensions
    _log('Loading image...');
    final loadResult = await VipsPipelineCompute.processFile(
      imagePath,
      (p) => p,
    );
    _log('Image loaded: ${loadResult.width}x${loadResult.height}, ${loadResult.bands} bands');
    result.writeln(
        '✓ Image loaded: ${loadResult.width}x${loadResult.height}, ${loadResult.bands} bands');

    // Test resize
    _log('Testing resize...');
    final resized = await VipsPipelineCompute.processFile(
      imagePath,
      (p) => p.resize(0.5),
    );
    _log('Resize result: ${resized.width}x${resized.height}');
    result.writeln('✓ Resize (0.5x): ${resized.width}x${resized.height}');

    // Test thumbnail
    _log('Testing thumbnail...');
    final thumb = await VipsPipelineCompute.processFile(
      imagePath,
      (p) => p.thumbnail(200),
    );
    _log('Thumbnail result: ${thumb.width}x${thumb.height}');
    result.writeln('✓ Thumbnail (200px): ${thumb.width}x${thumb.height}');

    // Test rotate
    _log('Testing rotate...');
    final rotated = await VipsPipelineCompute.processFile(
      imagePath,
      (p) => p.rotate(45),
    );
    _log('Rotate result: ${rotated.width}x${rotated.height}');
    result.writeln('✓ Rotate (45°): ${rotated.width}x${rotated.height}');

    // Test crop (if image is large enough)
    if (loadResult.width >= 100 && loadResult.height >= 100) {
      _log('Testing crop...');
      final cropped = await VipsPipelineCompute.processFile(
        imagePath,
        (p) => p.crop(0, 0, 100, 100),
      );
      _log('Crop result: ${cropped.width}x${cropped.height}');
      result.writeln('✓ Crop (100x100): ${cropped.width}x${cropped.height}');
    }

    // Test flip
    _log('Testing flip...');
    final flipped = await VipsPipelineCompute.processFile(
      imagePath,
      (p) => p.flip(VipsDirection.horizontal),
    );
    _log('Flip result: ${flipped.width}x${flipped.height}');
    result.writeln('✓ Flip horizontal: ${flipped.width}x${flipped.height}');

    // Test blur
    _log('Testing blur...');
    final blurred = await VipsPipelineCompute.processFile(
      imagePath,
      (p) => p.thumbnail(200).blur(3.0),
    );
    _log('Blur result: ${blurred.width}x${blurred.height}');
    result.writeln('✓ Gaussian blur (σ=3): ${blurred.width}x${blurred.height}');

    // Test sharpen
    _log('Testing sharpen...');
    final sharpened = await VipsPipelineCompute.processFile(
      imagePath,
      (p) => p.thumbnail(200).sharpen(),
    );
    _log('Sharpen result: ${sharpened.width}x${sharpened.height}');
    result.writeln('✓ Sharpen: ${sharpened.width}x${sharpened.height}');

    // Test invert
    _log('Testing invert...');
    final inverted = await VipsPipelineCompute.processFile(
      imagePath,
      (p) => p.thumbnail(200).invert(),
    );
    _log('Invert result: ${inverted.width}x${inverted.height}');
    result.writeln('✓ Invert: ${inverted.width}x${inverted.height}');

    // Test brightness
    _log('Testing brightness...');
    final brighter = await VipsPipelineCompute.processFile(
      imagePath,
      (p) => p.thumbnail(200).linear(1.2, 0),
    );
    _log('Brightness result: ${brighter.width}x${brighter.height}');
    result.writeln('✓ Brightness +20%: ${brighter.width}x${brighter.height}');

    // Test contrast
    _log('Testing contrast...');
    final contrasted = await VipsPipelineCompute.processFile(
      imagePath,
      (p) => p.thumbnail(200).linear(1.3, 128 * (1 - 1.3)),
    );
    _log('Contrast result: ${contrasted.width}x${contrasted.height}');
    result.writeln('✓ Contrast +30%: ${contrasted.width}x${contrasted.height}');

    // Test auto rotate
    _log('Testing auto rotate...');
    final autoRotated = await VipsPipelineCompute.processFile(
      imagePath,
      (p) => p.autoRotate(),
    );
    _log('Auto rotate result: ${autoRotated.width}x${autoRotated.height}');
    result.writeln('✓ Auto rotate: ${autoRotated.width}x${autoRotated.height}');

    // Test write to buffer (JPEG)
    _log('Testing writeToBuffer (JPEG)...');
    final jpegResult = await VipsPipelineCompute.processFile(
      imagePath,
      (p) => p,
      outputFormat: '.jpg',
    );
    _log('JPEG buffer size: ${jpegResult.data.length} bytes');
    result.writeln(
        '✓ Write to JPEG: ${(jpegResult.data.length / 1024).toStringAsFixed(1)} KB');

    // Test write to file
    _log('Testing writeToFile...');
    final tempDir = await getTemporaryDirectory();
    final outputPath = '${tempDir.path}/vips_output.jpg';
    _log('Output path: $outputPath');
    await File(outputPath).writeAsBytes(jpegResult.data);
    final outputFile = File(outputPath);
    if (await outputFile.exists()) {
      final size = await outputFile.length();
      _log('File written: $size bytes');
      result.writeln(
          '✓ Write to file: ${(size / 1024).toStringAsFixed(1)} KB');
    }

    stopwatch.stop();
    _log('All tests completed in ${stopwatch.elapsedMilliseconds}ms');
    result.writeln('\n✓ All tests passed in ${stopwatch.elapsedMilliseconds}ms!');

    return (result.toString(), thumb.data);
  }

  /// Run a single test using VipsPipelineCompute callback
  Future<(String, Uint8List?)> runSingleTestPipeline(
    String imagePath,
    String name,
    PipelineCallbackOperation operation,
  ) async {
    _log('=== Running $name Test (Pipeline) ===');
    _log('Image path: $imagePath');

    final stopwatch = Stopwatch()..start();

    _log('Checking if file exists...');
    final file = File(imagePath);
    final exists = await file.exists();
    _log('File exists: $exists');
    if (exists) {
      final fileSize = await file.length();
      _log('File size: $fileSize bytes');
    }

    // Get input dimensions first
    final inputInfo = await VipsPipelineCompute.processFile(
      imagePath,
      (p) => p,
    );
    _log('Image loaded: ${inputInfo.width}x${inputInfo.height}');

    _log('Executing $name operation...');
    final result = await VipsPipelineCompute.processFile(
      imagePath,
      operation,
    );
    _log('Operation result: ${result.width}x${result.height}');

    stopwatch.stop();
    _log('$name completed in ${stopwatch.elapsedMilliseconds}ms');

    final resultText = '✓ $name completed in ${stopwatch.elapsedMilliseconds}ms\n'
        '  Input: ${inputInfo.width}x${inputInfo.height}\n'
        '  Output: ${result.width}x${result.height}\n'
        '  Size: ${(result.data.length / 1024).toStringAsFixed(1)} KB';

    return (resultText, result.data);
  }

  /// Run a single test using VipsCompute (more efficient, loads from file directly)
  Future<(String, Uint8List?)> runSingleTestCompute(
    String imagePath,
    String name,
    PipelineSpecTestOperation operation,
  ) async {
    _log('=== Running $name Test (Compute) ===');
    _log('Image path: $imagePath');

    final stopwatch = Stopwatch()..start();

    _log('Checking if file exists...');
    final file = File(imagePath);
    final exists = await file.exists();
    _log('File exists: $exists');
    if (exists) {
      final fileSize = await file.length();
      _log('File size: $fileSize bytes');
    }

    _log('Executing $name operation...');
    final imageData = await operation(imagePath);
    _log('Operation result: ${imageData.length} bytes');

    stopwatch.stop();
    _log('$name completed in ${stopwatch.elapsedMilliseconds}ms');

    final resultText = '✓ $name completed in ${stopwatch.elapsedMilliseconds}ms\n'
        '  Size: ${(imageData.length / 1024).toStringAsFixed(1)} KB';

    return (resultText, imageData);
  }

  /// Run a single test (sync version using VipsPipeline)
  Future<(String, Uint8List?)> runSingleTest(
    String imagePath,
    String name,
    VipsPipeline Function(VipsPipeline) operation,
  ) async {
    _log('=== Running $name Test ===');
    _log('Image path: $imagePath');

    final stopwatch = Stopwatch()..start();

    _log('Loading image...');
    _log('Checking if file exists...');
    final file = File(imagePath);
    final exists = await file.exists();
    _log('File exists: $exists');
    if (exists) {
      final fileSize = await file.length();
      _log('File size: $fileSize bytes');
    }
    final pipeline = VipsPipeline.fromFile(imagePath);
    final inputWidth = pipeline.image.width;
    final inputHeight = pipeline.image.height;
    _log('Image loaded: ${inputWidth}x${inputHeight}');

    _log('Executing $name operation...');
    final result = operation(pipeline);
    final outputWidth = result.image.width;
    final outputHeight = result.image.height;
    _log('Operation result: ${outputWidth}x${outputHeight}');

    _log('Writing to PNG buffer...');
    final pngData = result.toBuffer(format: '.png');
    _log('PNG buffer size: ${pngData.length} bytes');

    stopwatch.stop();
    _log('$name completed in ${stopwatch.elapsedMilliseconds}ms');

    final resultText = '✓ $name completed in ${stopwatch.elapsedMilliseconds}ms\n'
        '  Input: ${inputWidth}x${inputHeight}\n'
        '  Output: ${outputWidth}x${outputHeight}\n'
        '  Size: ${(pngData.length / 1024).toStringAsFixed(1)} KB';

    result.dispose();
    _log('Resources disposed');

    return (resultText, pngData);
  }
}

/// Predefined test operations using VipsPipeline
class VipsTestOperations {
  static VipsPipeline resize(VipsPipeline p) => p.resize(0.5);
  static VipsPipeline thumbnail(VipsPipeline p) => p.thumbnail(200);
  static VipsPipeline rotate(VipsPipeline p) => p.rotate(90);
  static VipsPipeline crop(VipsPipeline p) {
    final size = p.image.width < p.image.height ? p.image.width : p.image.height;
    return p.crop(0, 0, size ~/ 2, size ~/ 2);
  }

  static VipsPipeline flipH(VipsPipeline p) => p.flip(VipsDirection.horizontal);
  static VipsPipeline flipV(VipsPipeline p) => p.flip(VipsDirection.vertical);
  static VipsPipeline blur(VipsPipeline p) => p.blur(5.0);
  static VipsPipeline sharpen(VipsPipeline p) => p.sharpen();
  static VipsPipeline invert(VipsPipeline p) => p.invert();
  static VipsPipeline brightness(VipsPipeline p) => p.linear(1.2, 0);
  static VipsPipeline contrast(VipsPipeline p) => p.linear(1.3, 128 * (1 - 1.3));
  static VipsPipeline autoRotate(VipsPipeline p) => p.autoRotate();
  static VipsPipeline smartCrop(VipsPipeline p) {
    final size = p.image.width < p.image.height ? p.image.width ~/ 2 : p.image.height ~/ 2;
    return p.smartCrop(size, size);
  }

  static VipsPipeline grayscale(VipsPipeline p) => p.colourspace(VipsInterpretation.bw);
}

/// Predefined async test operations using PipelineSpec (runs in isolate)
class VipsTestOperationsPipelineSpec {
  static Future<Uint8List> resize(String path) =>
      VipsPipelineCompute.execute(PipelineSpec().input(path).resize(0.5).outputPng());
  static Future<Uint8List> thumbnail(String path) =>
      VipsPipelineCompute.execute(PipelineSpec().input(path).thumbnail(200).outputPng());
  static Future<Uint8List> rotate(String path) =>
      VipsPipelineCompute.execute(PipelineSpec().input(path).rotate(90).outputPng());
  static Future<Uint8List> flipH(String path) =>
      VipsPipelineCompute.execute(PipelineSpec().input(path).flipHorizontal().outputPng());
  static Future<Uint8List> flipV(String path) =>
      VipsPipelineCompute.execute(PipelineSpec().input(path).flipVertical().outputPng());
  static Future<Uint8List> blur(String path) =>
      VipsPipelineCompute.execute(PipelineSpec().input(path).blur(5.0).outputPng());
  static Future<Uint8List> sharpen(String path) =>
      VipsPipelineCompute.execute(PipelineSpec().input(path).sharpen().outputPng());
  static Future<Uint8List> invert(String path) =>
      VipsPipelineCompute.execute(PipelineSpec().input(path).invert().outputPng());
  static Future<Uint8List> brightness(String path) =>
      VipsPipelineCompute.execute(PipelineSpec().input(path).brightness(1.2).outputPng());
  static Future<Uint8List> contrast(String path) =>
      VipsPipelineCompute.execute(PipelineSpec().input(path).contrast(1.3).outputPng());
  static Future<Uint8List> autoRotate(String path) =>
      VipsPipelineCompute.execute(PipelineSpec().input(path).autoRotate().outputPng());
  static Future<Uint8List> grayscale(String path) =>
      VipsPipelineCompute.execute(PipelineSpec().input(path).grayscale().outputPng());
  // Note: crop and smartCrop need image dimensions which PipelineSpec doesn't have access to
  // These will use a fixed size for now
  static Future<Uint8List> crop(String path) =>
      VipsPipelineCompute.execute(PipelineSpec().input(path).crop(0, 0, 200, 200).outputPng());
  static Future<Uint8List> smartCrop(String path) =>
      VipsPipelineCompute.execute(PipelineSpec().input(path).smartCrop(200, 200).outputPng());
}
