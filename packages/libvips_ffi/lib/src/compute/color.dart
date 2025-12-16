import 'package:libvips_ffi_core/libvips_ffi_core.dart';

import 'isolates.dart';
import 'types.dart';

// ============ Color Operations ============
// ============ 颜色操作 ============

/// Brightness file isolate function.
VipsComputeResult brightnessFile(ComputeParams p) =>
    processFromFile(p.filePath!, (img) => img.brightness(p.args['factor'] as double));

/// Brightness data isolate function.
VipsComputeResult brightnessData(ComputeParams p) =>
    processFromData(p.imageData!, (img) => img.brightness(p.args['factor'] as double));

/// Contrast file isolate function.
VipsComputeResult contrastFile(ComputeParams p) =>
    processFromFile(p.filePath!, (img) => img.contrast(p.args['factor'] as double));

/// Contrast data isolate function.
VipsComputeResult contrastData(ComputeParams p) =>
    processFromData(p.imageData!, (img) => img.contrast(p.args['factor'] as double));

/// Auto rotate file isolate function.
VipsComputeResult autoRotateFile(ComputeParams p) =>
    processFromFile(p.filePath!, (img) => img.autoRotate());

/// Auto rotate data isolate function.
VipsComputeResult autoRotateData(ComputeParams p) =>
    processFromData(p.imageData!, (img) => img.autoRotate());
