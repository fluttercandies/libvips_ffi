import 'dart:developer' as developer;
import 'dart:io';
import 'dart:ui' as ui;

import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libvips_ffi/libvips_ffi.dart';

void _log(String message) {
  debugPrint('[ExamplesPage] $message');
  developer.log(message, name: 'ExamplesPage');
}

/// Examples page showing code samples for each operation.
///
/// 示例页面，展示每个操作的代码示例。
class ExamplesPage extends StatefulWidget {
  const ExamplesPage({super.key});

  @override
  State<ExamplesPage> createState() => _ExamplesPageState();
}

class _ExamplesPageState extends State<ExamplesPage> {
  String? _selectedImagePath;
  Uint8List? _processedImageData;
  bool _isProcessing = false;
  int _selectedExampleIndex = 0;
  
  // Metadata and timing
  Duration? _processingTime;
  int? _originalWidth;
  int? _originalHeight;
  int? _originalFileSize;
  int? _processedWidth;
  int? _processedHeight;
  int? _processedFileSize;

  final ImagePicker _picker = ImagePicker();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Example definitions
  static final List<ExampleItem> _examples = [
    ExampleItem(
      title: 'Resize / 调整大小',
      description: 'Scale image by a factor (0.5 = half size)',
      code: '''
final pipeline = VipsPipeline.fromFile('input.jpg');
pipeline.resize(0.5);  // 50% size
pipeline.toFile('output.jpg');
pipeline.dispose();''',
      asyncCode: '''
// Using VipsCompute (recommended for Flutter)
final result = await VipsCompute.resizeFile(
  'input.jpg',
  0.5,  // scale factor
);
// result.data contains the processed image bytes''',
      operation: (p) => p.resize(0.5),
      specBuilder: (path) => PipelineSpec().input(path).resize(0.5).outputPng(),
    ),
    ExampleItem(
      title: 'Thumbnail / 缩略图',
      description: 'Create thumbnail with target width (maintains aspect ratio)',
      code: '''
final pipeline = VipsPipeline.fromFile('input.jpg');
pipeline.thumbnail(200);  // 200px width
pipeline.toFile('thumb.jpg');
pipeline.dispose();''',
      asyncCode: '''
// Direct thumbnail from file (most efficient)
final result = await VipsCompute.thumbnailFile(
  'input.jpg',
  200,  // target width
);''',
      operation: (p) => p.thumbnail(200),
      specBuilder: (path) => PipelineSpec().input(path).thumbnail(200).outputPng(),
    ),
    ExampleItem(
      title: 'Rotate / 旋转',
      description: 'Rotate image by angle in degrees',
      code: '''
final pipeline = VipsPipeline.fromFile('input.jpg');
pipeline.rotate(90);  // 90 degrees
pipeline.toFile('rotated.jpg');
pipeline.dispose();''',
      asyncCode: '''
final result = await VipsCompute.rotateFile(
  'input.jpg',
  90,  // degrees
);''',
      operation: (p) => p.rotate(90),
      specBuilder: (path) => PipelineSpec().input(path).rotate(90).outputPng(),
    ),
    ExampleItem(
      title: 'Crop / 裁剪',
      description: 'Extract a rectangular region from image',
      code: '''
final pipeline = VipsPipeline.fromFile('input.jpg');
pipeline.crop(
  100,  // left
  100,  // top
  200,  // width
  200,  // height
);
pipeline.toFile('cropped.jpg');
pipeline.dispose();''',
      asyncCode: '''
final result = await VipsCompute.cropFile(
  'input.jpg',
  100, 100,  // left, top
  200, 200,  // width, height
);''',
      operation: (p) {
        final size = p.image.width < p.image.height ? p.image.width : p.image.height;
        return p.crop(0, 0, size ~/ 2, size ~/ 2);
      },
      specBuilder: (path) => PipelineSpec().input(path).crop(0, 0, 200, 200).outputPng(),
    ),
    ExampleItem(
      title: 'Flip / 翻转',
      description: 'Flip image horizontally or vertically',
      code: '''
final pipeline = VipsPipeline.fromFile('input.jpg');

// Horizontal flip (mirror)
pipeline.flip(VipsDirection.horizontal);
pipeline.toFile('flipped.jpg');
pipeline.dispose();''',
      asyncCode: '''
// Horizontal flip
final result = await VipsCompute.flipFile(
  'input.jpg',
  VipsDirection.horizontal,
);''',
      operation: (p) => p.flip(VipsDirection.horizontal),
      specBuilder: (path) => PipelineSpec().input(path).flipHorizontal().outputPng(),
    ),
    ExampleItem(
      title: 'Blur / 模糊',
      description: 'Apply Gaussian blur with sigma value',
      code: '''
final pipeline = VipsPipeline.fromFile('input.jpg');
pipeline.blur(5.0);  // sigma = 5
pipeline.toFile('blurred.jpg');
pipeline.dispose();''',
      asyncCode: '''
final result = await VipsCompute.blurFile(
  'input.jpg',
  5.0,  // sigma (blur amount)
);''',
      operation: (p) => p.blur(5.0),
      specBuilder: (path) => PipelineSpec().input(path).blur(5.0).outputPng(),
    ),
    ExampleItem(
      title: 'Sharpen / 锐化',
      description: 'Sharpen image using unsharp masking',
      code: '''
final pipeline = VipsPipeline.fromFile('input.jpg');
pipeline.sharpen();
pipeline.toFile('sharpened.jpg');
pipeline.dispose();''',
      asyncCode: '''
final result = await VipsCompute.sharpenFile('input.jpg');''',
      operation: (p) => p.sharpen(),
      specBuilder: (path) => PipelineSpec().input(path).sharpen().outputPng(),
    ),
    ExampleItem(
      title: 'Invert / 反色',
      description: 'Invert image colors (negative effect)',
      code: '''
final pipeline = VipsPipeline.fromFile('input.jpg');
pipeline.invert();
pipeline.toFile('inverted.jpg');
pipeline.dispose();''',
      asyncCode: '''
final result = await VipsCompute.invertFile('input.jpg');''',
      operation: (p) => p.invert(),
      specBuilder: (path) => PipelineSpec().input(path).invert().outputPng(),
    ),
    ExampleItem(
      title: 'Brightness / 亮度',
      description: 'Adjust image brightness (1.0 = no change)',
      code: '''
final pipeline = VipsPipeline.fromFile('input.jpg');
pipeline.linear(1.3, 0);  // +30% brightness
pipeline.toFile('brighter.jpg');
pipeline.dispose();''',
      asyncCode: '''
final result = await VipsCompute.brightnessFile(
  'input.jpg',
  1.3,  // factor (1.3 = 30% brighter)
);''',
      operation: (p) => p.linear(1.3, 0),
      specBuilder: (path) => PipelineSpec().input(path).brightness(1.3).outputPng(),
    ),
    ExampleItem(
      title: 'Contrast / 对比度',
      description: 'Adjust image contrast (1.0 = no change)',
      code: '''
final pipeline = VipsPipeline.fromFile('input.jpg');
pipeline.linear(1.5, 128 * (1 - 1.5));  // +50% contrast
pipeline.toFile('contrast.jpg');
pipeline.dispose();''',
      asyncCode: '''
final result = await VipsCompute.contrastFile(
  'input.jpg',
  1.5,  // factor (1.5 = 50% more contrast)
);''',
      operation: (p) => p.linear(1.5, 128 * (1 - 1.5)),
      specBuilder: (path) => PipelineSpec().input(path).contrast(1.5).outputPng(),
    ),
    ExampleItem(
      title: 'Grayscale / 灰度',
      description: 'Convert image to grayscale',
      code: '''
final pipeline = VipsPipeline.fromFile('input.jpg');
pipeline.colourspace(VipsInterpretation.bw);
pipeline.toFile('grayscale.jpg');
pipeline.dispose();''',
      asyncCode: '''
final result = await VipsCompute.processFile(
  'input.jpg',
  (img) => img.colourspace(VipsInterpretation.bw),
);''',
      operation: (p) => p.colourspace(VipsInterpretation.bw),
      specBuilder: (path) => PipelineSpec().input(path).grayscale().outputPng(),
    ),
    ExampleItem(
      title: 'Smart Crop / 智能裁剪',
      description: 'Crop to focus on the most interesting part',
      code: '''
final pipeline = VipsPipeline.fromFile('input.jpg');
pipeline.smartCrop(300, 300);  // 300x300
pipeline.toFile('smart_cropped.jpg');
pipeline.dispose();''',
      asyncCode: '''
final result = await VipsCompute.processFile(
  'input.jpg',
  (img) => img.smartCrop(300, 300),
);''',
      operation: (p) {
        final size = p.image.width < p.image.height ? p.image.width ~/ 2 : p.image.height ~/ 2;
        return p.smartCrop(size, size);
      },
      specBuilder: (path) => PipelineSpec().input(path).smartCrop(300, 300).outputPng(),
    ),
    ExampleItem(
      title: 'Auto Rotate / 自动旋转',
      description: 'Rotate based on EXIF orientation tag',
      code: '''
final pipeline = VipsPipeline.fromFile('input.jpg');
pipeline.autoRotate();
pipeline.toFile('auto_rotated.jpg');
pipeline.dispose();''',
      asyncCode: '''
final result = await VipsCompute.autoRotateFile('input.jpg');''',
      operation: (p) => p.autoRotate(),
      specBuilder: (path) => PipelineSpec().input(path).autoRotate().outputPng(),
    ),
    ExampleItem(
      title: 'Chain Operations / 链式操作',
      description: 'Combine multiple operations',
      code: '''
final pipeline = VipsPipeline.fromFile('input.jpg');

// Chain operations (fluent API - no intermediate cleanup needed!)
pipeline
  .resize(0.5)
  .blur(2.0)
  .sharpen();

pipeline.toFile('output.jpg');
pipeline.dispose();''',
      asyncCode: '''
// Using processFile for custom chains
final result = await VipsCompute.processFile(
  'input.jpg',
  (img) {
    final resized = img.resize(0.5);
    final blurred = resized.gaussianBlur(2.0);
    resized.dispose();  // Clean up intermediate
    return blurred;
  },
);''',
      operation: (p) => p.resize(0.5).blur(2.0).sharpen(),
      specBuilder: (path) => PipelineSpec()
          .input(path)
          .resize(0.5)
          .blur(2.0)
          .sharpen()
          .outputPng(),
    ),
  ];

  Future<void> _pickImage() async {
    String? imagePath;
    
    // ignore: avoid_print
    print('[ExamplesPage] _pickImage called');
    // ignore: avoid_print
    print('[ExamplesPage] Platform: macOS=${Platform.isMacOS}, Windows=${Platform.isWindows}, Linux=${Platform.isLinux}');
    
    try {
      // Use file_selector for desktop platforms (macOS, Windows, Linux)
      if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
        // ignore: avoid_print
        print('[ExamplesPage] Using file_selector');
        const typeGroup = XTypeGroup(
          label: 'images',
          extensions: ['jpg', 'jpeg', 'png', 'gif', 'webp', 'tiff', 'bmp'],
        );
        final file = await openFile(acceptedTypeGroups: [typeGroup]);
        // ignore: avoid_print
        print('[ExamplesPage] file_selector result: ${file?.path}');
        imagePath = file?.path;
      } else {
        // Use image_picker for mobile platforms
        // ignore: avoid_print
        print('[ExamplesPage] Using image_picker');
        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        imagePath = image?.path;
      }
    } catch (e, stack) {
      // ignore: avoid_print
      print('[ExamplesPage] Error picking image: $e');
      // ignore: avoid_print
      print('[ExamplesPage] Stack: $stack');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
      return;
    }
    
    if (imagePath != null) {
      // Get original file info
      final file = File(imagePath);
      final fileSize = await file.length();
      
      // Decode image to get dimensions
      final bytes = await file.readAsBytes();
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final decoded = frame.image;
      
      setState(() {
        _selectedImagePath = imagePath;
        _processedImageData = null;
        _processingTime = null;
        _originalWidth = decoded.width;
        _originalHeight = decoded.height;
        _originalFileSize = fileSize;
        _processedWidth = null;
        _processedHeight = null;
        _processedFileSize = null;
      });
    }
  }

  Future<void> _runExample() async {
    if (_selectedImagePath == null || _isProcessing) return;

    setState(() {
      _isProcessing = true;
      _processedImageData = null;
      _processingTime = null;
    });

    try {
      final example = _examples[_selectedExampleIndex];
      _log('Processing: ${example.title}');
      _log('Input path: $_selectedImagePath');
      
      final stopwatch = Stopwatch()..start();
      
      Uint8List data;
      
      if (example.specBuilder != null) {
        // Use async PipelineSpec (runs in isolate)
        _log('Using async PipelineSpec...');
        final spec = example.specBuilder!(_selectedImagePath!);
        _log('Executing in isolate...');
        data = await VipsPipelineCompute.execute(spec);
        _log('Isolate execution complete, ${data.length} bytes');
      } else {
        // Fallback to sync API for operations not in PipelineSpec
        _log('Using sync API (no specBuilder)...');
        final pipeline = VipsPipeline.fromFile(_selectedImagePath!);
        _log('Image loaded: ${pipeline.image.width}x${pipeline.image.height}');
        
        example.operation(pipeline);
        _log('Operation complete: ${pipeline.image.width}x${pipeline.image.height}');
        
        data = pipeline.toBuffer(format: '.png');
        _log('Buffer size: ${data.length} bytes');
        
        pipeline.dispose();
        _log('Resources disposed');
      }
      
      stopwatch.stop();
      _log('Total processing time: ${stopwatch.elapsedMilliseconds}ms');
      
      setState(() {
        _processedImageData = data;
        _processingTime = stopwatch.elapsed;
        _processedFileSize = data.length;
      });
    } catch (e, stack) {
      _log('Error: $e');
      _log('Stack: $stack');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void _copyCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Code copied / 代码已复制')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final example = _examples[_selectedExampleIndex];
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Examples / 示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // Use endDrawer (right side) for mobile, sidebar for tablet/desktop
      endDrawer: isWideScreen ? null : _buildExampleDrawer(),
      body: isWideScreen
          ? Row(
              children: [
                // Left sidebar - Example list (tablet/desktop)
                SizedBox(
                  width: 200,
                  child: _buildExampleList(),
                ),
                // Right content area
                Expanded(child: _buildExampleContent(example)),
              ],
            )
          : _buildExampleContent(example),
    );
  }

  Widget _buildExampleDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Select Example',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Divider(height: 1),
            Expanded(child: _buildExampleList()),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleList() {
    return Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: ListView.builder(
        itemCount: _examples.length,
        itemBuilder: (context, index) {
          final item = _examples[index];
          final isSelected = index == _selectedExampleIndex;
          return ListTile(
            dense: true,
            selected: isSelected,
            selectedTileColor: Colors.blue.shade50,
            title: Text(
              item.title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            onTap: () {
              setState(() {
                _selectedExampleIndex = index;
                _processedImageData = null;
              });
              // Close endDrawer on mobile
              if (MediaQuery.of(context).size.width <= 600) {
                Navigator.of(context).pop();
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildExampleContent(ExampleItem example) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mobile: Show current example selector
          if (MediaQuery.of(context).size.width <= 600)
            Card(
              child: ListTile(
                leading: const Icon(Icons.list),
                title: Text(example.title),
                subtitle: const Text('Tap to select example / 点击选择示例'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
              ),
            ),
          if (MediaQuery.of(context).size.width <= 600)
            const SizedBox(height: 16),

          // Title and description
          Text(
            example.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            example.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          const SizedBox(height: 24),

          // Sync code
          _buildCodeSection(
            context,
            'Sync API / 同步 API',
            example.code,
            Colors.blue,
          ),
          const SizedBox(height: 16),

          // Async code
          _buildCodeSection(
            context,
            'Async API / 异步 API (Flutter)',
            example.asyncCode,
            Colors.green,
          ),
          const SizedBox(height: 24),

          // Try it section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Try It / 试一试',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.photo_library),
                        label: const Text('Pick'),
                      ),
                      ElevatedButton.icon(
                        onPressed:
                            _selectedImagePath != null && !_isProcessing
                                ? _runExample
                                : null,
                        icon: _isProcessing
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.play_arrow),
                        label: const Text('Run'),
                      ),
                    ],
                  ),
                  if (_selectedImagePath != null ||
                      _processedImageData != null) ...[
                    const SizedBox(height: 16),
                    // Comparison view - responsive
                    _buildComparisonView(),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonView() {
    final isNarrow = MediaQuery.of(context).size.width <= 400;

    final originalWidget = _selectedImagePath != null
        ? _buildImageCard(
            'Original',
            Colors.blue,
            Image.file(
              File(_selectedImagePath!),
              height: isNarrow ? 150 : 200,
              fit: BoxFit.contain,
            ),
            width: _originalWidth,
            height_: _originalHeight,
            fileSize: _originalFileSize,
          )
        : null;

    final processedWidget = _processedImageData != null
        ? _buildImageCard(
            'Processed',
            Colors.green,
            Image.memory(
              _processedImageData!,
              height: isNarrow ? 150 : 200,
              fit: BoxFit.contain,
            ),
            width: _processedWidth,
            height_: _processedHeight,
            fileSize: _processedFileSize,
            processingTime: _processingTime,
          )
        : null;

    // Stack vertically on very narrow screens
    if (isNarrow) {
      return Column(
        children: [
          if (originalWidget != null) originalWidget,
          if (originalWidget != null && processedWidget != null)
            const SizedBox(height: 12),
          if (processedWidget != null) processedWidget,
        ],
      );
    }

    // Side by side on wider screens
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (originalWidget != null) Expanded(child: originalWidget),
          if (originalWidget != null && processedWidget != null)
            const SizedBox(width: 12),
          if (processedWidget != null) Expanded(child: processedWidget),
        ],
      ),
    );
  }

  Widget _buildImageCard(
    String label,
    Color color,
    Widget image, {
    int? width,
    int? height_,
    int? fileSize,
    Duration? processingTime,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: image,
        ),
        const SizedBox(height: 8),
        // Metadata display
        if (width != null || height_ != null || fileSize != null || processingTime != null)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (width != null && height_ != null)
                  _buildMetadataRow('Size', '${width}x$height_ px'),
                if (fileSize != null)
                  _buildMetadataRow('File', _formatFileSize(fileSize)),
                if (processingTime != null)
                  _buildMetadataRow('Time', _formatDuration(processingTime)),
              ],
            ),
          ),
      ],
    );
  }
  
  Widget _buildMetadataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }
  
  String _formatDuration(Duration duration) {
    if (duration.inMilliseconds < 1000) {
      return '${duration.inMilliseconds} ms';
    }
    return '${(duration.inMilliseconds / 1000).toStringAsFixed(2)} s';
  }

  Widget _buildCodeSection(
    BuildContext context,
    String title,
    String code,
    Color accentColor,
  ) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: accentColor.shade700,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.copy, size: 18, color: accentColor.shade700),
                  onPressed: () => _copyCode(code),
                  tooltip: 'Copy code',
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: SelectableText.rich(
              _buildHighlightedCode(code.trim()),
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Example item definition
class ExampleItem {
  final String title;
  final String description;
  final String code;
  final String asyncCode;
  final VipsPipeline Function(VipsPipeline) operation;
  final PipelineSpec Function(String path)? specBuilder;

  const ExampleItem({
    required this.title,
    required this.description,
    required this.code,
    required this.asyncCode,
    required this.operation,
    this.specBuilder,
  });
}

extension on Color {
  Color get shade700 {
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness((hsl.lightness - 0.2).clamp(0.0, 1.0)).toColor();
  }
}

/// Simple Dart syntax highlighter
TextSpan _buildHighlightedCode(String code) {
  final spans = <TextSpan>[];
  
  // Define colors for different token types
  const keywordColor = Color(0xFF569CD6);      // Blue - keywords
  const stringColor = Color(0xFFCE9178);       // Orange - strings
  const commentColor = Color(0xFF6A9955);      // Green - comments
  const numberColor = Color(0xFFB5CEA8);       // Light green - numbers
  const typeColor = Color(0xFF4EC9B0);         // Cyan - types
  const functionColor = Color(0xFFDCDCAA);     // Yellow - functions
  const defaultColor = Colors.white;
  
  // Keywords
  final keywords = {
    'final', 'var', 'const', 'void', 'async', 'await', 'return', 'try',
    'catch', 'finally', 'if', 'else', 'for', 'while', 'import', 'class',
    'extends', 'with', 'mixin', 'static', 'new', 'this', 'super', 'true',
    'false', 'null', 'Future', 'int', 'double', 'String', 'bool', 'dynamic',
  };
  
  // Types (capitalized words that are likely types)
  final types = {
    'VipsPipeline', 'VipsCompute', 'VipsDirection', 'VipsInterpretation',
    'VipsPointerManager', 'VipsPipelineCompute', 'PipelineSpec', 'Image', 'Uint8List', 'File',
  };
  
  // Simple tokenizer
  final buffer = StringBuffer();
  var i = 0;
  
  void flushBuffer(Color color) {
    if (buffer.isNotEmpty) {
      spans.add(TextSpan(
        text: buffer.toString(),
        style: TextStyle(color: color),
      ));
      buffer.clear();
    }
  }
  
  while (i < code.length) {
    final char = code[i];
    
    // Check for comments
    if (i < code.length - 1 && code[i] == '/' && code[i + 1] == '/') {
      flushBuffer(defaultColor);
      final commentEnd = code.indexOf('\n', i);
      final end = commentEnd == -1 ? code.length : commentEnd;
      spans.add(TextSpan(
        text: code.substring(i, end),
        style: const TextStyle(color: commentColor),
      ));
      i = end;
      continue;
    }
    
    // Check for strings
    if (char == "'" || char == '"') {
      flushBuffer(defaultColor);
      final quote = char;
      final start = i;
      i++;
      while (i < code.length && code[i] != quote) {
        if (code[i] == '\\' && i + 1 < code.length) i++;
        i++;
      }
      if (i < code.length) i++;
      spans.add(TextSpan(
        text: code.substring(start, i),
        style: const TextStyle(color: stringColor),
      ));
      continue;
    }
    
    // Check for numbers
    if (RegExp(r'[0-9]').hasMatch(char)) {
      flushBuffer(defaultColor);
      final start = i;
      while (i < code.length && RegExp(r'[0-9.]').hasMatch(code[i])) {
        i++;
      }
      spans.add(TextSpan(
        text: code.substring(start, i),
        style: const TextStyle(color: numberColor),
      ));
      continue;
    }
    
    // Check for identifiers (words)
    if (RegExp(r'[a-zA-Z_]').hasMatch(char)) {
      flushBuffer(defaultColor);
      final start = i;
      while (i < code.length && RegExp(r'[a-zA-Z0-9_]').hasMatch(code[i])) {
        i++;
      }
      final word = code.substring(start, i);
      
      Color wordColor;
      if (keywords.contains(word)) {
        wordColor = keywordColor;
      } else if (types.contains(word)) {
        wordColor = typeColor;
      } else if (i < code.length && code[i] == '(') {
        wordColor = functionColor;
      } else {
        wordColor = defaultColor;
      }
      
      spans.add(TextSpan(
        text: word,
        style: TextStyle(color: wordColor),
      ));
      continue;
    }
    
    // Default: add to buffer
    buffer.write(char);
    i++;
  }
  
  flushBuffer(defaultColor);
  
  return TextSpan(children: spans);
}
