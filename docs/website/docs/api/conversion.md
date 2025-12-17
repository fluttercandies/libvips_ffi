---
sidebar_position: 6
---

# Conversion

Image format and type conversion operations.

## Function Mapping

| libvips C | Dart Binding | Pipeline Method | PipelineSpec |
|-----------|--------------|-----------------|--------------|
| `vips_crop()` | `apiBindings.crop()` | `pipeline.crop()` | `spec.crop()` |
| `vips_extract_area()` | `apiBindings.extractArea()` | - | - |
| `vips_smartcrop()` | `apiBindings.smartcrop()` | `pipeline.smartCrop()` | `spec.smartCrop()` |
| `vips_flip()` | `apiBindings.flip()` | `pipeline.flip()` | `spec.flip()` / `spec.flipHorizontal()` / `spec.flipVertical()` |
| `vips_embed()` | `apiBindings.embed()` | `pipeline.embed()` | `spec.embed()` |
| `vips_gravity()` | `apiBindings.gravity()` | `pipeline.gravity()` | `spec.gravity()` |
| `vips_zoom()` | `apiBindings.zoom()` | `pipeline.zoom()` | `spec.zoom()` |
| `vips_autorot()` | `apiBindings.autorot()` | `pipeline.autoRotate()` | `spec.autoRotate()` |
| `vips_cast()` | `conversionBindings.cast()` | `pipeline.cast()` | `spec.cast()` |
| `vips_bandjoin()` | `conversionBindings.bandjoin()` | - | - |
| `vips_bandmean()` | `conversionBindings.bandmean()` | `pipeline.bandmean()` | `spec.bandmean()` |
| `vips_copy()` | `conversionBindings.copy()` | `pipeline.copy()` | `spec.copy()` |

## crop / extract_area

Extract a rectangular region from an image.

```dart
// Pipeline API (left, top, width, height)
pipeline.crop(100, 100, 400, 300)
```

## smartcrop

Automatically crop to the most interesting region.

```dart
// Pipeline API (width, height)
pipeline.smartCrop(400, 300)
```

**Interesting options:**
- `VipsInteresting.none` - Just crop
- `VipsInteresting.centre` - Crop from centre
- `VipsInteresting.attention` - Focus on interesting areas
- `VipsInteresting.entropy` - Crop based on entropy

## flip

Flip image horizontally or vertically.

```dart
// Pipeline API
pipeline.flipHorizontal()
pipeline.flipVertical()

// Low-level binding
apiBindings.flip(input, output, VipsDirection.horizontal);
apiBindings.flip(input, output, VipsDirection.vertical);
```

## autorot

Auto-rotate based on EXIF orientation tag.

```dart
// Pipeline API
pipeline.autoRotate()

// Low-level binding
apiBindings.autorot(input, output);
```

## embed

Embed an image in a larger canvas.

```dart
// Low-level binding
apiBindings.embed(input, output, x, y, width, height);
```

## gravity

Place image within a larger canvas using gravity direction.

```dart
// Low-level binding
apiBindings.gravity(input, output, direction, width, height);
```

**Directions:** `VipsCompassDirection.centre`, `north`, `south`, `east`, `west`, etc.
