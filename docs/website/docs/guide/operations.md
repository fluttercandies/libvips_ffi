---
sidebar_position: 2
---

# Operations Reference

Complete reference of all available image operations in libvips_ffi.

## Resizing & Geometry

### resize

Resize an image by width, height, or scale factor.

```dart
pipeline.resize(width: 800)              // By width
pipeline.resize(height: 600)             // By height
pipeline.resize(width: 800, height: 600) // Both (may change aspect ratio)
pipeline.resize(scale: 0.5)              // By scale factor
```

### thumbnail

Create a thumbnail with smart cropping.

```dart
pipeline.thumbnail(
  width: 200,
  height: 200,
  crop: VipsCrop.attention,  // Smart crop focusing on interesting areas
)
```

**Crop options:**
- `VipsCrop.none` - No cropping
- `VipsCrop.centre` - Crop from center
- `VipsCrop.attention` - Focus on interesting areas
- `VipsCrop.entropy` - Crop based on entropy
- `VipsCrop.low` - Crop from top/left
- `VipsCrop.high` - Crop from bottom/right

### crop

Extract a rectangular region.

```dart
pipeline.crop(x: 100, y: 100, width: 400, height: 300)
```

### smartCrop

Automatically crop to the most interesting region.

```dart
pipeline.smartCrop(
  width: 400,
  height: 300,
  interesting: VipsInteresting.attention,
)
```

### rotate

Rotate the image by a specific angle.

```dart
pipeline.rotate(angle: 90)   // Rotate 90 degrees clockwise
pipeline.rotate(angle: -45)  // Rotate 45 degrees counter-clockwise
```

### autoRotate

Auto-rotate based on EXIF orientation data.

```dart
pipeline.autoRotate()
```

### flip

Flip the image horizontally or vertically.

```dart
pipeline.flipHorizontal()
pipeline.flipVertical()
```

## Color Adjustments

### brightness

Adjust image brightness.

```dart
pipeline.brightness(factor: 1.2)  // 20% brighter
pipeline.brightness(factor: 0.8)  // 20% darker
```

### contrast

Adjust image contrast.

```dart
pipeline.contrast(factor: 1.2)  // 20% more contrast
pipeline.contrast(factor: 0.8)  // 20% less contrast
```

### saturation

Adjust color saturation.

```dart
pipeline.saturation(factor: 1.5)  // More saturated
pipeline.saturation(factor: 0.5)  // Less saturated
```

### grayscale

Convert to grayscale.

```dart
pipeline.grayscale()
```

### invert

Invert colors (negative).

```dart
pipeline.invert()
```

## Filters & Effects

### gaussianBlur

Apply Gaussian blur.

```dart
pipeline.gaussianBlur(sigma: 2.0)  // Blur with sigma=2
```

### sharpen

Sharpen the image.

```dart
pipeline.sharpen()
pipeline.sharpen(sigma: 1.5)  // Custom sigma
```

### clamp

Clamp pixel values to a range.

```dart
pipeline.clamp(min: 0, max: 255)
```

### houghCircle

Detect circles using Hough transform.

```dart
pipeline.houghCircle(
  scale: 3,
  minRadius: 10,
  maxRadius: 100,
)
```

### houghLine

Detect lines using Hough transform.

```dart
pipeline.houghLine(
  width: 256,
  height: 256,
)
```

## Convolution

### conv

Apply a convolution kernel.

```dart
pipeline.conv(kernel: myKernel)
```

### convsep

Apply a separable convolution.

```dart
pipeline.convsep(kernel: myKernel)
```

### compass

Apply a compass convolution.

```dart
pipeline.compass(mask: myMask)
```

## Composite Operations

### composite

Composite multiple images.

```dart
pipeline.composite(
  overlay: overlayImage,
  mode: VipsBlendMode.over,
  x: 100,
  y: 50,
)
```

### insert

Insert an image at a position.

```dart
pipeline.insert(
  image: subImage,
  x: 100,
  y: 100,
)
```

## Morphology

### morph

Apply morphological operations.

```dart
pipeline.morph(mask: myMask, morph: VipsMorph.dilate)
pipeline.morph(mask: myMask, morph: VipsMorph.erode)
```

### rank

Rank filter (median, min, max).

```dart
pipeline.rank(width: 3, height: 3, index: 4)  // Median 3x3
```

## Histogram

### histFind

Find histogram.

```dart
final hist = pipeline.histFind()
```

### histNorm

Normalize histogram.

```dart
pipeline.histNorm()
```

### histEqual

Histogram equalization.

```dart
pipeline.histEqual()
```

## Output Formats

See [Output Formats](./formats) for detailed format options.

```dart
pipeline.toJpeg(quality: 85)
pipeline.toPng(compression: 6)
pipeline.toWebp(quality: 90)
pipeline.toGif()
pipeline.toTiff()
pipeline.toDeepZoom(name: 'pyramid')
```
