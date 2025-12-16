/// Options for saving images in different formats.

/// JPEG save options.
class JpegOptions {
  /// Quality factor (0-100, default 75).
  final int quality;
  
  /// Compute optimal Huffman coding tables.
  final bool optimizeCoding;
  
  /// Write an interlaced (progressive) jpeg.
  final bool interlace;
  
  /// Apply trellis quantisation to each 8x8 block.
  final bool trellisQuant;
  
  /// Apply overshooting to samples with extreme values.
  final bool overshootDeringing;
  
  /// Split DCT coefficients into separate scans.
  final bool optimizeScans;
  
  /// Quantization table index.
  final int quantTable;
  
  const JpegOptions({
    this.quality = 75,
    this.optimizeCoding = false,
    this.interlace = false,
    this.trellisQuant = false,
    this.overshootDeringing = false,
    this.optimizeScans = false,
    this.quantTable = 0,
  });
  
  String toSuffix() {
    final params = <String>[];
    if (quality != 75) params.add('Q=$quality');
    if (optimizeCoding) params.add('optimize_coding=1');
    if (interlace) params.add('interlace=1');
    return '.jpg${params.isNotEmpty ? '[${params.join(',')}]' : ''}';
  }
}

/// PNG save options.
class PngOptions {
  /// Compression factor (0-9, default 6).
  final int compression;
  
  /// Write an interlaced image.
  final bool interlace;
  
  /// Quantise to 8-bit palette.
  final bool palette;
  
  /// Quantisation quality (0-100, default 100).
  final int quality;
  
  /// Quantisation CPU effort (1-10, default 7).
  final int effort;
  
  /// Dithering level (0-1, default 1.0).
  final double dither;
  
  const PngOptions({
    this.compression = 6,
    this.interlace = false,
    this.palette = false,
    this.quality = 100,
    this.effort = 7,
    this.dither = 1.0,
  });
  
  String toSuffix() {
    final params = <String>[];
    if (compression != 6) params.add('compression=$compression');
    if (interlace) params.add('interlace=1');
    if (palette) params.add('palette=1');
    return '.png${params.isNotEmpty ? '[${params.join(',')}]' : ''}';
  }
}

/// WebP save options.
class WebpOptions {
  /// Quality factor (0-100, default 75).
  final int quality;
  
  /// Enable lossless compression.
  final bool lossless;
  
  /// Preset for lossy compression.
  final WebpPreset preset;
  
  /// Enable smart subsampling.
  final bool smartSubsample;
  
  /// Target file size in bytes (0 = disabled).
  final int targetSize;
  
  /// Effort level (0-6, default 4).
  final int effort;
  
  const WebpOptions({
    this.quality = 75,
    this.lossless = false,
    this.preset = WebpPreset.default_,
    this.smartSubsample = false,
    this.targetSize = 0,
    this.effort = 4,
  });
  
  String toSuffix() {
    final params = <String>[];
    if (quality != 75) params.add('Q=$quality');
    if (lossless) params.add('lossless=1');
    if (effort != 4) params.add('effort=$effort');
    return '.webp${params.isNotEmpty ? '[${params.join(',')}]' : ''}';
  }
}

/// WebP preset options.
enum WebpPreset {
  default_(0),
  picture(1),
  photo(2),
  drawing(3),
  icon(4),
  text(5);
  
  final int value;
  const WebpPreset(this.value);
}

/// AVIF save options.
class AvifOptions {
  /// Quality factor (0-100, default 50).
  final int quality;
  
  /// Enable lossless compression.
  final bool lossless;
  
  /// Compression speed (0-9, default 4).
  final int speed;
  
  const AvifOptions({
    this.quality = 50,
    this.lossless = false,
    this.speed = 4,
  });
  
  String toSuffix() {
    final params = <String>[];
    if (quality != 50) params.add('Q=$quality');
    if (lossless) params.add('lossless=1');
    if (speed != 4) params.add('speed=$speed');
    return '.avif${params.isNotEmpty ? '[${params.join(',')}]' : ''}';
  }
}

/// HEIF save options.
class HeifOptions {
  /// Quality factor (0-100, default 50).
  final int quality;
  
  /// Enable lossless compression.
  final bool lossless;
  
  /// Compression format.
  final HeifCompression compression;
  
  /// Effort level (0-9, default 4).
  final int effort;
  
  const HeifOptions({
    this.quality = 50,
    this.lossless = false,
    this.compression = HeifCompression.hevc,
    this.effort = 4,
  });
  
  String toSuffix() {
    final params = <String>[];
    if (quality != 50) params.add('Q=$quality');
    if (lossless) params.add('lossless=1');
    return '.heif${params.isNotEmpty ? '[${params.join(',')}]' : ''}';
  }
}

/// HEIF compression formats.
enum HeifCompression {
  hevc(1),
  avc(2),
  jpeg(3),
  av1(4);
  
  final int value;
  const HeifCompression(this.value);
}

/// TIFF save options.
class TiffOptions {
  /// Compression format.
  final TiffCompression compression;
  
  /// Quality factor for JPEG compression (0-100, default 75).
  final int quality;
  
  /// Write a tiled tiff.
  final bool tile;
  
  /// Tile width.
  final int tileWidth;
  
  /// Tile height.
  final int tileHeight;
  
  /// Write a pyramidal tiff.
  final bool pyramid;
  
  const TiffOptions({
    this.compression = TiffCompression.none,
    this.quality = 75,
    this.tile = false,
    this.tileWidth = 128,
    this.tileHeight = 128,
    this.pyramid = false,
  });
  
  String toSuffix() {
    final params = <String>[];
    if (compression != TiffCompression.none) {
      params.add('compression=${compression.name}');
    }
    if (tile) params.add('tile=1');
    if (pyramid) params.add('pyramid=1');
    return '.tiff${params.isNotEmpty ? '[${params.join(',')}]' : ''}';
  }
}

/// TIFF compression formats.
enum TiffCompression {
  none(0),
  jpeg(7),
  deflate(8),
  packbits(32773),
  lzw(5),
  webp(50001),
  zstd(50000),
  jp2k(34712);
  
  final int value;
  const TiffCompression(this.value);
}

/// GIF save options.
class GifOptions {
  /// Quantisation effort (1-10, default 7).
  final int effort;
  
  /// Enable interlacing.
  final bool interlace;
  
  /// Dithering level (0-1, default 1.0).
  final double dither;
  
  const GifOptions({
    this.effort = 7,
    this.interlace = false,
    this.dither = 1.0,
  });
  
  String toSuffix() {
    final params = <String>[];
    if (effort != 7) params.add('effort=$effort');
    if (interlace) params.add('interlace=1');
    return '.gif${params.isNotEmpty ? '[${params.join(',')}]' : ''}';
  }
}
