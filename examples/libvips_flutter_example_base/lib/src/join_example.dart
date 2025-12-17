import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:libvips_ffi/libvips_ffi.dart';
import 'package:libvips_ffi_api/libvips_ffi_api.dart' hide vipsVersion;
import 'package:path_provider/path_provider.dart' as pp;
import 'dart:ui' as ui;

String? _logFilePath;

Future<String> getTemporaryDirectory() async {
  if (Platform.isAndroid) {
    return (await pp.getApplicationCacheDirectory()).absolute.path;
  } else if (Platform.isIOS) {
    return (await pp.getApplicationDocumentsDirectory()).absolute.path;
  } else {
    return (await pp.getTemporaryDirectory()).absolute.path;
  }
}

Future<String> _getLogFilePath() async {
  if (_logFilePath != null) return _logFilePath!;
  final dir = await pp.getApplicationDocumentsDirectory();
  _logFilePath = '${dir.path}/logs/macos_example.log';
  debugPrint('[MacosExample] Log file path: $_logFilePath');
  return _logFilePath!;
}

Future<void> _log(String message) async {
  final timestamp = DateTime.now().toIso8601String();
  final logMessage = '[$timestamp] $message';
  debugPrint('[MacosExample] $message');
  try {
    final logPath = await _getLogFilePath();
    final file = File(logPath);
    await file.parent.create(recursive: true);
    await file.writeAsString('$logMessage\n', mode: FileMode.append);
  } catch (_) {}
}

class JoinExamplePage extends StatefulWidget {
  const JoinExamplePage({super.key});

  @override
  State<JoinExamplePage> createState() => _JoinExamplePageState();
}

class _JoinExamplePageState extends State<JoinExamplePage> {
  GlobalKey repaintKey = GlobalKey();
  String _vipsVersion = 'Loading...';
  String _status = 'Initializing...';

  @override
  void initState() {
    super.initState();
    _initVips();
  }

  Future<void> _initVips() async {
    try {
      initVips();
      initVipsApi(vipsLibrary);
      vipsBindings.vips_concurrency_set(1);
      // initVipsMacos();
      final major = vipsVersion(0);
      final minor = vipsVersion(1);
      final micro = vipsVersion(2);
      setState(() {
        _vipsVersion = '$major.$minor.$micro';
        _status = 'libvips initialized successfully ✓';
      });
    } catch (e) {
      setState(() {
        _vipsVersion = 'Error';
        _status = 'Failed to initialize: $e';
      });
    }
    _log('_vipsVersion: $_vipsVersion');
    _log('_status: $_status');
  }

  @override
  void dispose() {
    super.dispose();
    shutdownVips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget to Image example'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: RepaintBoundary(
            key: repaintKey,
            child: Image.asset(
              'assets/test_img.jpg',
              width: 10000,
              package: 'libvips_flutter_example_base',
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (frame == null) {
                  return const SizedBox(
                    width: 10000,
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return child;
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          BuildContext? buildContext = repaintKey.currentContext;
          if (buildContext != null) {
            final renderObject = buildContext.findRenderObject();
            if (renderObject is RenderRepaintBoundary) {
              ImageFormat imageFormat = ImageFormat.jpeg;
              final fileName = '${DateTime.now().millisecondsSinceEpoch}.${imageFormat.name == 'jpeg' ? 'jpg' : imageFormat.name}';
              
              // Get output path based on platform
              String path;
              if (Platform.isAndroid) {
                final extDir = await pp.getExternalStorageDirectory();
                path = '${extDir!.path}/$fileName';
              } else {
                final tempDir = await getTemporaryDirectory();
                path = '$tempDir/$fileName';
              }
              _log('输出路径：$path');
              if (Platform.isAndroid) {
                _log('adb pull 命令: adb pull $path .');
              }
              try {
                bool result = await renderObject.toImageByChunks(
                  outPath: path,
                  chunkHeight: 1024,
                  pixelRatio: 1,
                  imageFormat: imageFormat,
                );
                if (result) {
                  _log('图片保存成功');
                }
              } catch (e, stack) {
                _log('图片保存失败：$e\n$stack');
              }
            }
          }
        },
        child: const Icon(Icons.camera),
      ),
    );
  }
}

enum ImageFormat {
  png,
  jpeg,
}

extension RenderRepaintBoundaryExt on RenderRepaintBoundary {
  /// 将widget保存为图片
  ///
  /// [outPath] 图像保存的路径
  /// [chunkHeight] 分块大小
  /// [pixelRatio] 缩放比例
  /// [imageFormat] 图像格式
  Future<bool> toImageByChunks({
    required String outPath,
    double? chunkHeight,
    double pixelRatio = 1.0,
    ImageFormat imageFormat = ImageFormat.png,
  }) async {
    chunkHeight ??= 512;
    if (chunkHeight <= 0) {
      throw ArgumentError('chunkHeight 必须大于 0');
    }
    final List<Rect> chunksRect = [];
    final double totalHeight = size.height;
    double dy = 0;
    while (dy < totalHeight) {
      final double currentChunkHeight =
          (dy + chunkHeight <= totalHeight) ? chunkHeight : totalHeight - dy;
      chunksRect.add(Rect.fromLTWH(0, dy, size.width, currentChunkHeight));
      dy += chunkHeight;
    }
    if (chunksRect.isEmpty) {
      return false;
    }
    int timeTotal = DateTime.now().millisecondsSinceEpoch;
    int chunkIndex = 0;
    final tempFiles = <File>[];
    final tempDir = await getTemporaryDirectory();
    
    // Step 1: Capture all chunks and save to temp files (must be on main thread for UI access)
    for (final chunkRect in chunksRect) {
      _log('Processing chunk $chunkIndex: $chunkRect');
      final ui.Image chunkImage =
          await toImageChunks(chunkRect: chunkRect, pixelRatio: pixelRatio);
      _log('Chunk $chunkIndex image size: ${chunkImage.width}x${chunkImage.height}');
      ByteData? byteData =
          await chunkImage.toByteData(format: ui.ImageByteFormat.png);
      Uint8List imageBytes = byteData!.buffer.asUint8List();
      
      final tempFile = File('$tempDir/chunk_$chunkIndex.png');
      await tempFile.writeAsBytes(imageBytes);
      tempFiles.add(tempFile);
      _log('Chunk $chunkIndex saved to ${tempFile.path}');
      chunkIndex++;
    }
    
    if (tempFiles.isEmpty) {
      return false;
    }
    _log('Saved ${tempFiles.length} chunk files');
    
    try {
      if (tempFiles.length == 1) {
        // Single chunk - just copy the file
        await tempFiles.first.copy(outPath);
        _log('Single chunk copied to output');
      } else {
        // Multiple chunks - use JoinPipelineSpec
        _log('Running JoinPipelineSpec...');
        final spec = JoinPipelineSpec()
          .addInputPaths(tempFiles.map((f) => f.path).toList())
          .vertical()
          .outputAs(OutputSpec(imageFormat == ImageFormat.png ? '.png' : '.jpg'));
        
        await VipsPipelineCompute.executeJoinToFile(spec, outPath);
        _log('JoinPipelineSpec completed successfully');
      }
    } catch (e, stack) {
      _log('Error: $e\n$stack');
      rethrow;
    } finally {
      // Clean up temp files
      for (final f in tempFiles) {
        try { await f.delete(); } catch (_) {}
      }
    }
    _log('totalTime:${DateTime.now().millisecondsSinceEpoch - timeTotal}');
    return true;
  }

  Future<ui.Image> toImageChunks(
      {required Rect chunkRect, double pixelRatio = 1.0}) {
    if (chunkRect.left < 0 || chunkRect.top < 0) {
      throw ArgumentError.value(
          chunkRect.topLeft, 'chunkOffset', '不能小于Offset.zero');
    }

    if (chunkRect.left >= size.width || chunkRect.top >= size.height) {
      throw ArgumentError.value(chunkRect.topLeft, 'chunkOffset', '不能大于等于size');
    }

    if (chunkRect.width <= 0 || chunkRect.height <= 0) {
      throw ArgumentError.value(chunkRect, 'chunkSize', '宽度和高度必须大于0');
    }

    if (chunkRect.width > size.width || chunkRect.height > size.height) {
      throw ArgumentError.value(chunkRect, 'chunkSize', '宽度和高度必须小于等于size');
    }

    final OffsetLayer offsetLayer = layer! as OffsetLayer;
    return offsetLayer.toImage(chunkRect, pixelRatio: pixelRatio);
  }
}
