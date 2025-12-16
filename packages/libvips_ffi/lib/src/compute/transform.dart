import 'package:libvips_ffi_core/libvips_ffi_core.dart';

import 'isolates.dart';
import 'types.dart';

// ============ Transform Operations ============
// ============ 变换操作 ============

/// Resize file isolate function.
VipsComputeResult resizeFile(ComputeParams p) =>
    processFromFile(p.filePath!, (img) => img.resize(p.args['scale'] as double));

/// Resize data isolate function.
VipsComputeResult resizeData(ComputeParams p) =>
    processFromData(p.imageData!, (img) => img.resize(p.args['scale'] as double));

/// Thumbnail file isolate function.
VipsComputeResult thumbnailFile(ComputeParams p) =>
    processFromFile(p.filePath!, (img) => img.thumbnail(p.args['width'] as int));

/// Thumbnail data isolate function.
VipsComputeResult thumbnailData(ComputeParams p) =>
    processFromData(p.imageData!, (img) => img.thumbnail(p.args['width'] as int));

/// Rotate file isolate function.
VipsComputeResult rotateFile(ComputeParams p) =>
    processFromFile(p.filePath!, (img) => img.rotate(p.args['angle'] as double));

/// Rotate data isolate function.
VipsComputeResult rotateData(ComputeParams p) =>
    processFromData(p.imageData!, (img) => img.rotate(p.args['angle'] as double));

/// Crop file isolate function.
VipsComputeResult cropFile(ComputeParams p) =>
    processFromFile(p.filePath!, (img) => img.crop(
      p.args['left'] as int,
      p.args['top'] as int,
      p.args['width'] as int,
      p.args['height'] as int,
    ));

/// Crop data isolate function.
VipsComputeResult cropData(ComputeParams p) =>
    processFromData(p.imageData!, (img) => img.crop(
      p.args['left'] as int,
      p.args['top'] as int,
      p.args['width'] as int,
      p.args['height'] as int,
    ));

/// Flip file isolate function.
VipsComputeResult flipFile(ComputeParams p) =>
    processFromFile(p.filePath!, (img) => img.flip(VipsDirection.values[p.args['direction'] as int]));

/// Flip data isolate function.
VipsComputeResult flipData(ComputeParams p) =>
    processFromData(p.imageData!, (img) => img.flip(VipsDirection.values[p.args['direction'] as int]));
