---
sidebar_position: 14
---

# 拼接

图像拼接和镶嵌操作。

## 函数映射

| libvips C | Dart 绑定 | 描述 |
|-----------|----------|------|
| `vips_merge()` | `mosaicingBindings.merge()` | 合并两个图像 |
| `vips_mosaic()` | `mosaicingBindings.mosaic()` | 镶嵌两个图像 |
| `vips_mosaic1()` | `mosaicingBindings.mosaic1()` | 一阶镶嵌 |
| `vips_match()` | `mosaicingBindings.match()` | 匹配两个图像 |
| `vips_globalbalance()` | `mosaicingBindings.globalbalance()` | 全局颜色平衡 |

## merge

合并两个图像，在接合处混合。

```dart
mosaicingBindings.merge(
  ref,        // 参考图像
  sec,        // 次级图像
  output,
  VipsDirection.horizontal,  // 或 .vertical
  dx,         // X 偏移
  dy,         // Y 偏移
);
```

## mosaic

使用自动匹配点创建两个图像的镶嵌。

```dart
mosaicingBindings.mosaic(
  ref,        // 参考图像
  sec,        // 次级图像
  output,
  VipsDirection.horizontal,
  xref,       // ref 中的参考点 X
  yref,       // ref 中的参考点 Y
  xsec,       // sec 中的参考点 X
  ysec,       // sec 中的参考点 Y
);
```

## mosaic1

带旋转和缩放的一阶镶嵌。

```dart
mosaicingBindings.mosaic1(
  ref,
  sec,
  output,
  VipsDirection.horizontal,
  xr1, yr1,   // ref 中的第一个匹配点
  xs1, ys1,   // sec 中的第一个匹配点
  xr2, yr2,   // ref 中的第二个匹配点
  xs2, ys2,   // sec 中的第二个匹配点
);
```

## match

变换次级图像以匹配参考图像。

```dart
mosaicingBindings.match(
  ref,
  sec,
  output,
  xr1, yr1, xs1, ys1,  // 第一对匹配点
  xr2, yr2, xs2, ys2,  // 第二对匹配点
);
```

## globalbalance

对镶嵌应用全局颜色平衡。

```dart
mosaicingBindings.globalbalance(input, output);
```

调整整个镶嵌的颜色以获得一致的外观。

## 用例

### 全景拼接

```dart
// 水平拼接两个图像
mosaicingBindings.mosaic(
  leftImage,
  rightImage,
  panorama,
  VipsDirection.horizontal,
  leftImage.width - 100, 300,  // 左图中的重叠点
  100, 300,                      // 右图中的对应点
);

// 平衡颜色
mosaicingBindings.globalbalance(panorama, balanced);
```

### 垂直拼接

```dart
// 垂直拼接两个图像
mosaicingBindings.merge(
  topImage,
  bottomImage,
  output,
  VipsDirection.vertical,
  0,              // X 偏移
  topImage.height - 50,  // Y 偏移（重叠区域）
);
```

### 图像配准

```dart
// 将次级图像匹配到参考图像
mosaicingBindings.match(
  reference,
  toAlign,
  aligned,
  100, 100, 105, 98,   // 第一对匹配点
  500, 400, 508, 395,  // 第二对匹配点
);
```
