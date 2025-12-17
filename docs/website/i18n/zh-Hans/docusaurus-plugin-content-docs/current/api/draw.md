---
sidebar_position: 9
---

# 绘制

在图像上绘制形状和线条。

:::note
绘制操作会就地修改图像。如需保留原图，请先复制。
:::

## 函数映射

| libvips C | Dart 绑定 | 描述 |
|-----------|----------|------|
| `vips_draw_rect()` | `drawBindings.drawRect()` | 绘制矩形 |
| `vips_draw_circle()` | `drawBindings.drawCircle()` | 绘制圆形 |
| `vips_draw_line()` | `drawBindings.drawLine()` | 绘制线条 |
| `vips_draw_mask()` | `drawBindings.drawMask()` | 使用遮罩绘制 |
| `vips_draw_image()` | `drawBindings.drawImage()` | 合成图像 |
| `vips_draw_flood()` | `drawBindings.drawFlood()` | 洪水填充 |
| `vips_draw_smudge()` | `drawBindings.drawSmudge()` | 涂抹区域 |

## drawRect

绘制填充矩形。

```dart
drawBindings.drawRect(
  image,
  ink: [255, 0, 0],  // 红色
  left: 100,
  top: 100,
  width: 200,
  height: 150,
  fill: true,
);
```

## drawCircle

绘制圆形。

```dart
drawBindings.drawCircle(
  image,
  ink: [0, 255, 0],  // 绿色
  cx: 200,
  cy: 200,
  radius: 50,
  fill: true,
);
```

## drawLine

绘制线条。

```dart
drawBindings.drawLine(
  image,
  ink: [0, 0, 255],  // 蓝色
  x1: 0,
  y1: 0,
  x2: 400,
  y2: 300,
);
```

## drawImage

将另一个图像合成到此图像上。

```dart
drawBindings.drawImage(
  image,
  sub: overlayImage,
  x: 100,
  y: 50,
  mode: VipsCombineMode.set,
);
```

## drawFlood

从一点开始洪水填充。

```dart
drawBindings.drawFlood(
  image,
  ink: [255, 255, 0],  // 黄色
  x: 200,
  y: 200,
);
```
