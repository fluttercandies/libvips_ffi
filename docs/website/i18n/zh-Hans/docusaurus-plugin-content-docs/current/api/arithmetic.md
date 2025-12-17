---
sidebar_position: 7
---

# 算术

图像的数学运算。

## 函数映射

| libvips C | Dart 绑定 | Pipeline 方法 |
|-----------|----------|---------------|
| `vips_add()` | `arithmeticBindings.add()` | - |
| `vips_subtract()` | `arithmeticBindings.subtract()` | - |
| `vips_multiply()` | `arithmeticBindings.multiply()` | - |
| `vips_divide()` | `arithmeticBindings.divide()` | - |
| `vips_abs()` | `arithmeticBindings.abs()` | - |
| `vips_min()` | `arithmeticBindings.min()` | - |
| `vips_max()` | `arithmeticBindings.max()` | - |
| `vips_avg()` | `arithmeticBindings.avg()` | - |
| `vips_stats()` | `arithmeticBindings.stats()` | - |
| `vips_clamp()` | `arithmeticBindings.clamp()` | `pipeline.clamp()` |

## add

逐像素相加两个图像。

```dart
arithmeticBindings.add(image1, image2, output);
```

## subtract

从一个图像减去另一个。

```dart
arithmeticBindings.subtract(image1, image2, output);
```

## multiply

逐像素相乘两个图像。

```dart
arithmeticBindings.multiply(image1, image2, output);
```

## divide

一个图像除以另一个。

```dart
arithmeticBindings.divide(image1, image2, output);
```

## clamp

将像素值限制在范围内。

```dart
pipeline.clamp(min: 0, max: 255)
```

## stats

计算图像统计信息（最小、最大、平均等）。

```dart
final statsImage = arithmeticBindings.stats(input);
// 返回包含统计信息的 1 通道图像
```

## math

对图像应用数学函数。

```dart
arithmeticBindings.math(input, output, VipsOperationMath.sin);
```

**操作：** `sin`, `cos`, `tan`, `asin`, `acos`, `atan`, `log`, `log10`, `exp`, `exp10`
