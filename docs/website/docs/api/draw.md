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
// drawRect(image, ink, n, left, top, width, height)
// ink: pointer to double array, n: number of values
drawBindings.drawRect(image, inkPtr, 3, 100, 100, 200, 150);

// drawRect1 for single value (grayscale)
drawBindings.drawRect1(image, 255.0, 100, 100, 200, 150);
```

## drawCircle

Draw a circle.

```dart
// drawCircle(image, ink, n, cx, cy, radius)
drawBindings.drawCircle(image, inkPtr, 3, 200, 200, 50);

// drawCircle1 for single value
drawBindings.drawCircle1(image, 255.0, 200, 200, 50);
```

## drawLine

Draw a line.

```dart
// drawLine(image, ink, n, x1, y1, x2, y2)
drawBindings.drawLine(image, inkPtr, 3, 0, 0, 400, 300);

// drawLine1 for single value
drawBindings.drawLine1(image, 255.0, 0, 0, 400, 300);
```

## drawImage

Composite another image onto this one.

```dart
// drawImage(image, sub, x, y)
drawBindings.drawImage(image, overlayImage, 100, 50);
```

## drawFlood

Flood fill from a point.

```dart
// drawFlood(image, ink, n, x, y)
drawBindings.drawFlood(image, inkPtr, 3, 200, 200);

// drawFlood1 for single value
drawBindings.drawFlood1(image, 255.0, 200, 200);
```
