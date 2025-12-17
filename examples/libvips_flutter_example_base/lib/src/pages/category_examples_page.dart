import 'dart:developer' as developer;
import 'dart:io';
import 'dart:ui' as ui;

import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libvips_ffi/libvips_ffi.dart';

import '../data/example_data.dart';

void _log(String message) {
  debugPrint('[CategoryExamplesPage] $message');
  developer.log(message, name: 'CategoryExamplesPage');
}

/// Category-based examples page showing code samples organized by API type.
class CategoryExamplesPage extends StatefulWidget {
  const CategoryExamplesPage({super.key});

  @override
  State<CategoryExamplesPage> createState() => _CategoryExamplesPageState();
}

class _CategoryExamplesPageState extends State<CategoryExamplesPage> {
  String? _selectedImagePath;
  Uint8List? _processedImageData;
  bool _isProcessing = false;
  int _selectedCategoryIndex = 0;
  int _selectedExampleIndex = 0;

  Duration? _processingTime;
  int? _originalWidth;
  int? _originalHeight;
  int? _processedWidth;
  int? _processedHeight;

  final ImagePicker _picker = ImagePicker();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ExampleCategory get _currentCategory => exampleCategories[_selectedCategoryIndex];
  CategoryExample get _currentExample => _currentCategory.examples[_selectedExampleIndex];

  Future<void> _pickImage() async {
    String? imagePath;
    try {
      if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
        const typeGroup = XTypeGroup(
          label: 'images',
          extensions: ['jpg', 'jpeg', 'png', 'gif', 'webp', 'tiff', 'bmp'],
        );
        final file = await openFile(acceptedTypeGroups: [typeGroup]);
        imagePath = file?.path;
      } else {
        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        imagePath = image?.path;
      }
    } catch (e, stack) {
      _log('Error picking image: $e\n$stack');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
      return;
    }

    if (imagePath != null) {
      final bytes = await File(imagePath).readAsBytes();
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final decoded = frame.image;

      setState(() {
        _selectedImagePath = imagePath;
        _processedImageData = null;
        _processingTime = null;
        _originalWidth = decoded.width;
        _originalHeight = decoded.height;
        _processedWidth = null;
        _processedHeight = null;
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
      final example = _currentExample;
      _log('Processing: ${example.title}');

      final stopwatch = Stopwatch()..start();
      Uint8List data;

      if (example.specBuilder != null) {
        _log('Using async PipelineSpec...');
        final spec = example.specBuilder!(_selectedImagePath!);
        data = await VipsPipelineCompute.execute(spec);
      } else {
        _log('Using sync API (no specBuilder)...');
        if (!isVipsApiInitialized) {
          throw StateError('This example requires sync API but libvips is not initialized. '
              'Please ensure you navigated from HomePage.');
        }
        final pipeline = VipsPipeline.fromFile(_selectedImagePath!);
        example.operation(pipeline);
        data = pipeline.toBuffer(format: '.png');
        pipeline.dispose();
      }

      stopwatch.stop();

      final codec = await ui.instantiateImageCodec(data);
      final frame = await codec.getNextFrame();

      if (mounted) {
        setState(() {
          _processedImageData = data;
          _processingTime = stopwatch.elapsed;
          _processedWidth = frame.image.width;
          _processedHeight = frame.image.height;
        });
      }
    } catch (e, stack) {
      _log('Error: $e\n$stack');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
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
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('API Examples / API 示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      endDrawer: isWideScreen ? null : _buildDrawer(),
      body: isWideScreen
          ? Row(
              children: [
                SizedBox(width: 220, child: _buildCategoryList()),
                Expanded(child: _buildExampleContent()),
              ],
            )
          : _buildExampleContent(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Select Category', style: Theme.of(context).textTheme.titleMedium),
            ),
            const Divider(height: 1),
            Expanded(child: _buildCategoryList()),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: ListView.builder(
        itemCount: exampleCategories.length,
        itemBuilder: (context, categoryIndex) {
          final category = exampleCategories[categoryIndex];
          final isSelected = categoryIndex == _selectedCategoryIndex;

          return ExpansionTile(
            initiallyExpanded: isSelected,
            leading: Icon(_getCategoryIcon(category.id), size: 20),
            title: Text(
              '${category.title} / ${category.titleZh}',
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            children: category.examples.asMap().entries.map((entry) {
              final exampleIndex = entry.key;
              final example = entry.value;
              final isExampleSelected =
                  isSelected && exampleIndex == _selectedExampleIndex;

              return ListTile(
                dense: true,
                selected: isExampleSelected,
                selectedTileColor: Colors.blue.shade50,
                contentPadding: const EdgeInsets.only(left: 48, right: 16),
                title: Text(
                  example.title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isExampleSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedCategoryIndex = categoryIndex;
                    _selectedExampleIndex = exampleIndex;
                    _processedImageData = null;
                  });
                  if (MediaQuery.of(context).size.width <= 600) {
                    Navigator.of(context).pop();
                  }
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }

  IconData _getCategoryIcon(String id) {
    switch (id) {
      case 'common':
        return Icons.star;
      case 'resample':
        return Icons.photo_size_select_large;
      case 'conversion':
        return Icons.transform;
      case 'convolution':
        return Icons.blur_on;
      case 'colour':
        return Icons.palette;
      case 'morphology':
        return Icons.grain;
      case 'histogram':
        return Icons.bar_chart;
      default:
        return Icons.code;
    }
  }

  Widget _buildExampleContent() {
    final example = _currentExample;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (MediaQuery.of(context).size.width <= 600)
            Card(
              child: ListTile(
                leading: Icon(_getCategoryIcon(_currentCategory.id)),
                title: Text(example.title),
                subtitle: Text('${_currentCategory.title} / ${_currentCategory.titleZh}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
              ),
            ),
          if (MediaQuery.of(context).size.width <= 600) const SizedBox(height: 16),

          Text(example.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            example.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          const SizedBox(height: 24),

          _buildCodeSection('Sync API / 同步 API', example.code, Colors.blue),
          const SizedBox(height: 16),
          _buildCodeSection('Async API / 异步 API', example.asyncCode, Colors.green),
          const SizedBox(height: 24),

          _buildTryItSection(),
        ],
      ),
    );
  }

  Widget _buildCodeSection(String title, String code, Color color) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Icon(Icons.code, size: 16, color: color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
                ),
                IconButton(
                  icon: const Icon(Icons.copy, size: 16),
                  onPressed: () => _copyCode(code),
                  tooltip: 'Copy',
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E1E),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: SelectableText(
              code.trim(),
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTryItSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Try It / 试一试', style: Theme.of(context).textTheme.titleMedium),
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
                  onPressed: _selectedImagePath != null && !_isProcessing ? _runExample : null,
                  icon: _isProcessing
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.play_arrow),
                  label: const Text('Run'),
                ),
              ],
            ),
            if (_selectedImagePath != null || _processedImageData != null) ...[
              const SizedBox(height: 16),
              _buildComparisonView(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 400;

        if (isNarrow) {
          return Column(
            children: [
              if (_selectedImagePath != null) _buildImageCard('Original', _selectedImagePath!, null, _originalWidth, _originalHeight),
              if (_processedImageData != null) ...[
                const SizedBox(height: 12),
                _buildImageCard('Result', null, _processedImageData, _processedWidth, _processedHeight),
              ],
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_selectedImagePath != null)
              Expanded(child: _buildImageCard('Original', _selectedImagePath!, null, _originalWidth, _originalHeight)),
            if (_processedImageData != null) ...[
              const SizedBox(width: 12),
              Expanded(child: _buildImageCard('Result', null, _processedImageData, _processedWidth, _processedHeight)),
            ],
          ],
        );
      },
    );
  }

  Widget _buildImageCard(String label, String? path, Uint8List? bytes, int? width, int? height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            if (width != null && height != null) ...[
              const SizedBox(width: 8),
              Text('${width}x$height', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            ],
            if (label == 'Result' && _processingTime != null) ...[
              const SizedBox(width: 8),
              Text('${_processingTime!.inMilliseconds}ms', style: TextStyle(color: Colors.green.shade600, fontSize: 12)),
            ],
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: path != null
              ? Image.file(File(path), fit: BoxFit.contain, height: 200)
              : Image.memory(bytes!, fit: BoxFit.contain, height: 200),
        ),
      ],
    );
  }
}
