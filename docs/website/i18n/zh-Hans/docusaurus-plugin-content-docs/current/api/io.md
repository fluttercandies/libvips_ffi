---
sidebar_position: 5
---

# 输入输出

图像加载和保存操作。

## 函数映射

### 加载

| libvips C | Dart 绑定 | Pipeline 方法 |
|-----------|----------|---------------|
| `vips_image_new_from_file()` | `apiBindings.imageNewFromFile()` | `VipsPipeline.fromFile()` |
| `vips_image_new_from_buffer()` | `apiBindings.imageNewFromBuffer()` | `VipsPipeline.fromBuffer()` |
| `vips_jpegload()` | `ioBindings.jpegload()` | - |
| `vips_pngload()` | `ioBindings.pngload()` | - |
| `vips_webpload()` | `ioBindings.webpload()` | - |

### 保存

| libvips C | Dart 绑定 | Pipeline 方法 |
|-----------|----------|---------------|
| `vips_image_write_to_file()` | `apiBindings.imageWriteToFile()` | `pipeline.toFile()` |
| `vips_image_write_to_buffer()` | `apiBindings.imageWriteToBuffer()` | `pipeline.toBuffer()` |
| `vips_jpegsave_buffer()` | `ioBindings.jpegsaveBuffer()` | `pipeline.toJpeg()` |
| `vips_pngsave_buffer()` | `ioBindings.pngsaveBuffer()` | `pipeline.toPng()` |
| `vips_webpsave_buffer()` | `ioBindings.webpsaveBuffer()` | `pipeline.toWebp()` |
| `vips_dzsave()` | `ioBindings.dzsave()` | `pipeline.toDeepZoom()` |

## image_new_from_file

从文件加载图像。

```dart
final pipeline = VipsPipeline.fromFile('/path/to/image.jpg');
```

## image_new_from_buffer

从内存缓冲区加载图像。

```dart
final bytes = await File('image.jpg').readAsBytes();
final pipeline = VipsPipeline.fromBuffer(bytes);
```

## image_write_to_buffer

将图像保存到内存缓冲区。

```dart
final jpegBytes = pipeline.toJpeg(quality: 85);
final pngBytes = pipeline.toPng(compression: 6);
final webpBytes = pipeline.toWebp(quality: 90);
```

## 格式特定选项

### JPEG

```dart
pipeline.toJpeg(
  quality: 85,        // 1-100
  optimizeCoding: true,
  interlace: false,   // 渐进式 JPEG
  stripMetadata: true,
);
```

### PNG

```dart
pipeline.toPng(
  compression: 6,     // 0-9
  interlace: false,
  palette: false,     // 8 位调色板模式
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
