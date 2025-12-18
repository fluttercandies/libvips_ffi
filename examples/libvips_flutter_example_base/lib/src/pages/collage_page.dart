import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Collage page for combining multiple images.
///
/// 图片拼接页面，用于组合多张图片。
class CollagePage extends StatefulWidget {
  const CollagePage({super.key});

  @override
  State<CollagePage> createState() => _CollagePageState();
}

class _CollagePageState extends State<CollagePage> {
  final List<CollageItem> _items = [];
  final ImagePicker _picker = ImagePicker();
  
  // Canvas settings
  int _canvasWidth = 800;
  int _canvasHeight = 600;
  Color _backgroundColor = Colors.white;
  
  // Export settings
  int _exportWidth = 1600;
  int _exportHeight = 1200;
  late final TextEditingController _exportWidthController;
  late final TextEditingController _exportHeightController;
  
  // Export state
  bool _isExporting = false;
  Uint8List? _exportedData;
  Duration? _exportTime;
  
  // Selected item for editing
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _exportWidthController = TextEditingController(text: _exportWidth.toString());
    _exportHeightController = TextEditingController(text: _exportHeight.toString());
  }

  @override
  void dispose() {
    _exportWidthController.dispose();
    _exportHeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collage / 图片拼接'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showCanvasSettings,
            tooltip: 'Canvas Settings',
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _items.isEmpty ? null : _clearAll,
            tooltip: 'Clear All',
          ),
        ],
      ),
      body: Row(
        children: [
          // Left panel - Canvas
          Expanded(
            flex: 3,
            child: _buildCanvasArea(),
          ),
          // Right panel - Controls
          SizedBox(
            width: 280,
            child: _buildControlPanel(),
          ),
        ],
      ),
    );
  }

  Widget _buildCanvasArea() {
    return Container(
      color: Colors.grey.shade300,
      child: Center(
        child: Container(
          width: _canvasWidth.toDouble(),
          height: _canvasHeight.toDouble(),
          decoration: BoxDecoration(
            color: _backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRect(
            child: Stack(
              children: [
                // Grid pattern for visual reference
                CustomPaint(
                  size: Size(_canvasWidth.toDouble(), _canvasHeight.toDouble()),
                  painter: _GridPainter(),
                ),
                // Draggable images
                for (int i = 0; i < _items.length; i++)
                  _buildDraggableItem(i),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDraggableItem(int index) {
    final item = _items[index];
    final isSelected = _selectedIndex == index;
    
    return Positioned(
      left: item.x,
      top: item.y,
      child: GestureDetector(
        onTap: () => setState(() => _selectedIndex = index),
        onPanUpdate: (details) {
          setState(() {
            item.x += details.delta.dx;
            item.y += details.delta.dy;
            _selectedIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: isSelected
                ? Border.all(color: Colors.blue, width: 2)
                : null,
          ),
          child: Stack(
            children: [
              Image.memory(
                item.imageData,
                width: item.width,
                height: item.height,
                fit: BoxFit.contain,
              ),
              if (isSelected)
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () => _removeItem(index),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              // Resize handle
              if (isSelected)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        item.width = (item.width + details.delta.dx)
                            .clamp(50, _canvasWidth.toDouble());
                        item.height = (item.height + details.delta.dy)
                            .clamp(50, _canvasHeight.toDouble());
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.open_in_full,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlPanel() {
    return Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Add images section
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Images / 添加图片',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _pickImages,
                  icon: const Icon(Icons.add_photo_alternate),
                  label: const Text('Select Images'),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          
          // Image list
          Expanded(
            child: _items.isEmpty
                ? Center(
                    child: Text(
                      'No images added\n点击上方按钮添加图片',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  )
                : ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) => _buildItemTile(index),
                  ),
          ),
          const Divider(height: 1),
          
          // Selected item controls
          if (_selectedIndex != null && _selectedIndex! < _items.length)
            _buildSelectedItemControls(),
          
          // Export section
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.green.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Export / 导出',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                // Export size settings
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Width',
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        ),
                        keyboardType: TextInputType.number,
                        controller: _exportWidthController,
                        onChanged: (v) {
                          final val = int.tryParse(v);
                          if (val != null && val > 0) {
                            _exportWidth = val;
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('×'),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Height',
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        ),
                        keyboardType: TextInputType.number,
                        controller: _exportHeightController,
                        onChanged: (v) {
                          final val = int.tryParse(v);
                          if (val != null && val > 0) {
                            _exportHeight = val;
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${(_exportWidth * _exportHeight / 1000000).toStringAsFixed(1)} MP',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _items.isEmpty || _isExporting ? null : _exportCollage,
                  icon: _isExporting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_alt),
                  label: Text(_isExporting ? 'Exporting...' : 'Export Collage'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                if (_exportTime != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Exported in ${_exportTime!.inMilliseconds}ms',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemTile(int index) {
    final item = _items[index];
    final isSelected = _selectedIndex == index;
    
    return ListTile(
      dense: true,
      selected: isSelected,
      selectedTileColor: Colors.blue.shade50,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.memory(
          item.imageData,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        'Image ${index + 1}',
        style: const TextStyle(fontSize: 13),
      ),
      subtitle: Text(
        '${item.width.toInt()}x${item.height.toInt()}',
        style: const TextStyle(fontSize: 11),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete, size: 20),
        onPressed: () => _removeItem(index),
      ),
      onTap: () => setState(() => _selectedIndex = index),
    );
  }

  Widget _buildSelectedItemControls() {
    final item = _items[_selectedIndex!];
    
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.orange.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected: Image ${_selectedIndex! + 1}',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('X:', style: TextStyle(fontSize: 11)),
                    Text('${item.x.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Y:', style: TextStyle(fontSize: 11)),
                    Text('${item.y.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('W:', style: TextStyle(fontSize: 11)),
                    Text('${item.width.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('H:', style: TextStyle(fontSize: 11)),
                    Text('${item.height.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _bringToFront(_selectedIndex!),
                  child: const Text('Front', style: TextStyle(fontSize: 11)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _sendToBack(_selectedIndex!),
                  child: const Text('Back', style: TextStyle(fontSize: 11)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickImages() async {
    print('[CollagePage] Picking images...');
    List<String> paths = [];
    
    try {
      if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
        print('[CollagePage] Using file_selector for desktop');
        const typeGroup = XTypeGroup(
          label: 'Images',
          extensions: ['jpg', 'jpeg', 'png', 'webp', 'gif'],
        );
        final files = await openFiles(acceptedTypeGroups: [typeGroup]);
        paths = files.map((f) => f.path).toList();
      } else {
        print('[CollagePage] Using image_picker for mobile');
        final images = await _picker.pickMultiImage();
        paths = images.map((f) => f.path).toList();
      }
      print('[CollagePage] Selected ${paths.length} images');
    } catch (e, stack) {
      print('[CollagePage] Error picking images: $e');
      print('[CollagePage] Stack trace:\n$stack');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking images: $e')),
        );
      }
      return;
    }
    
    for (final path in paths) {
      await _addImage(path);
    }
  }

  Future<void> _addImage(String path) async {
    print('[CollagePage] Adding image: $path');
    try {
      final file = File(path);
      final bytes = await file.readAsBytes();
      print('[CollagePage] Read ${bytes.length} bytes');
      
      // Get image dimensions
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final image = frame.image;
      print('[CollagePage] Original size: ${image.width}x${image.height}');
      
      // Scale down if too large
      double width = image.width.toDouble();
      double height = image.height.toDouble();
      final maxSize = _canvasWidth * 0.4;
      
      if (width > maxSize || height > maxSize) {
        final scale = maxSize / (width > height ? width : height);
        width *= scale;
        height *= scale;
        print('[CollagePage] Scaled to: ${width.toInt()}x${height.toInt()}');
      }
      
      // Position in center with slight offset for each new image
      final offsetX = (_items.length % 3) * 30.0;
      final offsetY = (_items.length % 3) * 30.0;
      
      setState(() {
        _items.add(CollageItem(
          imageData: bytes,
          originalWidth: image.width,
          originalHeight: image.height,
          width: width,
          height: height,
          x: (_canvasWidth - width) / 2 + offsetX,
          y: (_canvasHeight - height) / 2 + offsetY,
        ));
        _selectedIndex = _items.length - 1;
      });
      print('[CollagePage] Image added, total items: ${_items.length}');
    } catch (e, stack) {
      print('[CollagePage] Error loading image: $e');
      print('[CollagePage] Stack trace:\n$stack');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading image: $e')),
        );
      }
    }
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
      if (_selectedIndex == index) {
        _selectedIndex = null;
      } else if (_selectedIndex != null && _selectedIndex! > index) {
        _selectedIndex = _selectedIndex! - 1;
      }
    });
  }

  void _clearAll() {
    setState(() {
      _items.clear();
      _selectedIndex = null;
      _exportedData = null;
    });
  }

  void _bringToFront(int index) {
    if (index >= _items.length - 1) return;
    setState(() {
      final item = _items.removeAt(index);
      _items.add(item);
      _selectedIndex = _items.length - 1;
    });
  }

  void _sendToBack(int index) {
    if (index <= 0) return;
    setState(() {
      final item = _items.removeAt(index);
      _items.insert(0, item);
      _selectedIndex = 0;
    });
  }

  void _showCanvasSettings() {
    showDialog(
      context: context,
      builder: (context) => _CanvasSettingsDialog(
        width: _canvasWidth,
        height: _canvasHeight,
        backgroundColor: _backgroundColor,
        onApply: (width, height, color) {
          setState(() {
            _canvasWidth = width;
            _canvasHeight = height;
            _backgroundColor = color;
          });
        },
      ),
    );
  }

  Future<void> _exportCollage() async {
    if (_items.isEmpty) return;
    
    // Check if export size is large and warn user
    final megapixels = _exportWidth * _exportHeight / 1000000;
    if (megapixels > 10) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Large Export Size'),
          content: Text(
            'You are about to export a ${_exportWidth}×$_exportHeight image (${megapixels.toStringAsFixed(1)} MP).\n\n'
            'This may take a long time and use significant memory.\n\n'
            'Continue?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Continue'),
            ),
          ],
        ),
      );
      if (confirmed != true) return;
    }
    
    print('[CollagePage] Starting export...');
    print('[CollagePage] Canvas: ${_canvasWidth}x$_canvasHeight');
    print('[CollagePage] Items: ${_items.length}');
    print('[CollagePage] Background color: 0x${_colorToHex(_backgroundColor).toRadixString(16).padLeft(6, '0')}');
    
    setState(() {
      _isExporting = true;
      _exportedData = null;
      _exportTime = null;
    });
    
    try {
      final stopwatch = Stopwatch()..start();
      
      // Use user-specified export dimensions
      final outputWidth = _exportWidth;
      final outputHeight = _exportHeight;
      
      // Calculate scale from display canvas to export canvas
      final scaleX = outputWidth / _canvasWidth;
      final scaleY = outputHeight / _canvasHeight;
      final outputScale = scaleX < scaleY ? scaleX : scaleY;
      
      print('[CollagePage] Export size: ${outputWidth}x$outputHeight');
      print('[CollagePage] Output scale: $outputScale');
      
      // TODO: Implement collage export using VipsPipeline
      // The old VipsCompute.createCollage API was removed.
      // Need to implement using VipsPipeline with insert/composite operations.
      stopwatch.stop();
      
      print('[CollagePage] Export not yet implemented with new API');
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Collage export not yet implemented with new Pipeline API'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e, stack) {
      print('[CollagePage] Export error: $e');
      print('[CollagePage] Stack trace:\n$stack');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export error: $e')),
        );
      }
    } finally {
      setState(() {
        _isExporting = false;
      });
    }
  }
  
  int _colorToHex(Color color) {
    return (color.red << 16) | (color.green << 8) | color.blue;
  }

  // ignore: unused_element
  void _showExportPreview() {
    if (_exportedData == null) return;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Preview'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 400, maxHeight: 300),
              child: Image.memory(_exportedData!, fit: BoxFit.contain),
            ),
            const SizedBox(height: 16),
            Text(
              'Size: ${_formatFileSize(_exportedData!.length)}\n'
              'Time: ${_exportTime!.inMilliseconds}ms',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Save to file
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Save functionality coming soon')),
              );
            },
            child: const Text('Save'),
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
}

/// Data class for a collage item
class CollageItem {
  final Uint8List imageData;
  final int originalWidth;
  final int originalHeight;
  double width;   // Display width (thumbnail)
  double height;  // Display height (thumbnail)
  double x;       // Display x position
  double y;       // Display y position

  CollageItem({
    required this.imageData,
    required this.originalWidth,
    required this.originalHeight,
    required this.width,
    required this.height,
    required this.x,
    required this.y,
  });
  
  /// Calculate the scale factor from display to original
  double get displayToOriginalScale => originalWidth / width;
}

/// Grid painter for canvas background
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 1;
    
    const gridSize = 50.0;
    
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Canvas settings dialog
class _CanvasSettingsDialog extends StatefulWidget {
  final int width;
  final int height;
  final Color backgroundColor;
  final void Function(int width, int height, Color color) onApply;

  const _CanvasSettingsDialog({
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.onApply,
  });

  @override
  State<_CanvasSettingsDialog> createState() => _CanvasSettingsDialogState();
}

class _CanvasSettingsDialogState extends State<_CanvasSettingsDialog> {
  late TextEditingController _widthController;
  late TextEditingController _heightController;
  late Color _selectedColor;

  static const List<Color> _presetColors = [
    Colors.white,
    Colors.black,
    Colors.grey,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.transparent,
  ];

  @override
  void initState() {
    super.initState();
    _widthController = TextEditingController(text: widget.width.toString());
    _heightController = TextEditingController(text: widget.height.toString());
    _selectedColor = widget.backgroundColor;
  }

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Canvas Settings'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _widthController,
                  decoration: const InputDecoration(
                    labelText: 'Width',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _heightController,
                  decoration: const InputDecoration(
                    labelText: 'Height',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Background Color:'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _presetColors.map((color) {
              final isSelected = _selectedColor == color;
              return GestureDetector(
                onTap: () => setState(() => _selectedColor = color),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color,
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.grey,
                      width: isSelected ? 3 : 1,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: color == Colors.transparent
                      ? const Icon(Icons.block, size: 20, color: Colors.grey)
                      : null,
                ),
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final width = int.tryParse(_widthController.text) ?? widget.width;
            final height = int.tryParse(_heightController.text) ?? widget.height;
            widget.onApply(
              width.clamp(100, 4000),
              height.clamp(100, 4000),
              _selectedColor,
            );
            Navigator.pop(context);
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
