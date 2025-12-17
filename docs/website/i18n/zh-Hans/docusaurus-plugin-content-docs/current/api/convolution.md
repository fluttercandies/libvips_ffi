---
sidebar_position: 3
---

# 卷积

卷积操作，包括模糊、锐化和边缘检测。

## 函数映射

| libvips C | Dart 绑定 | Pipeline 方法 | PipelineSpec |
|-----------|----------|---------------|--------------|
| `vips_gaussblur()` | `apiBindings.gaussblur()` | `pipeline.blur()` | `spec.blur()` |
| `vips_sharpen()` | `apiBindings.sharpen()` | `pipeline.sharpen()` | `spec.sharpen()` |
| `vips_sobel()` | `apiBindings.sobel()` | `pipeline.sobel()` | `spec.sobel()` |
| `vips_canny()` | `apiBindings.canny()` | `pipeline.canny()` | `spec.canny()` |
| `vips_conv()` | `convolutionBindings.conv()` | - | - |
| `vips_conva()` | `convolutionBindings.conva()` | - | - |
| `vips_convsep()` | `convolutionBindings.convsep()` | - | - |
| `vips_compass()` | `convolutionBindings.compass()` | - | - |

## gaussblur

应用高斯模糊。

```dart
// 高斯模糊（sigma 越大越模糊）
pipeline.blur(2.0)
// 或
pipeline.gaussianBlur(2.0)
```

**参数：**

- `sigma` - 高斯标准差（1.5-2.0 轻微模糊，5+ 强烈模糊）

## sharpen

锐化图像。

```dart
pipeline.sharpen()
```

## sobel

Sobel 边缘检测。

```dart
apiBindings.sobel(input, output);
```

## canny

Canny 边缘检测。

```dart
apiBindings.canny(input, output);
```

## conv

使用卷积核进行通用卷积。

```dart
convolutionBindings.conv(input, output, mask);
```
