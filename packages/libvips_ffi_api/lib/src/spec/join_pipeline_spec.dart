import 'dart:typed_data';

import '../image/vips_img.dart';
import '../pipeline/vips_pipeline.dart';
import '../pipeline/extensions/composite_ext.dart';
import 'pipeline_spec.dart';

/// Direction for joining images.
enum JoinDirection {
  /// Join images vertically (top to bottom).
  vertical,
  /// Join images horizontally (left to right).
  horizontal,
}

/// Input source for join operation.
sealed class JoinInput {
  const JoinInput();
}

/// Input from file path.
class JoinInputPath extends JoinInput {
  final String path;
  const JoinInputPath(this.path);
}

/// Input from buffer data.
class JoinInputBuffer extends JoinInput {
  final Uint8List data;
  const JoinInputBuffer(this.data);
}

/// Serializable specification for joining multiple images.
///
/// Use this when you need to combine multiple images into one.
/// Supports both vertical and horizontal joining.
///
/// Example:
/// ```dart
/// final spec = JoinPipelineSpec()
///   .addInputPath('/path/to/image1.png')
///   .addInputPath('/path/to/image2.png')
///   .addInputPath('/path/to/image3.png')
///   .vertical()
///   .outputPng();
///
/// final result = await VipsPipelineCompute.executeJoin(spec);
/// ```
class JoinPipelineSpec {
  final List<JoinInput> _inputs = [];
  JoinDirection _direction = JoinDirection.vertical;
  OutputSpec _output = const OutputSpec('.png');

  JoinPipelineSpec();

  /// Add input image from file path.
  JoinPipelineSpec addInputPath(String path) {
    _inputs.add(JoinInputPath(path));
    return this;
  }

  /// Add input image from buffer data.
  JoinPipelineSpec addInputBuffer(Uint8List data) {
    _inputs.add(JoinInputBuffer(data));
    return this;
  }

  /// Add multiple input paths.
  JoinPipelineSpec addInputPaths(List<String> paths) {
    for (final path in paths) {
      _inputs.add(JoinInputPath(path));
    }
    return this;
  }

  /// Set join direction to vertical (top to bottom).
  JoinPipelineSpec vertical() {
    _direction = JoinDirection.vertical;
    return this;
  }

  /// Set join direction to horizontal (left to right).
  JoinPipelineSpec horizontal() {
    _direction = JoinDirection.horizontal;
    return this;
  }

  /// Set output format.
  JoinPipelineSpec outputAs(OutputSpec output) {
    _output = output;
    return this;
  }

  /// Set output as JPEG.
  JoinPipelineSpec outputJpeg([int quality = 75]) {
    _output = OutputSpec.jpeg(quality);
    return this;
  }

  /// Set output as PNG.
  JoinPipelineSpec outputPng([int compression = 6]) {
    _output = OutputSpec.png(compression);
    return this;
  }

  /// Set output as WebP.
  JoinPipelineSpec outputWebp({int quality = 75, bool lossless = false}) {
    _output = OutputSpec.webp(quality: quality, lossless: lossless);
    return this;
  }

  /// Get output format.
  String get outputFormat => _output.format;

  /// Get number of inputs.
  int get inputCount => _inputs.length;

  /// Get join direction.
  JoinDirection get direction => _direction;

  /// Get inputs (for serialization).
  List<JoinInput> get inputs => List.unmodifiable(_inputs);

  /// Execute the join pipeline and return result buffer.
  ///
  /// Call this in the target isolate after initializing vips.
  Uint8List execute() {
    if (_inputs.length < 2) {
      throw StateError('At least 2 inputs are required for join. Got ${_inputs.length}.');
    }

    VipsPipeline? pipeline;

    for (final input in _inputs) {
      final img = switch (input) {
        JoinInputPath(:final path) => VipsImg.fromFile(path),
        JoinInputBuffer(:final data) => VipsImg.fromBuffer(data),
      };

      if (pipeline == null) {
        pipeline = VipsPipeline.fromImage(img);
      } else {
        pipeline = switch (_direction) {
          JoinDirection.vertical => pipeline.joinVertical(img),
          JoinDirection.horizontal => pipeline.joinHorizontal(img),
        };
      }
    }

    return pipeline!.toBuffer(format: _output.format);
  }

  /// Execute and save to file.
  void executeToFile(String path) {
    if (_inputs.length < 2) {
      throw StateError('At least 2 inputs are required for join. Got ${_inputs.length}.');
    }

    VipsPipeline? pipeline;

    for (final input in _inputs) {
      final img = switch (input) {
        JoinInputPath(:final path) => VipsImg.fromFile(path),
        JoinInputBuffer(:final data) => VipsImg.fromBuffer(data),
      };

      if (pipeline == null) {
        pipeline = VipsPipeline.fromImage(img);
      } else {
        pipeline = switch (_direction) {
          JoinDirection.vertical => pipeline.joinVertical(img),
          JoinDirection.horizontal => pipeline.joinHorizontal(img),
        };
      }
    }

    pipeline!.toFile(path);
    pipeline.dispose();
  }
}
