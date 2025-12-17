---
sidebar_position: 6
---

# 转换

图像格式和类型转换操作。

## 函数映射

| libvips C | Dart 绑定 | Pipeline 方法 |
|-----------|----------|---------------|
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

## crop / extract_area

从图像中提取矩形区域。

```dart
// (left, top, width, height)
pipeline.crop(100, 100, 400, 300)
```

## smartcrop

自动裁剪到最有趣的区域。

```dart
// (width, height)
pipeline.smartCrop(400, 300)
```

**Interesting 选项：**

- `VipsInteresting.none` - 仅裁剪
- `VipsInteresting.centre` - 从中心裁剪
- `VipsInteresting.attention` - 聚焦有趣区域
- `VipsInteresting.entropy` - 基于熵裁剪

## flip

水平或垂直翻转图像。

```dart
pipeline.flipHorizontal()
pipeline.flipVertical()
```

## autorot

根据 EXIF 方向标签自动旋转。

```dart
pipeline.autoRotate()
```

## embed

将图像嵌入更大的画布。

```dart
apiBindings.embed(input, output, x, y, width, height);
```

## gravity

使用重力方向将图像放置在更大的画布中。

```dart
apiBindings.gravity(input, output, direction, width, height);
```

**方向：** `VipsCompassDirection.centre`, `north`, `south`, `east`, `west` 等。
