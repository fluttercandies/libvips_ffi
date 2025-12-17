---
sidebar_position: 2
---

# Resample

Resize and resampling operations.

## Function Mapping

| libvips C | Dart Binding | Pipeline Method |
|-----------|--------------|-----------------|
| `vips_resize()` | `apiBindings.resize()` | `pipeline.resize()` |
| `vips_thumbnail()` | `apiBindings.thumbnail()` | - |
| `vips_thumbnail_image()` | `apiBindings.thumbnailImage()` | `pipeline.thumbnail()` |
| `vips_thumbnail_buffer()` | `apiBindings.thumbnailBuffer()` | - |
| `vips_reduce()` | `apiBindings.reduce()` | - |
| `vips_shrink()` | `apiBindings.shrink()` | - |
| `vips_rotate()` | `apiBindings.rotate()` | `pipeline.rotate()` |
| `vips_affine()` | `resampleBindings.affine()` | - |
| `vips_similarity()` | `resampleBindings.similarity()` | - |
| `vips_mapim()` | `resampleBindings.mapim()` | - |
| `vips_quadratic()` | `resampleBindings.quadratic()` | - |

## resize

Resize an image by scale factor.

### C API

```c
int vips_resize(VipsImage *in, VipsImage **out, double scale, ...);
```

### Dart Binding

```dart
int resize(
  Pointer<VipsImage> in1,
  Pointer<Pointer<VipsImage>> out,
  double scale,
);
```

### Pipeline API

```dart
// By scale factor (0.5 = 50% size, 2.0 = double size)
pipeline.resize(0.5)
```

## thumbnail_image

Create a thumbnail with smart cropping.

### C API

```c
int vips_thumbnail_image(VipsImage *in, VipsImage **out, int width, ...);
```

### Dart Binding

```dart
int thumbnailImage(
  Pointer<VipsImage> in1,
  Pointer<Pointer<VipsImage>> out,
  int width,
);
```

### Pipeline API

```dart
// Create thumbnail with target width
pipeline.thumbnail(200)
```

## rotate

Rotate an image by any angle.

### C API

```c
int vips_rotate(VipsImage *in, VipsImage **out, double angle, ...);
```

### Dart Binding

```dart
int rotate(
  Pointer<VipsImage> in1,
  Pointer<Pointer<VipsImage>> out,
  double angle,
);
```

### Pipeline API

```dart
// Rotate by angle in degrees (positive = counter-clockwise)
pipeline.rotate(45)
```

## reduce

Reduce an image by shrink factors.

### C API

```c
int vips_reduce(VipsImage *in, VipsImage **out, double hshrink, double vshrink, ...);
```

### Dart Binding

```dart
int reduce(
  Pointer<VipsImage> in1,
  Pointer<Pointer<VipsImage>> out,
  double hshrink,
  double vshrink,
);
```

## shrink

Shrink an image (fast, lower quality).

### C API

```c
int vips_shrink(VipsImage *in, VipsImage **out, double hshrink, double vshrink, ...);
```

### Dart Binding

```dart
int shrink(
  Pointer<VipsImage> in1,
  Pointer<Pointer<VipsImage>> out,
  double hshrink,
  double vshrink,
);
```
