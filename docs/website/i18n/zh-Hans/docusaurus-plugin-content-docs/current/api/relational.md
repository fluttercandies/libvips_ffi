---
sidebar_position: 12
---

# 关系

图像的比较和关系操作。

## 函数映射

| libvips C | Dart 绑定 | 描述 |
|-----------|----------|------|
| `vips_relational()` | `relationalBindings.relational()` | 通用关系操作 |
| `vips_equal()` | `relationalBindings.equal()` | 测试相等 |
| `vips_notequal()` | `relationalBindings.notequal()` | 测试不等 |
| `vips_less()` | `relationalBindings.less()` | 测试小于 |
| `vips_lesseq()` | `relationalBindings.lesseq()` | 测试小于等于 |
| `vips_more()` | `relationalBindings.more()` | 测试大于 |
| `vips_moreeq()` | `relationalBindings.moreeq()` | 测试大于等于 |
| `vips_boolean()` | `relationalBindings.boolean()` | 布尔操作 |
| `vips_andimage()` | `relationalBindings.andimage()` | 按位与 |
| `vips_orimage()` | `relationalBindings.orimage()` | 按位或 |
| `vips_eorimage()` | `relationalBindings.eorimage()` | 按位异或 |

## relational

两个图像之间的通用关系比较。

```dart
relationalBindings.relational(image1, image2, output, VipsOperationRelational.equal);
```

**操作 (VipsOperationRelational):**

- `equal` - 测试相等
- `notequal` - 测试不等
- `less` - 测试小于
- `lesseq` - 测试小于等于
- `more` - 测试大于
- `moreeq` - 测试大于等于

## equal / notequal

测试逐像素相等。

```dart
relationalBindings.equal(image1, image2, output);
relationalBindings.notequal(image1, image2, output);
```

结果：条件为真时为 255，为假时为 0。

## less / lesseq / more / moreeq

逐像素比较。

```dart
relationalBindings.less(image1, image2, output);     // image1 < image2
relationalBindings.lesseq(image1, image2, output);   // image1 <= image2
relationalBindings.more(image1, image2, output);     // image1 > image2
relationalBindings.moreeq(image1, image2, output);   // image1 >= image2
```

## boolean

按位布尔操作。

```dart
relationalBindings.andimage(image1, image2, output);  // 按位与
relationalBindings.orimage(image1, image2, output);   // 按位或
relationalBindings.eorimage(image1, image2, output);  // 按位异或
```

## 用例

### 阈值化

```dart
// 创建像素 > 128 的二值掩码
relationalBindings.moreConst(image, mask, 128);
```

### 图像遮罩

```dart
// 应用遮罩：保留掩码为 255 的像素
relationalBindings.andimage(image, mask, output);
```

### 差异检测

```dart
// 找出两个图像之间不同的像素
relationalBindings.notequal(image1, image2, diff);
```
