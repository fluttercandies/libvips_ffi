---
sidebar_position: 2
---

# 重采样

缩放和重采样操作。

## 函数映射

| libvips C | Dart 绑定 | Pipeline 方法 |
|-----------|----------|---------------|
| `vips_resize()` | `apiBindings.resize()` | `pipeline.resize()` |
| `vips_thumbnail()` | `apiBindings.thumbnail()` | - |
| `vips_thumbnail_image()` | `apiBindings.thumbnailImage()` | `pipeline.thumbnail()` |
| `vips_thumbnail_buffer()` | `apiBindings.thumbnailBuffer()` | - |
| `vips_reduce()` | `apiBindings.reduce()` | - |
| `vips_shrink()` | `apiBindings.shrink()` | - |
| `vips_rotate()` | `apiBindings.rotate()` | `pipeline.rotate()` |
| `vips_affine()` | `resampleBindings.affine()` | - |
| `vips_similarity()` | `resampleBindings.similarity()` | - |

## resize

按比例因子缩放图像。

```dart
// 按比例因子 (0.5 = 缩小一半, 2.0 = 放大一倍)
pipeline.resize(0.5)
```

## thumbnail_image

创建智能裁剪的缩略图。

```dart
// 创建指定宽度的缩略图
pipeline.thumbnail(200)
```

## rotate

按任意角度旋转图像。

```dart
// 按角度旋转（正值 = 逆时针）
pipeline.rotate(45)
```

## reduce

按收缩因子缩小图像。

```dart
apiBindings.reduce(input, output, hshrink, vshrink);
```

## shrink

缩小图像（快速，质量较低）。

```dart
apiBindings.shrink(input, output, hshrink, vshrink);
```
