---
sidebar_position: 12
---

# Relational

Comparison and relational operations on images.

## Function Mapping

| libvips C | Dart Binding | Description |
|-----------|--------------|-------------|
| `vips_relational()` | `relationalBindings.relational()` | General relational operation |
| `vips_equal()` | `relationalBindings.equal()` | Test equality |
| `vips_notequal()` | `relationalBindings.notequal()` | Test inequality |
| `vips_less()` | `relationalBindings.less()` | Test less than |
| `vips_lesseq()` | `relationalBindings.lesseq()` | Test less than or equal |
| `vips_more()` | `relationalBindings.more()` | Test greater than |
| `vips_moreeq()` | `relationalBindings.moreeq()` | Test greater than or equal |
| `vips_relational_const()` | `relationalBindings.relationalConst()` | Compare with constant |
| `vips_equal_const()` | `relationalBindings.equalConst()` | Test equality with constant |
| `vips_boolean()` | `relationalBindings.boolean()` | Boolean operation |
| `vips_andimage()` | `relationalBindings.andimage()` | Bitwise AND |
| `vips_orimage()` | `relationalBindings.orimage()` | Bitwise OR |
| `vips_eorimage()` | `relationalBindings.eorimage()` | Bitwise XOR |

## relational

General relational comparison between two images.

```dart
relationalBindings.relational(image1, image2, output, VipsOperationRelational.equal);
```

**Operations (VipsOperationRelational):**

- `equal` - Test equality
- `notequal` - Test inequality
- `less` - Test less than
- `lesseq` - Test less than or equal
- `more` - Test greater than
- `moreeq` - Test greater than or equal

## equal / notequal

Test pixel-wise equality.

```dart
// Compare two images
relationalBindings.equal(image1, image2, output);
relationalBindings.notequal(image1, image2, output);
```

Result: 255 where condition is true, 0 where false.

## less / lesseq / more / moreeq

Pixel-wise comparison.

```dart
relationalBindings.less(image1, image2, output);     // image1 < image2
relationalBindings.lesseq(image1, image2, output);   // image1 <= image2
relationalBindings.more(image1, image2, output);     // image1 > image2
relationalBindings.moreeq(image1, image2, output);   // image1 >= image2
```

## relational_const

Compare image with a constant value.

```dart
relationalBindings.equalConst(image, output, 128);   // pixels == 128
relationalBindings.moreConst(image, output, 128);    // pixels > 128
```

## boolean

Bitwise boolean operations.

```dart
relationalBindings.andimage(image1, image2, output);  // Bitwise AND
relationalBindings.orimage(image1, image2, output);   // Bitwise OR
relationalBindings.eorimage(image1, image2, output);  // Bitwise XOR
```

## Use Cases

### Thresholding

```dart
// Create binary mask where pixels > 128
relationalBindings.moreConst(image, mask, 128);
```

### Image Masking

```dart
// Apply mask: keep pixels where mask is 255
relationalBindings.andimage(image, mask, output);
```

### Difference Detection

```dart
// Find pixels that differ between two images
relationalBindings.notequal(image1, image2, diff);
```
