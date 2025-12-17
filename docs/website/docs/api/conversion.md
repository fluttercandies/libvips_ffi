---
sidebar_position: 6
---

# Conversion

Image format and type conversion operations.

## Function Mapping

| libvips C | Dart Binding | Pipeline Method |
|-----------|--------------|-----------------|
| `vips_crop()` | `apiBindings.crop()` | `pipeline.crop()` |
| `vips_extract_area()` | `apiBindings.extractArea()` | - |
| `vips_smartcrop()` | `apiBindings.smartcrop()` | `pipeline.smartCrop()` |
| `vips_flip()` | `apiBindings.flip()` | `pipeline.flipHorizontal()` / `flipVertical()` |
| `vips_embed()` | `apiBindings.embed()` | - |
| `vips_gravity()` | `apiBindings.gravity()` | - |
| `vips_zoom()` | `apiBindings.zoom()` | - |
| `vips_autorot()` | `apiBindings.autorot()` | `pipeline.autoRotate()` |
| `vips_cast()` | `conversionBindings.cast()` | - |
| `vips_bandjoin()` | `conversionBindings.bandjoin()` | - |
| `vips_bandmean()` | `conversionBindings.bandmean()` | - |
| `vips_copy()` | `conversionBindings.copy()` | - |

## crop / extract_area

Extract a rectangular region from an image.

```dart
// Pipeline API
pipeline.crop(x: 100, y: 100, width: 400, height: 300)

// Low-level binding
apiBindings.crop(input, output, left, top, width, height);
```

## smartcrop

Automatically crop to the most interesting region.

```dart
// Pipeline API
pipeline.smartCrop(
  width: 400,
  height: 300,
  interesting: VipsInteresting.attention,
)

// Low-level binding
apiBindings.smartcrop(input, output, width, height);
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
