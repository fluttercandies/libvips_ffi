---
sidebar_position: 3
---

# 输出格式

libvips_ffi 支持多种输出格式及各种选项。

## JPEG

```dart
pipeline.toJpeg(
  quality: 85,        // 1-100，默认 75
  optimizeCoding: true,
  interlace: false,
  stripMetadata: true,
)
```

**选项：**

- `quality` - 压缩质量 (1-100)
- `optimizeCoding` - 优化霍夫曼编码
- `interlace` - 渐进式 JPEG
- `stripMetadata` - 移除 EXIF 和其他元数据

## PNG

```dart
pipeline.toPng(
  compression: 6,     // 0-9，默认 6
  interlace: false,
  palette: false,     // 使用调色板减小文件
)
```

**选项：**

- `compression` - 压缩级别 (0=快速, 9=最佳)
- `interlace` - Adam7 交错
- `palette` - 转换为 8 位调色板

## WebP

```dart
pipeline.toWebp(
  quality: 90,        // 1-100
  lossless: false,
  nearLossless: false,
  alphaQuality: 100,
)
```

**选项：**

- `quality` - 压缩质量
- `lossless` - 无损压缩
- `nearLossless` - 近无损压缩
- `alphaQuality` - Alpha 通道质量

## GIF

```dart
pipeline.toGif(
  dither: 1.0,        // 抖动量
)
```

## TIFF

```dart
pipeline.toTiff(
  compression: VipsTiffCompression.lzw,
  predictor: VipsTiffPredictor.horizontal,
)
```

**压缩选项：**

- `VipsTiffCompression.none`
- `VipsTiffCompression.jpeg`
- `VipsTiffCompression.deflate`
- `VipsTiffCompression.lzw`

## HEIF/AVIF

```dart
pipeline.toHeif(
  quality: 80,
  lossless: false,
)

pipeline.toAvif(
  quality: 80,
)
```

:::note
HEIF/AVIF 支持取决于 libvips 构建配置。
:::

## DeepZoom (DZI)

为大图像生成 Deep Zoom 金字塔。

```dart
pipeline.toDeepZoom(name: 'output')
```

这将创建：

- `output.dzi` - XML 描述文件
- `output_files/` - 切片目录

## 自动检测格式

```dart
// 从文件扩展名
pipeline.toFile('output.png')  // 保存为 PNG

// 从格式字符串
pipeline.toBuffer(format: 'webp')
```

## 原始字节

```dart
// 获取原始像素数据
final bytes = pipeline.toBytes()
```
