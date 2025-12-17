---
sidebar_position: 7
---

# Arithmetic

Mathematical operations on images.

## Function Mapping

| libvips C | Dart Binding | Pipeline Method | PipelineSpec |
|-----------|--------------|-----------------|--------------|
| `vips_add()` | `arithmeticBindings.add()` | - | - |
| `vips_subtract()` | `arithmeticBindings.subtract()` | - | - |
| `vips_multiply()` | `arithmeticBindings.multiply()` | - | - |
| `vips_divide()` | `arithmeticBindings.divide()` | - | - |
| `vips_abs()` | `arithmeticBindings.abs()` | `pipeline.abs()` | `spec.abs()` |
| `vips_sign()` | `arithmeticBindings.sign()` | `pipeline.sign()` | `spec.sign()` |
| `vips_min()` | `arithmeticBindings.min()` | - | - |
| `vips_max()` | `arithmeticBindings.max()` | - | - |
| `vips_avg()` | `arithmeticBindings.avg()` | - | - |
| `vips_deviate()` | `arithmeticBindings.deviate()` | - | - |
| `vips_stats()` | `arithmeticBindings.stats()` | - | - |
| `vips_math()` | `arithmeticBindings.math()` | - | - |
| `vips_math2()` | `arithmeticBindings.math2()` | - | - |
| `vips_clamp()` | `arithmeticBindings.clamp()` | `pipeline.clamp()` | - |
| `vips_ceil()` | - | `pipeline.ceil()` | `spec.ceil()` |
| `vips_floor()` | - | `pipeline.floor()` | `spec.floor()` |

## add

Add two images pixel-wise.

```dart
arithmeticBindings.add(image1, image2, output);
```

## subtract

Subtract one image from another.

```dart
arithmeticBindings.subtract(image1, image2, output);
```

## multiply

Multiply two images pixel-wise.

```dart
arithmeticBindings.multiply(image1, image2, output);
```

## divide

Divide one image by another.

```dart
arithmeticBindings.divide(image1, image2, output);
```

## clamp

Clamp pixel values to range 0-1.

```dart
// Pipeline API (clamps to 0-1 range)
pipeline.clamp()
```

## stats

Calculate image statistics (min, max, mean, etc.).

```dart
final statsImage = arithmeticBindings.stats(input);
// Returns a 1-band image with statistics
```

## math

Apply mathematical function to image.

```dart
arithmeticBindings.math(input, output, VipsOperationMath.sin);
```

**Operations:** `sin`, `cos`, `tan`, `asin`, `acos`, `atan`, `log`, `log10`, `exp`, `exp10`
