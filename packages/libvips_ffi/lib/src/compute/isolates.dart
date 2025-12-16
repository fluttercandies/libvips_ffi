import 'package:flutter/foundation.dart';
import 'package:libvips_ffi_core/libvips_ffi_core.dart';

import '../platform_loader.dart';
import 'types.dart';

/// Parameters for compute operations.
///
/// 计算操作的参数。
class ComputeParams {
  final String? filePath;
  final Uint8List? imageData;
  final Map<String, dynamic> args;

  ComputeParams({
    this.filePath,
    this.imageData,
    required this.args,
  });
}

/// Parameters for processing a file.
///
/// 处理文件的参数。
class ProcessFileParams {
  final String filePath;
  final VipsImageWrapper Function(VipsImageWrapper) operation;
  ProcessFileParams(this.filePath, this.operation);
}

/// Parameters for processing image data.
///
/// 处理图像数据的参数。
class ProcessDataParams {
  final Uint8List imageData;
  final VipsImageWrapper Function(VipsImageWrapper) operation;
  ProcessDataParams(this.imageData, this.operation);
}

/// Process file in isolate.
///
/// 在 isolate 中处理文件。
VipsComputeResult processFileIsolate(ProcessFileParams params) {
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

/// Process data in isolate.
///
/// 在 isolate 中处理数据。
VipsComputeResult processDataIsolate(ProcessDataParams params) {
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

/// Helper to process from file.
///
/// 从文件处理的辅助函数。
VipsComputeResult processFromFile(String filePath, VipsImageWrapper Function(VipsImageWrapper) op) {
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

/// Helper to process from data.
///
/// 从数据处理的辅助函数。
VipsComputeResult processFromData(Uint8List imageData, VipsImageWrapper Function(VipsImageWrapper) op) {
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
