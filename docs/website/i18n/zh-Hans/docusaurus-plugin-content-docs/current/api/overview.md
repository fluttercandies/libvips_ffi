---
sidebar_position: 1
---

# API 参考

本节提供 [libvips C API](https://www.libvips.org/API/current/function-list.html) 与 libvips_ffi Dart 绑定的映射。

:::warning 第三方绑定
这是**第三方**语言绑定。并非所有 libvips 函数都已实现。函数签名可能与原始 C API 不同，以提供更符合 Dart 习惯的体验。
:::

## 绑定分类

| 分类 | Dart 类 | 描述 |
|------|---------|------|
| [算术](./arithmetic) | `VipsArithmeticBindings` | 数学运算 (add, subtract, multiply 等) |
| [颜色](./colour) | `VipsColourBindings` | 色彩空间转换 |
| [转换](./conversion) | `VipsConversionBindings` | 格式和类型转换 |
| [卷积](./convolution) | `VipsConvolutionBindings` | 模糊、锐化、边缘检测 |
| [创建](./create) | `VipsCreateBindings` | 创建图像 (black, xyz, text 等) |
| [绘制](./draw) | `VipsDrawBindings` | 在图像上绘制 |
| [重采样](./resample) | `VipsResampleBindings` | 缩放、缩略图、仿射变换 |
| [输入输出](./io) | `VipsIoBindings` | 加载和保存图像 |
| [形态学](./morphology) | `VipsMorphologyBindings` | 形态学操作 |
| [频率](./frequency) | `VipsFrequencyBindings` | FFT 操作 |
| [关系](./relational) | `VipsRelationalBindings` | 比较操作 |
| [复数](./complex) | `VipsComplexBindings` | 复数操作 |
| [拼接](./mosaicing) | `VipsMosaicingBindings` | 图像拼接 |

## 快速参考表

### 最常用函数

| libvips C | Dart Pipeline | 描述 |
|-----------|---------------|------|
| `vips_resize()` | `pipeline.resize()` | 按比例缩放 |
| `vips_thumbnail_image()` | `pipeline.thumbnail()` | 智能缩略图 |
| `vips_crop()` | `pipeline.crop()` | 提取区域 |
| `vips_smartcrop()` | `pipeline.smartCrop()` | 自动裁剪到有趣区域 |
| `vips_rotate()` | `pipeline.rotate()` | 按角度旋转 |
| `vips_flip()` | `pipeline.flipHorizontal()` / `flipVertical()` | 翻转图像 |
| `vips_gaussblur()` | `pipeline.gaussianBlur()` | 高斯模糊 |
| `vips_sharpen()` | `pipeline.sharpen()` | 锐化图像 |
| `vips_invert()` | `pipeline.invert()` | 反转颜色 |
| `vips_colourspace()` | `pipeline.colourspace()` | 转换色彩空间 |
| `vips_linear1()` | `pipeline.brightness()` / `contrast()` | 线性调整 |
| `vips_jpegsave_buffer()` | `pipeline.toJpeg()` | 保存为 JPEG |
| `vips_pngsave_buffer()` | `pipeline.toPng()` | 保存为 PNG |
| `vips_webpsave_buffer()` | `pipeline.toWebp()` | 保存为 WebP |

## 使用模式

### C API (libvips)

```c
VipsImage *in, *out;
in = vips_image_new_from_file("input.jpg", NULL);
vips_resize(in, &out, 0.5, NULL);
vips_image_write_to_file(out, "output.jpg", NULL);
g_object_unref(in);
g_object_unref(out);
```

### Dart API (libvips_ffi)

```dart
// 高级 Pipeline API（推荐）
final result = VipsPipeline.fromFile('input.jpg')
  .resize(scale: 0.5)
  .toJpeg();
File('output.jpg').writeAsBytesSync(result);

// 底层绑定（高级用法）
final inPtr = apiBindings.imageNewFromFile(namePtr);
apiBindings.resize(inPtr, outPtr, 0.5);
apiBindings.imageWriteToFile(outPtr.value, outputPtr);
```

## 与 C API 的主要区别

1. **NULL 终止符**：C 中的可变参数函数需要 NULL 终止符。在 Dart 中，绑定层自动处理。

2. **内存管理**：Pipeline API 自动管理内存。底层绑定需要手动清理。

3. **错误处理**：C 返回错误码。Dart 抛出 `VipsApiException`。

4. **可选参数**：C 使用可变参数。Dart 使用带默认值的命名参数。

## 官方文档

完整的 C API 文档请参见：

- [libvips API 参考](https://www.libvips.org/API/current/)
- [函数列表](https://www.libvips.org/API/current/function-list.html)
