---
sidebar_position: 8
---

# 创建

从头创建新图像。

## 函数映射

| libvips C | Dart 绑定 | 描述 |
|-----------|----------|------|
| `vips_black()` | `createBindings.black()` | 创建黑色图像 |
| `vips_xyz()` | `createBindings.xyz()` | 创建坐标图像 |
| `vips_grey()` | `createBindings.grey()` | 创建灰度渐变 |
| `vips_gaussnoise()` | `createBindings.gaussnoise()` | 高斯噪声 |
| `vips_text()` | `createBindings.text()` | 渲染文本 |
| `vips_gaussmat()` | `createBindings.gaussmat()` | 高斯核 |
| `vips_logmat()` | `createBindings.logmat()` | LoG 核 |
| `vips_perlin()` | `createBindings.perlin()` | Perlin 噪声 |
| `vips_worley()` | `createBindings.worley()` | Worley 噪声 |

## black

创建给定尺寸的黑色图像。

```dart
// 创建 800x600 黑色图像，3 通道 (RGB)
final image = createBindings.black(800, 600, bands: 3);
```

## xyz

创建像素值等于坐标的图像。

```dart
final coords = createBindings.xyz(width, height);
```

## gaussnoise

创建填充高斯噪声的图像。

```dart
final noise = createBindings.gaussnoise(width, height, mean: 128, sigma: 30);
```

## text

将文本渲染为图像。

```dart
final textImage = createBindings.text(
  'Hello World',
  font: 'sans 48',
  width: 400,
  dpi: 72,
);
```

## gaussmat

创建高斯卷积核。

```dart
// 创建 sigma=1.5 的高斯核
final kernel = createBindings.gaussmat(1.5, 0.2);
```

## perlin

创建 Perlin 噪声图像。

```dart
final perlin = createBindings.perlin(width, height, cellSize: 256);
```

## worley

创建 Worley（细胞）噪声图像。

```dart
final worley = createBindings.worley(width, height, cellSize: 256);
```
