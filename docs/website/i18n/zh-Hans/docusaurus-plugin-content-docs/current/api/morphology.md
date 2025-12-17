---
sidebar_position: 10
---

# 形态学

图像处理的形态学操作。

## 函数映射

| libvips C | Dart 绑定 | 描述 |
|-----------|----------|------|
| `vips_morph()` | `morphologyBindings.morph()` | 应用形态学操作 |
| `vips_rank()` | `morphologyBindings.rank()` | 排序滤波器 |
| `vips_median()` | `morphologyBindings.median()` | 中值滤波器 |
| `vips_countlines()` | `morphologyBindings.countlines()` | 计数线条 |
| `vips_labelregions()` | `morphologyBindings.labelregions()` | 标记连通区域 |
| `vips_fill_nearest()` | `morphologyBindings.fillNearest()` | 用最近像素填充 |

## morph

使用结构元素应用形态学操作。

```dart
// morph(input, output, mask, morphOp)
morphologyBindings.morph(input, output, mask, VipsMorph.dilate.index);
```

**操作：**

- `VipsMorph.erode` - 腐蚀（收缩亮区域）
- `VipsMorph.dilate` - 膨胀（扩展亮区域）

## rank

应用排序滤波器（包括中值）。

```dart
// 中值滤波器 (3x3)
morphologyBindings.rank(input, output, 3, 3, 4);

// 最小值滤波器
morphologyBindings.rank(input, output, 3, 3, 0);

// 最大值滤波器
morphologyBindings.rank(input, output, 3, 3, 8);
```

参数：`(input, output, width, height, index)`

- `index = 0` → 最小值
- `index = (width*height)/2` → 中值
- `index = width*height-1` → 最大值

## median

中值滤波器便捷函数。

```dart
morphologyBindings.median(input, output, 3);  // 3x3 中值
```

## labelregions

标记二值图像中的连通区域。

```dart
// labelregions(input, maskOut)
morphologyBindings.labelregions(input, maskOut);
// 每个连通区域获得唯一的整数标签
```

## fillNearest

通过用最近的非零邻居替换每个像素来填充空洞。

```dart
morphologyBindings.fillNearest(input, output);
```
