---
sidebar_position: 9
---

# Draw

Draw shapes and lines on images.

:::note
Draw operations modify the image in-place. Make a copy first if you need to preserve the original.
:::

## Function Mapping

| libvips C | Dart Binding | Description |
|-----------|--------------|-------------|
| `vips_draw_rect()` | `drawBindings.drawRect()` | Draw rectangle |
| `vips_draw_rect1()` | `drawBindings.drawRect1()` | Draw rectangle (single value) |
| `vips_draw_circle()` | `drawBindings.drawCircle()` | Draw circle |
| `vips_draw_circle1()` | `drawBindings.drawCircle1()` | Draw circle (single value) |
| `vips_draw_line()` | `drawBindings.drawLine()` | Draw line |
| `vips_draw_line1()` | `drawBindings.drawLine1()` | Draw line (single value) |
| `vips_draw_mask()` | `drawBindings.drawMask()` | Draw with mask |
| `vips_draw_mask1()` | `drawBindings.drawMask1()` | Draw with mask (single value) |
| `vips_draw_image()` | `drawBindings.drawImage()` | Composite image |
| `vips_draw_flood()` | `drawBindings.drawFlood()` | Flood fill |
| `vips_draw_flood1()` | `drawBindings.drawFlood1()` | Flood fill (single value) |
| `vips_draw_smudge()` | `drawBindings.drawSmudge()` | Smudge region |

## drawRect

Draw a filled rectangle.

```dart
drawBindings.drawRect(
  image,
  ink: [255, 0, 0],  // Red
  left: 100,
  top: 100,
  width: 200,
  height: 150,
  fill: true,
);
```

## drawCircle

Draw a circle.

```dart
drawBindings.drawCircle(
  image,
  ink: [0, 255, 0],  // Green
  cx: 200,
  cy: 200,
  radius: 50,
  fill: true,
);
```

## drawLine

Draw a line.

```dart
drawBindings.drawLine(
  image,
  ink: [0, 0, 255],  // Blue
  x1: 0,
  y1: 0,
  x2: 400,
  y2: 300,
);
```

## drawImage

Composite another image onto this one.

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

Flood fill from a point.

```dart
drawBindings.drawFlood(
  image,
  ink: [255, 255, 0],  // Yellow
  x: 200,
  y: 200,
);
```
