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
// 按比例因子
pipeline.resize(scale: 0.5)  // 50% 大小

// 按宽度（自动计算高度）
pipeline.resize(width: 800)

// 按高度（自动计算宽度）
pipeline.resize(height: 600)

// 同时指定（可能改变宽高比）
pipeline.resize(width: 800, height: 600)
```

## thumbnail_image

创建智能裁剪的缩略图。

```dart
pipeline.thumbnail(
  width: 200,
  height: 200,
  crop: VipsCrop.attention,  // 智能裁剪
)
```

## rotate

按任意角度旋转图像。

```dart
pipeline.rotate(angle: 45)  // 顺时针旋转 45 度
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
