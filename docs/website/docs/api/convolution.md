---
sidebar_position: 3
---

# Convolution

Convolution operations including blur, sharpen, and edge detection.

## Function Mapping

| libvips C | Dart Binding | Pipeline Method |
|-----------|--------------|-----------------|
| `vips_gaussblur()` | `apiBindings.gaussblur()` | `pipeline.gaussianBlur()` |
| `vips_sharpen()` | `apiBindings.sharpen()` | `pipeline.sharpen()` |
| `vips_sobel()` | `apiBindings.sobel()` | - |
| `vips_canny()` | `apiBindings.canny()` | - |
| `vips_conv()` | `convolutionBindings.conv()` | - |
| `vips_conva()` | `convolutionBindings.conva()` | - |
| `vips_convsep()` | `convolutionBindings.convsep()` | - |
| `vips_compass()` | `convolutionBindings.compass()` | - |

## gaussblur

Apply Gaussian blur.

### C API

```c
int vips_gaussblur(VipsImage *in, VipsImage **out, double sigma, ...);
```

### Dart Binding

```dart
int gaussblur(
  Pointer<VipsImage> in1,
  Pointer<Pointer<VipsImage>> out,
  double sigma,
);
```

### Pipeline API

```dart
// Gaussian blur with sigma (higher = more blur)
pipeline.blur(2.0)
// or
pipeline.gaussianBlur(2.0)
```

**Parameters:**
- `sigma` - Standard deviation of Gaussian (1.5-2.0 for light blur, 5+ for strong blur)

## sharpen

Sharpen an image.

### C API

```c
int vips_sharpen(VipsImage *in, VipsImage **out, ...);
```

### Dart Binding

```dart
int sharpen(
  Pointer<VipsImage> in1,
  Pointer<Pointer<VipsImage>> out,
);
```

### Pipeline API

```dart
pipeline.sharpen()
```

## sobel

Sobel edge detection.

### C API

```c
int vips_sobel(VipsImage *in, VipsImage **out, ...);
```

### Dart Binding

```dart
int sobel(
  Pointer<VipsImage> in1,
  Pointer<Pointer<VipsImage>> out,
);
```

## canny

Canny edge detection.

### C API

```c
int vips_canny(VipsImage *in, VipsImage **out, ...);
```

### Dart Binding

```dart
int canny(
  Pointer<VipsImage> in1,
  Pointer<Pointer<VipsImage>> out,
);
```

## conv

General convolution with a kernel.

### C API

```c
int vips_conv(VipsImage *in, VipsImage **out, VipsImage *mask, ...);
```

### Dart Binding

```dart
int conv(
  Pointer<VipsImage> in1,
  Pointer<Pointer<VipsImage>> out,
  Pointer<VipsImage> mask,
);
```

**Example - Custom blur kernel:**

```dart
// Create a 3x3 blur kernel
final kernel = createBindings.black(3, 3);
// Set kernel values...
convolutionBindings.conv(input, output, kernel);
```
