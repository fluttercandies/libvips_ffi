---
sidebar_position: 4
---

# 颜色

色彩空间转换和颜色操作。

## 函数映射

| libvips C | Dart 绑定 | Pipeline 方法 |
|-----------|----------|---------------|
| `vips_colourspace()` | `apiBindings.colourspace()` | `pipeline.colourspace()` |
| `vips_linear1()` | `apiBindings.linear1()` | `pipeline.brightness()` / `contrast()` |
| `vips_invert()` | `apiBindings.invert()` | `pipeline.invert()` |
| `vips_flatten()` | `apiBindings.flatten()` | - |
| `vips_gamma()` | `apiBindings.gamma()` | - |
| `vips_Lab2XYZ()` | `colourBindings.lab2XYZ()` | - |
| `vips_XYZ2Lab()` | `colourBindings.xyz2Lab()` | - |
| `vips_icc_import()` | `colourBindings.iccImport()` | - |
| `vips_icc_export()` | `colourBindings.iccExport()` | - |

## colourspace

转换到目标色彩空间。

```dart
pipeline.colourspace(VipsInterpretation.sRGB)
pipeline.colourspace(VipsInterpretation.bw)  // 灰度
```

**色彩空间 (VipsInterpretation)：**

- `VipsInterpretation.sRGB` - 标准 RGB
- `VipsInterpretation.bw` - 灰度
- `VipsInterpretation.lab` - CIE Lab
- `VipsInterpretation.xyz` - CIE XYZ
- `VipsInterpretation.cmyk` - CMYK

## linear1

应用线性变换（亮度/对比度）。

公式：`out = in * a + b`

```dart
// 亮度调整 (>1.0 = 更亮)
pipeline.brightness(1.2)

// 对比度调整 (>1.0 = 更高对比度)
pipeline.contrast(1.2)
```

## invert

反转像素值（负片效果）。

```dart
pipeline.invert()
```

## grayscale

转换为灰度（便捷方法）。

```dart
pipeline.grayscale()
// 等同于：
pipeline.colourspace(VipsInterpretation.bw)
```

