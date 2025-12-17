---
sidebar_position: 8
---

# Create

Create new images from scratch.

## Function Mapping

| libvips C | Dart Binding | Description |
|-----------|--------------|-------------|
| `vips_black()` | `createBindings.black()` | Create black image |
| `vips_xyz()` | `createBindings.xyz()` | Create coordinate image |
| `vips_grey()` | `createBindings.grey()` | Create grey ramp |
| `vips_gaussnoise()` | `createBindings.gaussnoise()` | Gaussian noise |
| `vips_text()` | `createBindings.text()` | Render text |
| `vips_gaussmat()` | `createBindings.gaussmat()` | Gaussian kernel |
| `vips_logmat()` | `createBindings.logmat()` | LoG kernel |
| `vips_identity()` | `createBindings.identity()` | Identity LUT |
| `vips_buildlut()` | `createBindings.buildlut()` | Build LUT |
| `vips_invertlut()` | `createBindings.invertlut()` | Invert LUT |
| `vips_tonelut()` | `createBindings.tonelut()` | Tone curve LUT |
| `vips_mask_ideal()` | `createBindings.maskIdeal()` | Ideal filter mask |
| `vips_mask_gaussian()` | `createBindings.maskGaussian()` | Gaussian filter mask |
| `vips_mask_butterworth()` | `createBindings.maskButterworth()` | Butterworth filter |
| `vips_sines()` | `createBindings.sines()` | Sine wave image |
| `vips_zone()` | `createBindings.zone()` | Zone plate |
| `vips_eye()` | `createBindings.eye()` | Eye pattern |
| `vips_perlin()` | `createBindings.perlin()` | Perlin noise |
| `vips_worley()` | `createBindings.worley()` | Worley noise |
| `vips_fractsurf()` | `createBindings.fractsurf()` | Fractal surface |

## black

Create a black image of given dimensions.

```dart
// Create 800x600 black image with 3 bands (RGB)
final image = createBindings.black(800, 600, bands: 3);
```

## xyz

Create an image where pixel values equal coordinates.

```dart
// Create coordinate image
final coords = createBindings.xyz(width, height);
```

## gaussnoise

Create image filled with Gaussian noise.

```dart
final noise = createBindings.gaussnoise(width, height, mean: 128, sigma: 30);
```

## text

Render text to an image.

```dart
final textImage = createBindings.text(
  'Hello World',
  font: 'sans 48',
  width: 400,
  dpi: 72,
);
```

## gaussmat

Create a Gaussian convolution kernel.

```dart
// Create Gaussian kernel with sigma=1.5
final kernel = createBindings.gaussmat(1.5, 0.2);
```

## perlin

Create Perlin noise image.

```dart
final perlin = createBindings.perlin(width, height, cellSize: 256);
```

## worley

Create Worley (cellular) noise image.

```dart
final worley = createBindings.worley(width, height, cellSize: 256);
```
