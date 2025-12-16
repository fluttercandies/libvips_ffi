import 'package:libvips_ffi_core/libvips_ffi_core.dart';

import 'isolates.dart';
import 'types.dart';

// ============ Filter Operations ============
// ============ 滤镜操作 ============

/// Blur file isolate function.
VipsComputeResult blurFile(ComputeParams p) =>
    processFromFile(p.filePath!, (img) => img.gaussianBlur(p.args['sigma'] as double));

/// Blur data isolate function.
VipsComputeResult blurData(ComputeParams p) =>
    processFromData(p.imageData!, (img) => img.gaussianBlur(p.args['sigma'] as double));

/// Sharpen file isolate function.
VipsComputeResult sharpenFile(ComputeParams p) =>
    processFromFile(p.filePath!, (img) => img.sharpen());

/// Sharpen data isolate function.
VipsComputeResult sharpenData(ComputeParams p) =>
    processFromData(p.imageData!, (img) => img.sharpen());

/// Invert file isolate function.
VipsComputeResult invertFile(ComputeParams p) =>
    processFromFile(p.filePath!, (img) => img.invert());

/// Invert data isolate function.
VipsComputeResult invertData(ComputeParams p) =>
    processFromData(p.imageData!, (img) => img.invert());
