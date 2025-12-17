---
sidebar_position: 3
---

# 卷积

卷积操作，包括模糊、锐化和边缘检测。

## 函数映射

| libvips C | Dart 绑定 | Pipeline 方法 |
|-----------|----------|---------------|
| `vips_gaussblur()` | `apiBindings.gaussblur()` | `pipeline.gaussianBlur()` |
| `vips_sharpen()` | `apiBindings.sharpen()` | `pipeline.sharpen()` |
| `vips_sobel()` | `apiBindings.sobel()` | - |
| `vips_canny()` | `apiBindings.canny()` | - |
| `vips_conv()` | `convolutionBindings.conv()` | - |
| `vips_conva()` | `convolutionBindings.conva()` | - |
| `vips_convsep()` | `convolutionBindings.convsep()` | - |
| `vips_compass()` | `convolutionBindings.compass()` | - |

## gaussblur

应用高斯模糊。

```dart
pipeline.gaussianBlur(sigma: 2.0)
```

**参数：**

- `sigma` - 高斯标准差（1.5-2.0 轻微模糊，5+ 强烈模糊）

## sharpen

锐化图像。

```dart
pipeline.sharpen()
pipeline.sharpen(sigma: 1.5)  // 自定义 sigma
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
