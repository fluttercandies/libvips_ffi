---
sidebar_position: 1
---

# API Reference

This section provides a mapping between [libvips C API](https://www.libvips.org/API/current/function-list.html) and libvips_ffi Dart bindings.

:::warning Third-Party Binding
This is a **third-party** language binding. Not all libvips functions are implemented. The function signatures may differ from the original C API to provide a more idiomatic Dart experience.
:::

## Binding Categories

| Category | Dart Class | Description |
|----------|------------|-------------|
| [Arithmetic](./arithmetic) | `VipsArithmeticBindings` | Math operations (add, subtract, multiply, etc.) |
| [Colour](./colour) | `VipsColourBindings` | Colour space conversions |
| [Conversion](./conversion) | `VipsConversionBindings` | Format and type conversions |
| [Convolution](./convolution) | `VipsConvolutionBindings` | Blur, sharpen, edge detection |
| [Create](./create) | `VipsCreateBindings` | Create images (black, xyz, text, etc.) |
| [Draw](./draw) | `VipsDrawBindings` | Draw on images |
| [Resample](./resample) | `VipsResampleBindings` | Resize, thumbnail, affine |
| [I/O](./io) | `VipsIoBindings` | Load and save images |
| [Morphology](./morphology) | `VipsMorphologyBindings` | Morphological operations |
| [Frequency](./frequency) | `VipsFrequencyBindings` | FFT operations |
| [Relational](./relational) | `VipsRelationalBindings` | Comparison operations |
| [Complex](./complex) | `VipsComplexBindings` | Complex number operations |
| [Mosaicing](./mosaicing) | `VipsMosaicingBindings` | Image stitching |

## Quick Reference Table

### Most Common Functions

| libvips C | Dart Pipeline | Description |
|-----------|---------------|-------------|
| `vips_resize()` | `pipeline.resize()` | Resize by scale factor |
| `vips_thumbnail_image()` | `pipeline.thumbnail()` | Smart thumbnail |
| `vips_crop()` | `pipeline.crop()` | Extract region |
| `vips_smartcrop()` | `pipeline.smartCrop()` | Auto-crop to interesting area |
| `vips_rotate()` | `pipeline.rotate()` | Rotate by angle |
| `vips_flip()` | `pipeline.flipHorizontal()` / `flipVertical()` | Flip image |
| `vips_gaussblur()` | `pipeline.gaussianBlur()` | Gaussian blur |
| `vips_sharpen()` | `pipeline.sharpen()` | Sharpen image |
| `vips_invert()` | `pipeline.invert()` | Invert colours |
| `vips_colourspace()` | `pipeline.colourspace()` | Convert colour space |
| `vips_linear1()` | `pipeline.brightness()` / `contrast()` | Linear adjustment |
| `vips_jpegsave_buffer()` | `pipeline.toJpeg()` | Save as JPEG |
| `vips_pngsave_buffer()` | `pipeline.toPng()` | Save as PNG |
| `vips_webpsave_buffer()` | `pipeline.toWebp()` | Save as WebP |

## Usage Pattern

### C API (libvips)

```c
VipsImage *in, *out;
in = vips_image_new_from_file("input.jpg", NULL);
vips_resize(in, &out, 0.5, NULL);
vips_image_write_to_file(out, "output.jpg", NULL);
g_object_unref(in);
g_object_unref(out);
```

### Dart API (libvips_ffi)

```dart
// High-level Pipeline API (recommended)
final result = VipsPipeline.fromFile('input.jpg')
  .resize(scale: 0.5)
  .toJpeg();
File('output.jpg').writeAsBytesSync(result);

// Low-level bindings (advanced)
final inPtr = apiBindings.imageNewFromFile(namePtr);
apiBindings.resize(inPtr, outPtr, 0.5);
apiBindings.imageWriteToFile(outPtr.value, outputPtr);
```

## Key Differences from C API

1. **NULL Terminators**: Variadic functions in C require NULL terminator. In Dart, this is handled automatically by the binding layer.

2. **Memory Management**: Pipeline API manages memory automatically. Low-level bindings require manual cleanup.

3. **Error Handling**: C returns error codes. Dart throws `VipsApiException`.

4. **Optional Parameters**: C uses variadic args. Dart uses named parameters with defaults.

## Official Documentation

For complete C API documentation, see:
- [libvips API Reference](https://www.libvips.org/API/current/)
- [Function List](https://www.libvips.org/API/current/function-list.html)
