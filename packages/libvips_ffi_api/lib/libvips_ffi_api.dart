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
        VipsApiException,
        // Category bindings accessors
        ioBindings,
        arithmeticBindings,
        drawBindings,
        morphologyBindings,
        frequencyBindings,
        createBindings,
        colourBindings,
        relationalBindings,
        conversionBindings,
        convolutionBindings,
        resampleBindings,
        complexBindings,
        mosaicingBindings;

// Image wrapper
export 'src/image/vips_img.dart' show VipsImg;

// Pipeline
export 'src/pipeline/vips_pipeline.dart' show VipsPipeline;

// Pipeline extensions
export 'src/pipeline/extensions/resample_ext.dart';
export 'src/pipeline/extensions/geometry_ext.dart';
export 'src/pipeline/extensions/arithmetic_ext.dart';
export 'src/pipeline/extensions/complex_ext.dart';
export 'src/pipeline/extensions/convolution_ext.dart';
export 'src/pipeline/extensions/colour_ext.dart';
export 'src/pipeline/extensions/conversion_ext.dart';
export 'src/pipeline/extensions/composite_ext.dart';
export 'src/pipeline/extensions/create_ext.dart';
export 'src/pipeline/extensions/mosaicing_ext.dart';
export 'src/pipeline/extensions/relational_ext.dart';
export 'src/pipeline/extensions/morphology_ext.dart';
export 'src/pipeline/extensions/frequency_ext.dart';
export 'src/pipeline/extensions/histogram_ext.dart';
export 'src/pipeline/extensions/draw_ext.dart';
export 'src/pipeline/extensions/boolean_ext.dart';
export 'src/pipeline/extensions/multi_image_ext.dart';

// Types
export 'src/types/enums.dart';
export 'src/types/save_options.dart';

// Spec (for serializable pipelines)
export 'src/spec/operation_spec.dart';
export 'src/spec/pipeline_spec.dart';
export 'src/spec/join_pipeline_spec.dart';

// Binding classes
export 'src/bindings/vips_bindings.dart' show VipsApiBindings;
export 'src/bindings/io_bindings.dart' show VipsIoBindings;
export 'src/bindings/arithmetic_bindings.dart' show VipsArithmeticBindings;
export 'src/bindings/draw_bindings.dart' show VipsDrawBindings;
export 'src/bindings/morphology_bindings.dart' show VipsMorphologyBindings;
export 'src/bindings/frequency_bindings.dart' show VipsFrequencyBindings;
export 'src/bindings/create_bindings.dart' show VipsCreateBindings;
export 'src/bindings/colour_bindings.dart' show VipsColourBindings;
export 'src/bindings/relational_bindings.dart' show VipsRelationalBindings;
export 'src/bindings/conversion_bindings.dart' show VipsConversionBindings;
export 'src/bindings/convolution_bindings.dart' show VipsConvolutionBindings;
export 'src/bindings/resample_bindings.dart' show VipsResampleBindings;
export 'src/bindings/complex_bindings.dart' show VipsComplexBindings;
export 'src/bindings/mosaicing_bindings.dart' show VipsMosaicingBindings;
