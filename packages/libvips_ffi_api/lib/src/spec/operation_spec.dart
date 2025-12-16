import '../types/enums.dart';

/// A serializable specification for a single operation.
sealed class OperationSpec {
  const OperationSpec();
}

// ======= Resample Operations =======

class ResizeSpec extends OperationSpec {
  final double scale;
  const ResizeSpec(this.scale);
}

class RotateSpec extends OperationSpec {
  final double angle;
  const RotateSpec(this.angle);
}

class ThumbnailSpec extends OperationSpec {
  final int width;
  const ThumbnailSpec(this.width);
}

class ReduceSpec extends OperationSpec {
  final double hshrink;
  final double vshrink;
  const ReduceSpec(this.hshrink, this.vshrink);
}

class ShrinkSpec extends OperationSpec {
  final double hshrink;
  final double vshrink;
  const ShrinkSpec(this.hshrink, this.vshrink);
}

// ======= Geometry Operations =======

class CropSpec extends OperationSpec {
  final int left;
  final int top;
  final int width;
  final int height;
  const CropSpec(this.left, this.top, this.width, this.height);
}

class FlipSpec extends OperationSpec {
  final VipsDirection direction;
  const FlipSpec(this.direction);
}

class EmbedSpec extends OperationSpec {
  final int x;
  final int y;
  final int width;
  final int height;
  const EmbedSpec(this.x, this.y, this.width, this.height);
}

class SmartCropSpec extends OperationSpec {
  final int width;
  final int height;
  const SmartCropSpec(this.width, this.height);
}

class GravitySpec extends OperationSpec {
  final VipsCompassDirection direction;
  final int width;
  final int height;
  const GravitySpec(this.direction, this.width, this.height);
}

class ZoomSpec extends OperationSpec {
  final int xfac;
  final int yfac;
  const ZoomSpec(this.xfac, this.yfac);
}

// ======= Convolution Operations =======

class BlurSpec extends OperationSpec {
  final double sigma;
  const BlurSpec(this.sigma);
}

class SharpenSpec extends OperationSpec {
  const SharpenSpec();
}

class SobelSpec extends OperationSpec {
  const SobelSpec();
}

class CannySpec extends OperationSpec {
  const CannySpec();
}

// ======= Colour Operations =======

class ColourspaceSpec extends OperationSpec {
  final VipsInterpretation space;
  const ColourspaceSpec(this.space);
}

class LinearSpec extends OperationSpec {
  final double a;
  final double b;
  const LinearSpec(this.a, this.b);
}

class BrightnessSpec extends OperationSpec {
  final double factor;
  const BrightnessSpec(this.factor);
}

class ContrastSpec extends OperationSpec {
  final double factor;
  const ContrastSpec(this.factor);
}

class GrayscaleSpec extends OperationSpec {
  const GrayscaleSpec();
}

// ======= Conversion Operations =======

class FlattenSpec extends OperationSpec {
  const FlattenSpec();
}

class CastSpec extends OperationSpec {
  final VipsBandFormat format;
  const CastSpec(this.format);
}

class InvertSpec extends OperationSpec {
  const InvertSpec();
}

class GammaSpec extends OperationSpec {
  const GammaSpec();
}

class AutoRotateSpec extends OperationSpec {
  const AutoRotateSpec();
}

class ExtractBandSpec extends OperationSpec {
  final int band;
  const ExtractBandSpec(this.band);
}

class AddAlphaSpec extends OperationSpec {
  final double alpha;
  const AddAlphaSpec([this.alpha = 255.0]);
}

// ======= Arithmetic Operations =======

class CeilSpec extends OperationSpec {
  const CeilSpec();
}

class FloorSpec extends OperationSpec {
  const FloorSpec();
}

class AbsSpec extends OperationSpec {
  const AbsSpec();
}

class SignSpec extends OperationSpec {
  const SignSpec();
}

// ======= Complex Operations =======

class PolarSpec extends OperationSpec {
  const PolarSpec();
}

class RectSpec extends OperationSpec {
  const RectSpec();
}

class ConjSpec extends OperationSpec {
  const ConjSpec();
}

class RealSpec extends OperationSpec {
  const RealSpec();
}

class ImagSpec extends OperationSpec {
  const ImagSpec();
}

// ======= Frequency Operations =======

class FwfftSpec extends OperationSpec {
  const FwfftSpec();
}

class InvfftSpec extends OperationSpec {
  const InvfftSpec();
}

class SpectrumSpec extends OperationSpec {
  const SpectrumSpec();
}

// ======= Histogram Operations =======

class HistCumSpec extends OperationSpec {
  const HistCumSpec();
}

class HistNormSpec extends OperationSpec {
  const HistNormSpec();
}

class HistEqualSpec extends OperationSpec {
  const HistEqualSpec();
}

class HistFindSpec extends OperationSpec {
  const HistFindSpec();
}

class HistPlotSpec extends OperationSpec {
  const HistPlotSpec();
}

// ======= Morphology Operations =======

class RankSpec extends OperationSpec {
  final int width;
  final int height;
  final int index;
  const RankSpec(this.width, this.height, this.index);
}

class MedianSpec extends OperationSpec {
  final int size;
  const MedianSpec([this.size = 3]);
}

class FillNearestSpec extends OperationSpec {
  const FillNearestSpec();
}

class LabelregionsSpec extends OperationSpec {
  const LabelregionsSpec();
}

// ======= Rotation Operations =======

class Rot90Spec extends OperationSpec {
  const Rot90Spec();
}

class Rot180Spec extends OperationSpec {
  const Rot180Spec();
}

class Rot270Spec extends OperationSpec {
  const Rot270Spec();
}

class Rot45Spec extends OperationSpec {
  const Rot45Spec();
}

// ======= Additional Conversion Operations =======

class BandfoldSpec extends OperationSpec {
  const BandfoldSpec();
}

class BandunfoldSpec extends OperationSpec {
  const BandunfoldSpec();
}

class ByteswapSpec extends OperationSpec {
  const ByteswapSpec();
}

class ScaleSpec extends OperationSpec {
  const ScaleSpec();
}

class SequentialSpec extends OperationSpec {
  const SequentialSpec();
}

class WrapSpec extends OperationSpec {
  const WrapSpec();
}

class MsbSpec extends OperationSpec {
  const MsbSpec();
}

class CopySpec extends OperationSpec {
  const CopySpec();
}

class PremultiplySpec extends OperationSpec {
  const PremultiplySpec();
}

class UnpremultiplySpec extends OperationSpec {
  const UnpremultiplySpec();
}

class BandmeanSpec extends OperationSpec {
  const BandmeanSpec();
}

class ReplicateSpec extends OperationSpec {
  final int across;
  final int down;
  const ReplicateSpec(this.across, this.down);
}

class SubsampleSpec extends OperationSpec {
  final int xfac;
  final int yfac;
  const SubsampleSpec(this.xfac, this.yfac);
}
