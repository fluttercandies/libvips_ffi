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
// drawRect(image, ink, n, left, top, width, height)
drawBindings.drawRect(image, inkPtr, 3, 100, 100, 200, 150);

// drawRect1 单值（灰度）
drawBindings.drawRect1(image, 255.0, 100, 100, 200, 150);
```

## drawCircle

绘制圆形。

```dart
// drawCircle(image, ink, n, cx, cy, radius)
drawBindings.drawCircle(image, inkPtr, 3, 200, 200, 50);
```

## drawLine

绘制线条。

```dart
// drawLine(image, ink, n, x1, y1, x2, y2)
drawBindings.drawLine(image, inkPtr, 3, 0, 0, 400, 300);
```

## drawImage

将另一个图像合成到此图像上。

```dart
// drawImage(image, sub, x, y)
drawBindings.drawImage(image, overlayImage, 100, 50);
```

## drawFlood

从一点开始洪水填充。

```dart
// drawFlood(image, ink, n, x, y)
drawBindings.drawFlood(image, inkPtr, 3, 200, 200);
```
