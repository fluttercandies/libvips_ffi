---
sidebar_position: 14
---

# Mosaicing

Image stitching and mosaicing operations.

## Function Mapping

| libvips C | Dart Binding | Description |
|-----------|--------------|-------------|
| `vips_merge()` | `mosaicingBindings.merge()` | Merge two images |
| `vips_mosaic()` | `mosaicingBindings.mosaic()` | Mosaic two images |
| `vips_mosaic1()` | `mosaicingBindings.mosaic1()` | First-order mosaic |
| `vips_match()` | `mosaicingBindings.match()` | Match two images |
| `vips_globalbalance()` | `mosaicingBindings.globalbalance()` | Global color balance |

## merge

Merge two images with blending at the join.

```dart
mosaicingBindings.merge(
  ref,        // Reference image
  sec,        // Secondary image
  output,
  VipsDirection.horizontal,  // or .vertical
  dx,         // X offset
  dy,         // Y offset
);
```

## mosaic

Create a mosaic of two images with automatic tie-point matching.

```dart
mosaicingBindings.mosaic(
  ref,        // Reference image
  sec,        // Secondary image
  output,
  VipsDirection.horizontal,
  xref,       // Reference point X in ref
  yref,       // Reference point Y in ref
  xsec,       // Reference point X in sec
  ysec,       // Reference point Y in sec
);
```

## mosaic1

First-order mosaic with rotation and scaling.

```dart
mosaicingBindings.mosaic1(
  ref,
  sec,
  output,
  VipsDirection.horizontal,
  xr1, yr1,   // First tie point in ref
  xs1, ys1,   // First tie point in sec
  xr2, yr2,   // Second tie point in ref
  xs2, ys2,   // Second tie point in sec
);
```

## match

Transform secondary image to match reference.

```dart
mosaicingBindings.match(
  ref,
  sec,
  output,
  xr1, yr1, xs1, ys1,  // First tie point pair
  xr2, yr2, xs2, ys2,  // Second tie point pair
);
```

## globalbalance

Apply global color balance to a mosaic.

```dart
mosaicingBindings.globalbalance(input, output);
```

Adjusts colors across the entire mosaic for consistent appearance.

## Use Cases

### Panorama Stitching

```dart
// Stitch two images horizontally
mosaicingBindings.mosaic(
  leftImage,
  rightImage,
  panorama,
  VipsDirection.horizontal,
  leftImage.width - 100, 300,  // Overlap point in left
  100, 300,                      // Corresponding point in right
);

// Balance colors
mosaicingBindings.globalbalance(panorama, balanced);
```

### Vertical Stitching

```dart
// Stitch two images vertically
mosaicingBindings.merge(
  topImage,
  bottomImage,
  output,
  VipsDirection.vertical,
  0,              // X offset
  topImage.height - 50,  // Y offset (overlap region)
);
```

### Image Registration

```dart
// Match secondary image to reference
mosaicingBindings.match(
  reference,
  toAlign,
  aligned,
  100, 100, 105, 98,   // First tie point pair
  500, 400, 508, 395,  // Second tie point pair
);
```
