---
sidebar_position: 11
---

# 频率

FFT（快速傅里叶变换）和频域操作。

## 函数映射

| libvips C | Dart 绑定 | 描述 |
|-----------|----------|------|
| `vips_fwfft()` | `frequencyBindings.fwfft()` | 正向 FFT |
| `vips_invfft()` | `frequencyBindings.invfft()` | 逆向 FFT |
| `vips_freqmult()` | `frequencyBindings.freqmult()` | 频域乘法 |
| `vips_spectrum()` | `frequencyBindings.spectrum()` | 计算功率谱 |
| `vips_phasecor()` | `frequencyBindings.phasecor()` | 相位相关 |

## fwfft

正向快速傅里叶变换。

```dart
frequencyBindings.fwfft(input, output);
```

将图像从空间域转换到频域。

## invfft

逆向快速傅里叶变换。

```dart
frequencyBindings.invfft(input, output);
```

将图像从频域转换回空间域。

## freqmult

用频域滤波器乘以图像。

```dart
frequencyBindings.freqmult(input, mask, output);
```

**示例 - 低通滤波器：**

```dart
// 创建低通滤波器掩码
final mask = createBindings.maskIdeal(width, height, frequencyCutoff: 0.5);
frequencyBindings.fwfft(input, fft);
frequencyBindings.freqmult(fft, mask, filtered);
frequencyBindings.invfft(filtered, output);
```

## spectrum

计算功率谱。

```dart
frequencyBindings.spectrum(input, output);
```

返回图像的功率谱，用于频率分析。

## phasecor

两个图像之间的相位相关。

```dart
frequencyBindings.phasecor(image1, image2, output);
```

用于图像配准和运动估计。

## 滤波器掩码

创建频域滤波器掩码：

```dart
// 理想滤波器（锐利截止）
createBindings.maskIdeal(width, height, frequencyCutoff: 0.5, reject: false);

// 高斯滤波器（平滑截止）
createBindings.maskGaussian(width, height, frequencyCutoff: 0.5, amplitude: 1.0);

// 巴特沃斯滤波器（可控过渡）
createBindings.maskButterworth(width, height, order: 2, frequencyCutoff: 0.5);
```
