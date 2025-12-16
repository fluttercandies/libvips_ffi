import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libvips_ffi/libvips_ffi.dart';
import 'package:image_picker/image_picker.dart';

void _log(String message) {
  debugPrint('[Benchmark] $message');
  developer.log(message, name: 'Benchmark');
}

/// Benchmark result for a single operation
class BenchmarkResult {
  final String name;
  final double syncAvgMs;
  final double pipelineAvgMs;
  final int iterations;

  BenchmarkResult({
    required this.name,
    required this.syncAvgMs,
    required this.pipelineAvgMs,
    required this.iterations,
  });

  String get winner => pipelineAvgMs < syncAvgMs ? 'Pipeline' : 'Sync';
  
  double get leadPercent {
    if (pipelineAvgMs < syncAvgMs) {
      return ((syncAvgMs - pipelineAvgMs) / syncAvgMs * 100);
    } else {
      return ((pipelineAvgMs - syncAvgMs) / pipelineAvgMs * 100);
    }
  }
}

class BenchmarkPage extends StatefulWidget {
  const BenchmarkPage({super.key});

  @override
  State<BenchmarkPage> createState() => _BenchmarkPageState();
}

class _BenchmarkPageState extends State<BenchmarkPage> {
  String? _selectedImagePath;
  bool _isRunning = false;
  String _status = 'Select an image to start benchmark';
  final List<BenchmarkResult> _results = [];
  int _iterations = 10;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    initVips();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImagePath = image.path;
        _results.clear();
        _status = 'Image selected. Ready to run benchmark.';
      });
    }
  }

  Future<void> _runBenchmark() async {
    if (_selectedImagePath == null || _isRunning) return;

    setState(() {
      _isRunning = true;
      _results.clear();
      _status = 'Running benchmark...';
    });

    try {
      // Define operations to benchmark: (syncOp, pipelineSpec builder)
      final operations = <String, (
        VipsImageWrapper Function(VipsImageWrapper),
        PipelineSpec Function(String),
      )>{
        'Resize (0.5x)': (
          (img) => img.resize(0.5),
          (path) => PipelineSpec().input(path).resize(0.5).outputPng(),
        ),
        'Thumbnail (200px)': (
          (img) => img.thumbnail(200),
          (path) => PipelineSpec().input(path).thumbnail(200).outputPng(),
        ),
        'Rotate (90°)': (
          (img) => img.rotate(90),
          (path) => PipelineSpec().input(path).rotate(90).outputPng(),
        ),
        'Flip Horizontal': (
          (img) => img.flip(VipsDirection.horizontal),
          (path) => PipelineSpec().input(path).flipHorizontal().outputPng(),
        ),
        'Gaussian Blur (σ=3)': (
          (img) => img.gaussianBlur(3.0),
          (path) => PipelineSpec().input(path).blur(3.0).outputPng(),
        ),
        'Sharpen': (
          (img) => img.sharpen(),
          (path) => PipelineSpec().input(path).sharpen().outputPng(),
        ),
        'Invert': (
          (img) => img.invert(),
          (path) => PipelineSpec().input(path).invert().outputPng(),
        ),
        'Brightness (+20%)': (
          (img) => img.brightness(1.2),
          (path) => PipelineSpec().input(path).brightness(1.2).outputPng(),
        ),
        'Contrast (+30%)': (
          (img) => img.contrast(1.3),
          (path) => PipelineSpec().input(path).contrast(1.3).outputPng(),
        ),
        'Auto Rotate': (
          (img) => img.autoRotate(),
          (path) => PipelineSpec().input(path).autoRotate().outputPng(),
        ),
      };

      for (final entry in operations.entries) {
        final name = entry.key;
        final (syncOp, specBuilder) = entry.value;

        setState(() {
          _status = 'Benchmarking: $name...';
        });

        _log('Benchmarking: $name');

        // Sync benchmark - include writeToBuffer to force evaluation
        // (libvips uses lazy evaluation)
        final syncTimes = <int>[];
        for (var i = 0; i < _iterations; i++) {
          final image = VipsImageWrapper.fromFile(_selectedImagePath!);
          final stopwatch = Stopwatch()..start();
          final result = syncOp(image);
          // Force evaluation by writing to buffer
          result.writeToBuffer('.png');
          stopwatch.stop();
          syncTimes.add(stopwatch.elapsedMilliseconds);
          result.dispose();
          image.dispose();
        }
        final syncAvg = syncTimes.reduce((a, b) => a + b) / syncTimes.length;

        // Pipeline benchmark - uses VipsPipelineCompute with PipelineSpec (runs in isolate)
        final pipelineTimes = <int>[];
        for (var i = 0; i < _iterations; i++) {
          final stopwatch = Stopwatch()..start();
          await VipsPipelineCompute.execute(specBuilder(_selectedImagePath!));
          stopwatch.stop();
          pipelineTimes.add(stopwatch.elapsedMilliseconds);
        }
        final pipelineAvg = pipelineTimes.reduce((a, b) => a + b) / pipelineTimes.length;

        _log('$name - Sync: ${syncAvg.toStringAsFixed(1)}ms, Pipeline: ${pipelineAvg.toStringAsFixed(1)}ms');

        setState(() {
          _results.add(BenchmarkResult(
            name: name,
            syncAvgMs: syncAvg,
            pipelineAvgMs: pipelineAvg,
            iterations: _iterations,
          ));
        });
      }

      setState(() {
        _status = 'Benchmark completed!';
      });
    } catch (e, stack) {
      _log('ERROR: $e');
      _log('Stack trace: $stack');
      setState(() {
        _status = 'Error: $e';
      });
    } finally {
      setState(() {
        _isRunning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Benchmark'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (_results.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.copy),
              tooltip: 'Copy Report',
              onPressed: _copyReport,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Selection
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Image',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    if (_selectedImagePath != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(_selectedImagePath!),
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text('No image selected'),
                        ),
                      ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _isRunning ? null : _pickImage,
                          icon: const Icon(Icons.photo_library),
                          label: const Text('Pick Image'),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Row(
                            children: [
                              const Text('Iterations: '),
                              DropdownButton<int>(
                                value: _iterations,
                                items: [5, 10, 20, 50]
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text('$e'),
                                        ))
                                    .toList(),
                                onChanged: _isRunning
                                    ? null
                                    : (v) => setState(() => _iterations = v!),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Run Button
            if (_selectedImagePath != null)
              ElevatedButton.icon(
                onPressed: _isRunning ? null : _runBenchmark,
                icon: _isRunning
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.speed),
                label: Text(_isRunning ? 'Running...' : 'Run Benchmark'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),
            const SizedBox(height: 16),

            // Status
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _status,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Results Header
            if (_results.isNotEmpty) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Results',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '($_iterations iterations each)',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Result Cards
              ..._results.map((r) => _buildResultCard(r)),
              
              const SizedBox(height: 16),
              
              // Summary Card
              Card(
                color: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.analytics, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Summary',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _getSummary(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(BenchmarkResult r) {
    final isComputeWinner = r.winner == 'Pipeline';
    final winnerColor = isComputeWinner ? Colors.blue : Colors.orange;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Operation name and winner badge
            Row(
              children: [
                Expanded(
                  child: Text(
                    r.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: winnerColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: winnerColor),
                  ),
                  child: Text(
                    '${r.winner} +${r.leadPercent.toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: winnerColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Time comparison
            Row(
              children: [
                Expanded(
                  child: _buildTimeBox(
                    'Sync',
                    r.syncAvgMs,
                    r.winner == 'Sync',
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTimeBox(
                    'Compute',
                    r.pipelineAvgMs,
                    r.winner == 'Pipeline',
                    Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeBox(String label, double ms, bool isWinner, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isWinner ? color.withOpacity(0.1) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: isWinner ? Border.all(color: color, width: 2) : null,
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${ms.toStringAsFixed(1)}ms',
            style: TextStyle(
              fontSize: 16,
              fontWeight: isWinner ? FontWeight.bold : FontWeight.normal,
              color: isWinner ? color : null,
            ),
          ),
        ],
      ),
    );
  }

  String _getSummary() {
    if (_results.isEmpty) return '';

    final syncWins = _results.where((r) => r.winner == 'Sync').length;
    final computeWins = _results.where((r) => r.winner == 'Pipeline').length;

    final totalSync = _results.map((r) => r.syncAvgMs).reduce((a, b) => a + b);
    final totalCompute = _results.map((r) => r.pipelineAvgMs).reduce((a, b) => a + b);

    return 'Summary: Sync wins $syncWins, Compute wins $computeWins\n'
        'Total time - Sync: ${totalSync.toStringAsFixed(1)}ms, Compute: ${totalCompute.toStringAsFixed(1)}ms\n\n'
        'Note:\n'
        '• Sync: Faster raw speed, but blocks UI thread\n'
        '• Compute: Uses Flutter compute(), runs in isolate,\n'
        '  keeps UI responsive during processing\n'
        '• Use Compute for large images to avoid UI jank';
  }

  String _generateReport() {
    if (_results.isEmpty) return '';

    final buffer = StringBuffer();
    buffer.writeln('# Flutter Vips Benchmark Report');
    buffer.writeln();
    buffer.writeln('**Iterations:** $_iterations');
    buffer.writeln('**Date:** ${DateTime.now().toIso8601String()}');
    buffer.writeln();
    buffer.writeln('## Results');
    buffer.writeln();
    buffer.writeln('| Operation | Sync (ms) | Compute (ms) | Winner | Lead |');
    buffer.writeln('|-----------|-----------|--------------|--------|------|');
    
    for (final r in _results) {
      buffer.writeln(
        '| ${r.name} | ${r.syncAvgMs.toStringAsFixed(1)} | ${r.pipelineAvgMs.toStringAsFixed(1)} | ${r.winner} | +${r.leadPercent.toStringAsFixed(1)}% |'
      );
    }
    
    buffer.writeln();
    buffer.writeln('## Summary');
    buffer.writeln();
    
    final syncWins = _results.where((r) => r.winner == 'Sync').length;
    final computeWins = _results.where((r) => r.winner == 'Pipeline').length;
    final totalSync = _results.map((r) => r.syncAvgMs).reduce((a, b) => a + b);
    final totalCompute = _results.map((r) => r.pipelineAvgMs).reduce((a, b) => a + b);
    
    buffer.writeln('- **Sync wins:** $syncWins');
    buffer.writeln('- **Compute wins:** $computeWins');
    buffer.writeln('- **Total Sync time:** ${totalSync.toStringAsFixed(1)}ms');
    buffer.writeln('- **Total Compute time:** ${totalCompute.toStringAsFixed(1)}ms');
    buffer.writeln();
    buffer.writeln('## Notes');
    buffer.writeln();
    buffer.writeln('- **Sync**: Runs on main thread, faster but blocks UI');
    buffer.writeln('- **Compute**: Uses Flutter `compute()`, runs in isolate, keeps UI responsive');
    
    return buffer.toString();
  }

  void _copyReport() {
    final report = _generateReport();
    Clipboard.setData(ClipboardData(text: report));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Report copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
