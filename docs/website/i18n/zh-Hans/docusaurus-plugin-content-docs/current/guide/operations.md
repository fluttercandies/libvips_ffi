---
sidebar_position: 2
---

# 操作参考

libvips_ffi 中所有可用图像操作的完整参考。

## 缩放与几何变换

### resize

按宽度、高度或缩放因子调整图像大小。

```dart
pipeline.resize(width: 800)              // 按宽度
pipeline.resize(height: 600)             // 按高度
pipeline.resize(width: 800, height: 600) // 两者（可能改变宽高比）
pipeline.resize(scale: 0.5)              // 按缩放因子
```

### thumbnail

创建智能裁剪的缩略图。

```dart
pipeline.thumbnail(
  width: 200,
  height: 200,
  crop: VipsCrop.attention,  // 智能裁剪聚焦有趣区域
)
```

**裁剪选项：**

- `VipsCrop.none` - 不裁剪
- `VipsCrop.centre` - 从中心裁剪
- `VipsCrop.attention` - 聚焦有趣区域
- `VipsCrop.entropy` - 基于熵裁剪
- `VipsCrop.low` - 从顶部/左侧裁剪
- `VipsCrop.high` - 从底部/右侧裁剪

### crop

提取矩形区域。

```dart
pipeline.crop(x: 100, y: 100, width: 400, height: 300)
```

### smartCrop

自动裁剪到最有趣的区域。

```dart
pipeline.smartCrop(
  width: 400,
  height: 300,
  interesting: VipsInteresting.attention,
)
```

### rotate

按特定角度旋转图像。

```dart
pipeline.rotate(angle: 90)   // 顺时针旋转 90 度
pipeline.rotate(angle: -45)  // 逆时针旋转 45 度
```

### autoRotate

根据 EXIF 方向数据自动旋转。

```dart
pipeline.autoRotate()
```

### flip

水平或垂直翻转图像。

```dart
pipeline.flipHorizontal()
pipeline.flipVertical()
```

## 颜色调整

### brightness

调整图像亮度。

```dart
pipeline.brightness(factor: 1.2)  // 增加 20% 亮度
pipeline.brightness(factor: 0.8)  // 降低 20% 亮度
```

### contrast

调整图像对比度。

```dart
pipeline.contrast(factor: 1.2)  // 增加 20% 对比度
pipeline.contrast(factor: 0.8)  // 降低 20% 对比度
```

### saturation

调整颜色饱和度。

```dart
pipeline.saturation(factor: 1.5)  // 更饱和
pipeline.saturation(factor: 0.5)  // 更不饱和
```

### grayscale

转换为灰度。

```dart
pipeline.grayscale()
```

### invert

反转颜色（负片）。

```dart
pipeline.invert()
```

## 滤镜与效果

### gaussianBlur

应用高斯模糊。

```dart
pipeline.gaussianBlur(sigma: 2.0)  // sigma=2 的模糊
```

### sharpen

锐化图像。

```dart
pipeline.sharpen()
pipeline.sharpen(sigma: 1.5)  // 自定义 sigma
```

### clamp

将像素值限制在范围内。

```dart
pipeline.clamp(min: 0, max: 255)
```

### houghCircle

使用霍夫变换检测圆。

```dart
pipeline.houghCircle(
  scale: 3,
  minRadius: 10,
  maxRadius: 100,
)
```

### houghLine

使用霍夫变换检测线。

```dart
pipeline.houghLine(
  width: 256,
  height: 256,
)
```

## 输出格式

详见 [输出格式](./formats)。

```dart
pipeline.toJpeg(quality: 85)
pipeline.toPng(compression: 6)
pipeline.toWebp(quality: 90)
pipeline.toGif()
pipeline.toTiff()
pipeline.toDeepZoom(name: 'pyramid')
```
