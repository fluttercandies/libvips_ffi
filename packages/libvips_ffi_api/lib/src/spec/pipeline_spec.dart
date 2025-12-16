import 'dart:typed_data';

import '../pipeline/vips_pipeline.dart';
import '../pipeline/extensions/resample_ext.dart';
import '../pipeline/extensions/geometry_ext.dart';
import '../pipeline/extensions/convolution_ext.dart';
import '../pipeline/extensions/colour_ext.dart';
import '../pipeline/extensions/conversion_ext.dart';
import '../types/enums.dart';
import 'operation_spec.dart';

/// Output format specification.
class OutputSpec {
  final String format;
  const OutputSpec(this.format);

  factory OutputSpec.jpeg([int quality = 75]) =>
      OutputSpec(quality != 75 ? '.jpg[Q=$quality]' : '.jpg');

  factory OutputSpec.png([int compression = 6]) =>
      OutputSpec(compression != 6 ? '.png[compression=$compression]' : '.png');

  factory OutputSpec.webp({int quality = 75, bool lossless = false}) {
    final params = <String>[];
    if (quality != 75) params.add('Q=$quality');
    if (lossless) params.add('lossless=1');
    return OutputSpec('.webp${params.isNotEmpty ? '[${params.join(',')}]' : ''}');
  }
}

/// Serializable pipeline specification for cross-isolate use.
///
/// Build a description of operations without executing them,
/// then execute in any isolate.
class PipelineSpec {
  String? _inputPath;
  Uint8List? _inputBuffer;
  final List<OperationSpec> _operations = [];
  OutputSpec _output = const OutputSpec('.png');

  PipelineSpec();

  /// Set input from file path.
  PipelineSpec input(String path) {
    _inputPath = path;
    _inputBuffer = null;
    return this;
  }

  /// Set input from buffer.
  PipelineSpec inputBuffer(Uint8List data) {
    _inputBuffer = data;
    _inputPath = null;
    return this;
  }

  /// Set output format.
  PipelineSpec outputAs(OutputSpec output) {
    _output = output;
    return this;
  }

  /// Set output as JPEG.
  PipelineSpec outputJpeg([int quality = 75]) {
    _output = OutputSpec.jpeg(quality);
    return this;
  }

  /// Set output as PNG.
  PipelineSpec outputPng([int compression = 6]) {
    _output = OutputSpec.png(compression);
    return this;
  }

  /// Set output as WebP.
  PipelineSpec outputWebp({int quality = 75, bool lossless = false}) {
    _output = OutputSpec.webp(quality: quality, lossless: lossless);
    return this;
  }

  // ======= Resample Operations =======

  PipelineSpec resize(double scale) {
    _operations.add(ResizeSpec(scale));
    return this;
  }

  PipelineSpec rotate(double angle) {
    _operations.add(RotateSpec(angle));
    return this;
  }

  PipelineSpec thumbnail(int width) {
    _operations.add(ThumbnailSpec(width));
    return this;
  }

  PipelineSpec reduce(double hshrink, double vshrink) {
    _operations.add(ReduceSpec(hshrink, vshrink));
    return this;
  }

  PipelineSpec shrink(double hshrink, double vshrink) {
    _operations.add(ShrinkSpec(hshrink, vshrink));
    return this;
  }

  // ======= Geometry Operations =======

  PipelineSpec crop(int left, int top, int width, int height) {
    _operations.add(CropSpec(left, top, width, height));
    return this;
  }

  PipelineSpec flip(VipsDirection direction) {
    _operations.add(FlipSpec(direction));
    return this;
  }

  PipelineSpec flipHorizontal() => flip(VipsDirection.horizontal);
  PipelineSpec flipVertical() => flip(VipsDirection.vertical);

  PipelineSpec embed(int x, int y, int width, int height) {
    _operations.add(EmbedSpec(x, y, width, height));
    return this;
  }

  PipelineSpec smartCrop(int width, int height) {
    _operations.add(SmartCropSpec(width, height));
    return this;
  }

  PipelineSpec gravity(VipsCompassDirection direction, int width, int height) {
    _operations.add(GravitySpec(direction, width, height));
    return this;
  }

  PipelineSpec zoom(int xfac, int yfac) {
    _operations.add(ZoomSpec(xfac, yfac));
    return this;
  }

  // ======= Convolution Operations =======

  PipelineSpec blur(double sigma) {
    _operations.add(BlurSpec(sigma));
    return this;
  }

  PipelineSpec sharpen() {
    _operations.add(const SharpenSpec());
    return this;
  }

  PipelineSpec sobel() {
    _operations.add(const SobelSpec());
    return this;
  }

  PipelineSpec canny() {
    _operations.add(const CannySpec());
    return this;
  }

  // ======= Colour Operations =======

  PipelineSpec colourspace(VipsInterpretation space) {
    _operations.add(ColourspaceSpec(space));
    return this;
  }

  PipelineSpec linear(double a, double b) {
    _operations.add(LinearSpec(a, b));
    return this;
  }

  PipelineSpec brightness(double factor) {
    _operations.add(BrightnessSpec(factor));
    return this;
  }

  PipelineSpec contrast(double factor) {
    _operations.add(ContrastSpec(factor));
    return this;
  }

  PipelineSpec grayscale() {
    _operations.add(const GrayscaleSpec());
    return this;
  }

  // ======= Conversion Operations =======

  PipelineSpec flatten() {
    _operations.add(const FlattenSpec());
    return this;
  }

  PipelineSpec cast(VipsBandFormat format) {
    _operations.add(CastSpec(format));
    return this;
  }

  PipelineSpec invert() {
    _operations.add(const InvertSpec());
    return this;
  }

  PipelineSpec gamma() {
    _operations.add(const GammaSpec());
    return this;
  }

  PipelineSpec autoRotate() {
    _operations.add(const AutoRotateSpec());
    return this;
  }

  PipelineSpec extractBand(int band) {
    _operations.add(ExtractBandSpec(band));
    return this;
  }

  PipelineSpec addAlpha([double alpha = 255.0]) {
    _operations.add(AddAlphaSpec(alpha));
    return this;
  }

  // ======= Execution =======

  /// Execute the pipeline and return result buffer.
  ///
  /// Call this in the target isolate after initializing vips.
  Uint8List execute() {
    if (_inputPath == null && _inputBuffer == null) {
      throw StateError('No input specified. Call input() or inputBuffer().');
    }

    var pipeline = _inputPath != null
        ? VipsPipeline.fromFile(_inputPath!)
        : VipsPipeline.fromBuffer(_inputBuffer!);

    for (final op in _operations) {
      pipeline = _applyOperation(pipeline, op);
    }

    return pipeline.toBuffer(format: _output.format);
  }

  VipsPipeline _applyOperation(VipsPipeline pipeline, OperationSpec op) {
    return switch (op) {
      ResizeSpec(:final scale) => pipeline.resize(scale),
      RotateSpec(:final angle) => pipeline.rotate(angle),
      ThumbnailSpec(:final width) => pipeline.thumbnail(width),
      ReduceSpec(:final hshrink, :final vshrink) =>
        pipeline.reduce(hshrink, vshrink),
      ShrinkSpec(:final hshrink, :final vshrink) =>
        pipeline.shrink(hshrink, vshrink),
      CropSpec(:final left, :final top, :final width, :final height) =>
        pipeline.crop(left, top, width, height),
      FlipSpec(:final direction) => pipeline.flip(direction),
      EmbedSpec(:final x, :final y, :final width, :final height) =>
        pipeline.embed(x, y, width, height),
      SmartCropSpec(:final width, :final height) =>
        pipeline.smartCrop(width, height),
      GravitySpec(:final direction, :final width, :final height) =>
        pipeline.gravity(direction, width, height),
      ZoomSpec(:final xfac, :final yfac) => pipeline.zoom(xfac, yfac),
      BlurSpec(:final sigma) => pipeline.blur(sigma),
      SharpenSpec() => pipeline.sharpen(),
      SobelSpec() => pipeline.sobel(),
      CannySpec() => pipeline.canny(),
      ColourspaceSpec(:final space) => pipeline.colourspace(space),
      LinearSpec(:final a, :final b) => pipeline.linear(a, b),
      BrightnessSpec(:final factor) => pipeline.brightness(factor),
      ContrastSpec(:final factor) => pipeline.contrast(factor),
      GrayscaleSpec() => pipeline.grayscale(),
      FlattenSpec() => pipeline.flatten(),
      CastSpec(:final format) => pipeline.cast(format),
      InvertSpec() => pipeline.invert(),
      GammaSpec() => pipeline.gamma(),
      AutoRotateSpec() => pipeline.autoRotate(),
      ExtractBandSpec(:final band) => pipeline.extractBand(band),
      AddAlphaSpec(:final alpha) => pipeline.addAlpha(alpha),
    };
  }
}
