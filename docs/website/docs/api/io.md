---
sidebar_position: 5
---

# I/O

Image loading and saving operations.

## Function Mapping

### Loading

| libvips C | Dart Binding | Pipeline Method |
|-----------|--------------|-----------------|
| `vips_image_new_from_file()` | `apiBindings.imageNewFromFile()` | `VipsPipeline.fromFile()` |
| `vips_image_new_from_buffer()` | `apiBindings.imageNewFromBuffer()` | `VipsPipeline.fromBuffer()` |
| `vips_jpegload()` | `ioBindings.jpegload()` | - |
| `vips_pngload()` | `ioBindings.pngload()` | - |
| `vips_webpload()` | `ioBindings.webpload()` | - |
| `vips_gifload()` | `ioBindings.gifload()` | - |
| `vips_tiffload()` | `ioBindings.tiffload()` | - |
| `vips_heifload()` | `ioBindings.heifload()` | - |

### Saving

| libvips C | Dart Binding | Pipeline Method |
|-----------|--------------|-----------------|
| `vips_image_write_to_file()` | `apiBindings.imageWriteToFile()` | `pipeline.toFile()` |
| `vips_image_write_to_buffer()` | `apiBindings.imageWriteToBuffer()` | `pipeline.toBuffer()` |
| `vips_jpegsave_buffer()` | `ioBindings.jpegsaveBuffer()` | `pipeline.toJpeg()` |
| `vips_pngsave_buffer()` | `ioBindings.pngsaveBuffer()` | `pipeline.toPng()` |
| `vips_webpsave_buffer()` | `ioBindings.webpsaveBuffer()` | `pipeline.toWebp()` |
| `vips_gifsave_buffer()` | `ioBindings.gifsaveBuffer()` | `pipeline.toGif()` |
| `vips_tiffsave_buffer()` | `ioBindings.tiffsaveBuffer()` | `pipeline.toTiff()` |
| `vips_heifsave_buffer()` | `ioBindings.heifsaveBuffer()` | `pipeline.toHeif()` |
| `vips_dzsave()` | `ioBindings.dzsave()` | `pipeline.toDeepZoom()` |

## image_new_from_file

Load an image from file.

### C API

```c
VipsImage *vips_image_new_from_file(const char *name, ...);
```

### Dart Binding

```dart
Pointer<VipsImage> imageNewFromFile(Pointer<Char> name);
```

### Pipeline API

```dart
final pipeline = VipsPipeline.fromFile('/path/to/image.jpg');
```

## image_new_from_buffer

Load an image from memory buffer.

### C API

```c
VipsImage *vips_image_new_from_buffer(const void *buf, size_t len, const char *option_string, ...);
```

### Dart Binding

```dart
Pointer<VipsImage> imageNewFromBuffer(
  Pointer<Void> buf,
  int len,
  Pointer<Char> optionString,
);
```

### Pipeline API

```dart
final bytes = await File('image.jpg').readAsBytes();
final pipeline = VipsPipeline.fromBuffer(bytes);
```

## image_write_to_buffer

Save image to memory buffer.

### C API

```c
int vips_image_write_to_buffer(VipsImage *in, const char *suffix, void **buf, size_t *size, ...);
```

### Dart Binding

```dart
int imageWriteToBuffer(
  Pointer<VipsImage> image,
  Pointer<Char> suffix,
  Pointer<Pointer<Void>> buf,
  Pointer<Size> size,
);
```

### Pipeline API

```dart
final jpegBytes = pipeline.toJpeg(quality: 85);
final pngBytes = pipeline.toPng(compression: 6);
final webpBytes = pipeline.toWebp(quality: 90);
```

## Format-Specific Options

### JPEG

```dart
pipeline.toJpeg(
  quality: 85,        // 1-100
  optimizeCoding: true,
  interlace: false,   // Progressive JPEG
  stripMetadata: true,
);
```

### PNG

```dart
pipeline.toPng(
  compression: 6,     // 0-9
  interlace: false,
  palette: false,     // 8-bit palette mode
);
```

### WebP

```dart
pipeline.toWebp(
  quality: 90,
  lossless: false,
  nearLossless: false,
);
```

### TIFF

```dart
pipeline.toTiff(
  compression: VipsTiffCompression.lzw,
  predictor: VipsTiffPredictor.horizontal,
);
```
