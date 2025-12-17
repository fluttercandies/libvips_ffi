---
sidebar_position: 13
---

# 复数

用于信号处理和 FFT 的复数操作。

## 函数映射

| libvips C | Dart 绑定 | 描述 |
|-----------|----------|------|
| `vips_complex()` | `complexBindings.complex()` | 一元复数操作 |
| `vips_complex2()` | `complexBindings.complex2()` | 二元复数操作 |
| `vips_complexget()` | `complexBindings.complexget()` | 提取分量 |
| `vips_complexform()` | `complexBindings.complexform()` | 从分量构建复数 |
| `vips_polar()` | `complexBindings.polar()` | 笛卡尔到极坐标 |
| `vips_rect()` | `complexBindings.rect()` | 极坐标到笛卡尔 |
| `vips_conj()` | `complexBindings.conj()` | 复数共轭 |
| `vips_real()` | `complexBindings.real()` | 获取实部 |
| `vips_imag()` | `complexBindings.imag()` | 获取虚部 |

## complex

应用一元复数操作。

```dart
complexBindings.complex(input, output, VipsOperationComplex.polar);
```

**操作 (VipsOperationComplex):**

- `polar` - 转换为极坐标
- `rect` - 转换为直角坐标
- `conj` - 复数共轭

## complexget

从复数图像提取分量。

```dart
// 获取实部
complexBindings.complexget(input, output, VipsOperationComplexget.real);

// 获取虚部
complexBindings.complexget(input, output, VipsOperationComplexget.imag);
```

## complexform

从两个实数图像构建复数图像。

```dart
// 从实部和虚部创建复数
complexBindings.complexform(realPart, imagPart, output);
```

## polar / rect

在坐标系之间转换。

```dart
// 笛卡尔到极坐标（幅度和相位）
complexBindings.polar(input, output);

// 极坐标到笛卡尔（实部和虚部）
complexBindings.rect(input, output);
```

## conj

复数共轭（取反虚部）。

```dart
complexBindings.conj(input, output);
```

## real / imag

提取分量的便捷函数。

```dart
// 提取实部
complexBindings.real(complexImage, realPart);

// 提取虚部
complexBindings.imag(complexImage, imagPart);
```

## 用例

### FFT 处理

```dart
// 正向 FFT 产生复数输出
frequencyBindings.fwfft(input, fftComplex);

// 获取幅度用于可视化
complexBindings.polar(fftComplex, polar);
complexBindings.real(polar, magnitude);  // 幅度在实部
```

### 相位分析

```dart
// 从复数 FFT 提取相位
complexBindings.polar(fftComplex, polar);
complexBindings.imag(polar, phase);  // 相位在虚部
```
