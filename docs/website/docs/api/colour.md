---
sidebar_position: 4
---

# Colour

Colour space conversions and colour operations.

## Function Mapping

| libvips C | Dart Binding | Pipeline Method |
|-----------|--------------|-----------------|
| `vips_colourspace()` | `apiBindings.colourspace()` | `pipeline.colourspace()` |
| `vips_linear1()` | `apiBindings.linear1()` | `pipeline.brightness()` / `contrast()` |
| `vips_invert()` | `apiBindings.invert()` | `pipeline.invert()` |
| `vips_flatten()` | `apiBindings.flatten()` | - |
| `vips_gamma()` | `apiBindings.gamma()` | - |
| `vips_Lab2XYZ()` | `colourBindings.lab2XYZ()` | - |
| `vips_XYZ2Lab()` | `colourBindings.xyz2Lab()` | - |
| `vips_Lab2LCh()` | `colourBindings.lab2LCh()` | - |
| `vips_LCh2Lab()` | `colourBindings.lch2Lab()` | - |
| `vips_sRGB2scRGB()` | `colourBindings.srgb2scrgb()` | - |
| `vips_scRGB2sRGB()` | `colourBindings.scrgb2srgb()` | - |
| `vips_icc_import()` | `colourBindings.iccImport()` | - |
| `vips_icc_export()` | `colourBindings.iccExport()` | - |
| `vips_icc_transform()` | `colourBindings.iccTransform()` | - |

## colourspace

Convert to a target colour space.

### C API

```c
int vips_colourspace(VipsImage *in, VipsImage **out, VipsInterpretation space, ...);
```

### Dart Binding

```dart
int colourspace(
  Pointer<VipsImage> in1,
  Pointer<Pointer<VipsImage>> out,
  int space,  // VipsInterpretation enum value
);
```

### Pipeline API

```dart
pipeline.colourspace(VipsInterpretation.sRGB)
pipeline.colourspace(VipsInterpretation.bw)  // Grayscale
```

**Colour spaces (VipsInterpretation):**
- `VipsInterpretation.sRGB` - Standard RGB
- `VipsInterpretation.bw` - Greyscale
- `VipsInterpretation.lab` - CIE Lab
- `VipsInterpretation.xyz` - CIE XYZ
- `VipsInterpretation.cmyk` - CMYK

## linear1

Apply a linear transformation (brightness/contrast).

### C API

```c
int vips_linear1(VipsImage *in, VipsImage **out, double a, double b, ...);
```

Formula: `out = in * a + b`

### Dart Binding

```dart
int linear1(
  Pointer<VipsImage> in1,
  Pointer<Pointer<VipsImage>> out,
  double a,  // Multiplier (contrast)
  double b,  // Offset (brightness)
);
```

### Pipeline API

```dart
// Brightness adjustment
pipeline.brightness(factor: 1.2)  // 20% brighter

// Contrast adjustment  
pipeline.contrast(factor: 1.2)    // 20% more contrast

// Combined
pipeline.brightness(factor: 1.1).contrast(factor: 1.2)
```

## invert

Invert pixel values (negative image).

### C API

```c
int vips_invert(VipsImage *in, VipsImage **out, ...);
```

### Dart Binding

```dart
int invert(
  Pointer<VipsImage> in1,
  Pointer<Pointer<VipsImage>> out,
);
```

### Pipeline API

```dart
pipeline.invert()
```

## grayscale

Convert to grayscale (convenience method).

### Pipeline API

```dart
pipeline.grayscale()
// Equivalent to:
pipeline.colourspace(VipsInterpretation.bw)
```

## saturation

Adjust colour saturation.

### Pipeline API

```dart
pipeline.saturation(factor: 1.5)  // More saturated
pipeline.saturation(factor: 0.5)  // Less saturated
pipeline.saturation(factor: 0)    // Grayscale
```
