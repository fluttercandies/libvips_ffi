import 'package:flutter/foundation.dart';
import 'package:libvips_ffi_api/libvips_ffi_api.dart';
import 'package:libvips_ffi_core/libvips_ffi_core.dart' as core;

import '../platform_loader.dart';
import 'types.dart';

/// Parameters for pipeline-based compute operations.
class PipelineComputeParams {
  final PipelineSpec spec;

  PipelineComputeParams({required this.spec});
}

/// Parameters for join pipeline compute operations.
class JoinPipelineComputeParams {
  final JoinPipelineSpec spec;
  final String? outputPath;

  JoinPipelineComputeParams({required this.spec, this.outputPath});
}

/// Parameters for VipsPipeline callback-based operations.
class PipelineCallbackParams {
  final String? inputPath;
  final Uint8List? inputData;
  final VipsPipeline Function(VipsPipeline) operation;
  final String outputFormat;

  PipelineCallbackParams({
    this.inputPath,
    this.inputData,
    required this.operation,
    this.outputFormat = '.png',
  });
}

/// Execute a JoinPipelineSpec in an isolate.
///
/// 在 isolate 中执行 JoinPipelineSpec。
VipsComputeResult executeJoinPipelineIsolate(JoinPipelineComputeParams params) {
  initVips();
  initVipsApi(core.vipsLibrary);

  try {
    if (params.outputPath != null) {
      params.spec.executeToFile(params.outputPath!);
      return VipsComputeResult(data: Uint8List(0), width: 0, height: 0, bands: 0);
    } else {
      final result = params.spec.execute();
      return VipsComputeResult(data: result, width: 0, height: 0, bands: 0);
    }
  } finally {
    // Note: don't shutdown vips here as it may be reused
  }
}

/// Execute a PipelineSpec in an isolate.
///
/// 在 isolate 中执行 PipelineSpec。
VipsComputeResult executePipelineIsolate(PipelineComputeParams params) {
  // Initialize both core libvips and api bindings in this isolate
  initVips();
  initVipsApi(core.vipsLibrary);

  try {
    // Execute the pipeline spec - execute() handles everything internally
    final result = params.spec.execute();
    return VipsComputeResult(
      data: result,
      width: 0, // Width/height not available from execute()
      height: 0,
      bands: 0,
    );
  } finally {
    // Note: don't shutdown vips here as it may be reused
  }
}

/// Execute a VipsPipeline callback in an isolate.
///
/// 在 isolate 中执行 VipsPipeline 回调。
VipsComputeResult executePipelineCallbackIsolate(PipelineCallbackParams params) {
  // Initialize libvips in this isolate
  initVips();

  try {
    // Create pipeline from input
    late VipsPipeline pipeline;
    if (params.inputPath != null) {
      pipeline = VipsPipeline.fromFile(params.inputPath!);
    } else if (params.inputData != null) {
      pipeline = VipsPipeline.fromBuffer(params.inputData!);
    } else {
      throw ArgumentError('Must provide inputPath or inputData');
    }

    // Apply user operation
    pipeline = params.operation(pipeline);

    // Get result
    final data = pipeline.toBuffer(format: params.outputFormat);
    final width = pipeline.image.width;
    final height = pipeline.image.height;
    final bands = pipeline.image.bands;

    pipeline.dispose();

    return VipsComputeResult(
      data: data,
      width: width,
      height: height,
      bands: bands,
    );
  } finally {
    // Note: don't shutdown vips here as it may be reused
  }
}

/// High-level API for executing PipelineSpec or VipsPipeline in isolates.
///
/// 用于在 isolate 中执行 PipelineSpec 或 VipsPipeline 的高级 API。
///
/// ## Using PipelineSpec (serializable)
/// ```dart
/// final result = await VipsPipelineCompute.execute(
///   PipelineSpec()
///     .input('input.jpg')
///     .resize(0.5)
///     .blur(2.0)
///     .outputPng(),
/// );
/// ```
///
/// ## Using VipsPipeline callback (more flexible)
/// ```dart
/// final result = await VipsPipelineCompute.processFile(
///   'input.jpg',
///   (pipeline) => pipeline
///     .resize(0.5)
///     .gaussblur(2.0)
///     .sharpen(),
/// );
/// ```
class VipsPipelineCompute {
  /// Execute a PipelineSpec asynchronously using Flutter's compute.
  ///
  /// 使用 Flutter 的 compute 异步执行 PipelineSpec。
  static Future<Uint8List> execute(PipelineSpec spec) async {
    final result = await compute(
      executePipelineIsolate,
      PipelineComputeParams(spec: spec),
    );
    return result.data;
  }

  /// Process a file using VipsPipeline callback.
  ///
  /// 使用 VipsPipeline 回调处理文件。
  ///
  /// [filePath]: Input file path
  /// [operation]: Callback that receives and returns VipsPipeline
  /// [outputFormat]: Output format (default: '.png')
  static Future<VipsComputeResult> processFile(
    String filePath,
    VipsPipeline Function(VipsPipeline) operation, {
    String outputFormat = '.png',
  }) {
    return compute(
      executePipelineCallbackIsolate,
      PipelineCallbackParams(
        inputPath: filePath,
        operation: operation,
        outputFormat: outputFormat,
      ),
    );
  }

  /// Process buffer data using VipsPipeline callback.
  ///
  /// 使用 VipsPipeline 回调处理缓冲区数据。
  ///
  /// [data]: Input image data
  /// [operation]: Callback that receives and returns VipsPipeline
  /// [outputFormat]: Output format (default: '.png')
  static Future<VipsComputeResult> processData(
    Uint8List data,
    VipsPipeline Function(VipsPipeline) operation, {
    String outputFormat = '.png',
  }) {
    return compute(
      executePipelineCallbackIsolate,
      PipelineCallbackParams(
        inputData: data,
        operation: operation,
        outputFormat: outputFormat,
      ),
    );
  }

  /// Create a new PipelineSpec for building operations.
  ///
  /// 创建新的 PipelineSpec 用于构建操作。
  static PipelineSpec create() => PipelineSpec();

  /// Execute a JoinPipelineSpec asynchronously.
  ///
  /// 异步执行 JoinPipelineSpec。
  ///
  /// Example:
  /// ```dart
  /// final result = await VipsPipelineCompute.executeJoin(
  ///   JoinPipelineSpec()
  ///     .addInputPath('/path/to/image1.png')
  ///     .addInputPath('/path/to/image2.png')
  ///     .vertical()
  ///     .outputPng(),
  /// );
  /// ```
  static Future<Uint8List> executeJoin(JoinPipelineSpec spec) async {
    final result = await compute(
      executeJoinPipelineIsolate,
      JoinPipelineComputeParams(spec: spec),
    );
    return result.data;
  }

  /// Execute a JoinPipelineSpec and save to file.
  ///
  /// 执行 JoinPipelineSpec 并保存到文件。
  static Future<void> executeJoinToFile(JoinPipelineSpec spec, String outputPath) async {
    await compute(
      executeJoinPipelineIsolate,
      JoinPipelineComputeParams(spec: spec, outputPath: outputPath),
    );
  }

  /// Create a new JoinPipelineSpec for joining multiple images.
  ///
  /// 创建新的 JoinPipelineSpec 用于合并多个图像。
  static JoinPipelineSpec createJoin() => JoinPipelineSpec();
}
