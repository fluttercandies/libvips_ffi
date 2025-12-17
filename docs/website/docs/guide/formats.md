---
sidebar_position: 3
---

# Output Formats

libvips_ffi supports multiple output formats with various options.

## JPEG

```dart
pipeline.toJpeg(
  quality: 85,        // 1-100, default 75
  optimizeCoding: true,
  interlace: false,
  stripMetadata: true,
)
```

**Options:**
- `quality` - Compression quality (1-100)
- `optimizeCoding` - Optimize Huffman coding
- `interlace` - Progressive JPEG
- `stripMetadata` - Remove EXIF and other metadata

## PNG

```dart
pipeline.toPng(
  compression: 6,     // 0-9, default 6
  interlace: false,
  palette: false,     // Use palette for small file size
)
```

**Options:**
- `compression` - Compression level (0=fast, 9=best)
- `interlace` - Adam7 interlacing
- `palette` - Convert to 8-bit palette

## WebP

```dart
pipeline.toWebp(
  quality: 90,        // 1-100
  lossless: false,
  nearLossless: false,
  alphaQuality: 100,
)
```

**Options:**
- `quality` - Compression quality
- `lossless` - Lossless compression
- `nearLossless` - Near-lossless compression
- `alphaQuality` - Alpha channel quality

## GIF

```dart
pipeline.toGif(
  dither: 1.0,        // Dithering amount
)
```

## TIFF

```dart
pipeline.toTiff(
  compression: VipsTiffCompression.lzw,
  predictor: VipsTiffPredictor.horizontal,
)
```

**Compression options:**
- `VipsTiffCompression.none`
- `VipsTiffCompression.jpeg`
- `VipsTiffCompression.deflate`
- `VipsTiffCompression.lzw`

## HEIF/AVIF

```dart
pipeline.toHeif(
  quality: 80,
  lossless: false,
)

pipeline.toAvif(
  quality: 80,
)
```

:::note
HEIF/AVIF support depends on libvips build configuration.
:::

## DeepZoom (DZI)

Generate a Deep Zoom pyramid for large images.

```dart
pipeline.toDeepZoom(name: 'output')
```

This creates:
- `output.dzi` - XML descriptor
- `output_files/` - Tile directory

## Auto-detect Format

```dart
// From file extension
pipeline.toFile('output.png')  // Saves as PNG

// From format string
pipeline.toBuffer(format: 'webp')
```

## Raw Bytes

```dart
// Get raw pixel data
final bytes = pipeline.toBytes()
```
