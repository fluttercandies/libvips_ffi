/// High-level Dart API for libvips image processing.
///
/// This package provides a Pipeline-style chainable API for image processing,
/// similar to sharp (Node.js).
///
/// ## Quick Start
///
/// ```dart
/// import 'package:libvips_ffi_api/libvips_ffi_api.dart';
///
/// void main() {
///   // Initialize with pre-loaded library
///   initVipsApi(library);
///
///   // Chain operations
///   final result = VipsPipeline.fromFile('input.jpg')
///       .resize(0.5)
///       .blur(1.0)
///       .sharpen()
///       .toBuffer(format: '.jpg');
///
///   shutdownVipsApi();
/// }
/// ```
library;

// Core initialization
export 'src/vips_api_init.dart'
    show
        initVipsApi,
        initVipsApiWithLookup,
        shutdownVipsApi,
        isVipsApiInitialized,
        vipsVersion,
        vipsVersionString,
        VipsApiException;

// Image wrapper
export 'src/image/vips_img.dart' show VipsImg;

// Pipeline
export 'src/pipeline/vips_pipeline.dart' show VipsPipeline;

// Pipeline extensions
export 'src/pipeline/extensions/resample_ext.dart';
export 'src/pipeline/extensions/geometry_ext.dart';
export 'src/pipeline/extensions/convolution_ext.dart';
export 'src/pipeline/extensions/colour_ext.dart';
export 'src/pipeline/extensions/conversion_ext.dart';
export 'src/pipeline/extensions/composite_ext.dart';
export 'src/pipeline/extensions/create_ext.dart';

// Types
export 'src/types/enums.dart';
export 'src/types/save_options.dart';

// Spec (for serializable pipelines)
export 'src/spec/operation_spec.dart';
export 'src/spec/pipeline_spec.dart';
