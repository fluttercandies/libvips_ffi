---
sidebar_position: 10
---

# Morphology

Morphological operations for image processing.

## Function Mapping

| libvips C | Dart Binding | Pipeline Method | PipelineSpec |
|-----------|--------------|-----------------|--------------|
| `vips_morph()` | `morphologyBindings.morph()` | - | - |
| `vips_rank()` | `morphologyBindings.rank()` | `pipeline.rank()` | `spec.rank()` |
| `vips_median()` | `morphologyBindings.median()` | `pipeline.median()` | `spec.median()` |
| `vips_countlines()` | `morphologyBindings.countlines()` | - | - |
| `vips_labelregions()` | `morphologyBindings.labelregions()` | `pipeline.labelregions()` | `spec.labelregions()` |
| `vips_fill_nearest()` | `morphologyBindings.fillNearest()` | `pipeline.fillNearest()` | `spec.fillNearest()` |

## morph

Apply morphological operation with a structuring element.

```dart
// morph(input, output, mask, morphOp)
morphologyBindings.morph(input, output, mask, VipsMorph.dilate.index);
```

**Operations:**
- `VipsMorph.erode` - Erosion (shrink bright regions)
- `VipsMorph.dilate` - Dilation (expand bright regions)

## rank

Apply rank filter (includes median).

```dart
// Median filter (3x3)
morphologyBindings.rank(input, output, 3, 3, 4);

// Min filter
morphologyBindings.rank(input, output, 3, 3, 0);

// Max filter
morphologyBindings.rank(input, output, 3, 3, 8);
```

Parameters: `(input, output, width, height, index)`
- `index = 0` → min
- `index = (width*height)/2` → median
- `index = width*height-1` → max

## median

Convenience function for median filter.

```dart
morphologyBindings.median(input, output, 3);  // 3x3 median
```

## labelregions

Label connected regions in a binary image.

```dart
// labelregions(input, maskOut)
morphologyBindings.labelregions(input, maskOut);
// Each connected region gets a unique integer label
```

## fillNearest

Fill holes by replacing each pixel with its nearest non-zero neighbour.

```dart
morphologyBindings.fillNearest(input, output);
```
