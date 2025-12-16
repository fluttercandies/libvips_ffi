# libvips_ffi_api Pipeline 扩展方法完成度

本文档追踪 `libvips_ffi_api` 包中 Pipeline 扩展方法的实现状态。

## 状态说明

- ✅ 已实现
- ❌ 未实现

---

## Resample (重采样) - resample_ext.dart

| 方法 | 底层函数 | 状态 | 备注 |
|------|----------|------|------|
| resize | vips_resize | ✅ | |
| rotate | vips_rotate | ✅ | |
| thumbnail | vips_thumbnail_image | ✅ | |
| reduce | vips_reduce | ✅ | |
| shrink | vips_shrink | ✅ | |
| affine | vips_affine | ✅ | |
| similarity | vips_similarity | ✅ | |
| reduceh | vips_reduceh | ✅ | |
| reducev | vips_reducev | ✅ | |
| shrinkh | vips_shrinkh | ✅ | |
| shrinkv | vips_shrinkv | ✅ | |
| mapim | vips_mapim | ❌ | 需要 index 图像参数 |
| quadratic | vips_quadratic | ❌ | 需要 coeff 图像参数 |

## Geometry (几何) - geometry_ext.dart

| 方法 | 底层函数 | 状态 | 备注 |
|------|----------|------|------|
| crop | vips_extract_area | ✅ | |
| extractArea | vips_extract_area | ✅ | |
| embed | vips_embed | ✅ | |
| gravity | vips_gravity | ✅ | |
| flip | vips_flip | ✅ | |
| flipHorizontal | vips_flip | ✅ | |
| flipVertical | vips_flip | ✅ | |
| join | vips_join | ✅ | 接受 VipsImg 参数 |
| insert | vips_insert | ✅ | 接受 VipsImg 参数 |
| smartcrop | vips_smartcrop | ✅ | |
| zoom | vips_zoom | ✅ | |

## Colour (颜色) - colour_ext.dart

| 方法 | 底层函数 | 状态 | 备注 |
|------|----------|------|------|
| colourspace | vips_colourspace | ✅ | |
| linear | vips_linear1 | ✅ | |
| brightness | vips_linear1 | ✅ | |
| contrast | vips_linear1 | ✅ | |
| grayscale | vips_colourspace | ✅ | |
| toSrgb | vips_colourspace | ✅ | |
| cmc2LCh | vips_CMC2LCh | ✅ | |
| cmyk2XYZ | vips_CMYK2XYZ | ✅ | |
| hsv2sRGB | vips_HSV2sRGB | ✅ | |
| sRGB2HSV | vips_sRGB2HSV | ✅ | |
| lab2XYZ | vips_Lab2XYZ | ✅ | |
| xyz2Lab | vips_XYZ2Lab | ✅ | |
| scRGB2sRGB | vips_scRGB2sRGB | ✅ | |
| sRGB2scRGB | vips_sRGB2scRGB | ✅ | |
| lch2CMC | vips_LCh2CMC | ✅ | |
| lch2Lab | vips_LCh2Lab | ✅ | |
| lab2LCh | vips_Lab2LCh | ✅ | |
| lab2LabQ | vips_Lab2LabQ | ❌ | |
| lab2LabS | vips_Lab2LabS | ❌ | |
| labQ2Lab | vips_LabQ2Lab | ❌ | |
| labQ2LabS | vips_LabQ2LabS | ❌ | |
| labQ2sRGB | vips_LabQ2sRGB | ❌ | |
| labS2Lab | vips_LabS2Lab | ❌ | |
| labS2LabQ | vips_LabS2LabQ | ❌ | |
| xyz2CMYK | vips_XYZ2CMYK | ✅ | |
| xyz2Yxy | vips_XYZ2Yxy | ❌ | |
| xyz2scRGB | vips_XYZ2scRGB | ✅ | |
| yxy2XYZ | vips_Yxy2XYZ | ❌ | |
| scRGB2BW | vips_scRGB2BW | ✅ | |
| scRGB2XYZ | vips_scRGB2XYZ | ✅ | |
| recomb | vips_recomb | ❌ | 需要 matrix 参数 |
| falsecolour | vips_falsecolour | ✅ | |
| iccExport | vips_icc_export | ❌ | |
| iccImport | vips_icc_import | ❌ | |
| iccTransform | vips_icc_transform | ❌ | |
| dE00 | vips_dE00 | ❌ | 需要另一图像参数 |
| dE76 | vips_dE76 | ❌ | 需要另一图像参数 |
| dECMC | vips_dECMC | ❌ | 需要另一图像参数 |

## Conversion (转换) - conversion_ext.dart

| 方法 | 底层函数 | 状态 | 备注 |
|------|----------|------|------|
| flatten | vips_flatten | ✅ | |
| cast | vips_cast | ✅ | |
| invert | vips_invert | ✅ | |
| gamma | vips_gamma | ✅ | |
| autoRotate | vips_autorot | ✅ | |
| extractBand | vips_extract_band | ✅ | |
| addAlpha | vips_bandjoin_const | ✅ | |
| rot90 | vips_rot90 | ✅ | |
| rot180 | vips_rot180 | ✅ | |
| rot270 | vips_rot270 | ✅ | |
| copy | vips_copy | ✅ | |
| premultiply | vips_premultiply | ✅ | |
| unpremultiply | vips_unpremultiply | ✅ | |
| replicate | vips_replicate | ✅ | |
| bandmean | vips_bandmean | ✅ | |
| addalpha | vips_addalpha | ❌ | |
| bandfold | vips_bandfold | ✅ | |
| bandjoin | vips_bandjoin | ❌ | 需要多图像参数 |
| bandjoin2 | vips_bandjoin2 | ❌ | 需要另一图像参数 |
| bandunfold | vips_bandunfold | ✅ | |
| byteswap | vips_byteswap | ✅ | |
| grid | vips_grid | ❌ | |
| msb | vips_msb | ✅ | |
| rot | vips_rot | ❌ | |
| rot45 | vips_rot45 | ✅ | |
| scale | vips_scale | ✅ | |
| sequential | vips_sequential | ✅ | |
| subsample | vips_subsample | ✅ | |
| transpose3d | vips_transpose3d | ❌ | |
| wrap | vips_wrap | ✅ | |

## Convolution (卷积) - convolution_ext.dart

| 方法 | 底层函数 | 状态 | 备注 |
|------|----------|------|------|
| blur | vips_gaussblur | ✅ | |
| gaussianBlur | vips_gaussblur | ✅ | alias |
| sharpen | vips_sharpen | ✅ | |
| sobel | vips_sobel | ✅ | |
| canny | vips_canny | ✅ | |
| prewitt | vips_prewitt | ✅ | |
| scharr | vips_scharr | ✅ | |
| conv | vips_conv | ✅ | |
| convi | vips_convi | ✅ | |
| convf | vips_convf | ✅ | |
| compass | vips_compass | ✅ | 接受 VipsImg mask 参数 |
| conva | vips_conva | ❌ | |
| convasep | vips_convasep | ❌ | |
| convsep | vips_convsep | ❌ | |
| fastcor | vips_fastcor | ✅ | 接受 VipsImg ref 参数 |
| spcor | vips_spcor | ✅ | 接受 VipsImg ref 参数 |

## Arithmetic (算术) - arithmetic_ext.dart

| 方法 | 底层函数 | 状态 | 备注 |
|------|----------|------|------|
| ceil | vips_ceil | ✅ | |
| floor | vips_floor | ✅ | |
| rint | vips_rint | ✅ | |
| cos | vips_cos | ✅ | |
| sin | vips_sin | ✅ | |
| tan | vips_tan | ✅ | |
| exp | vips_exp | ✅ | |
| exp10 | vips_exp10 | ✅ | |
| log | vips_log | ✅ | |
| log10 | vips_log10 | ✅ | |
| abs | vips_abs | ✅ | |
| add | vips_add | ✅ | 接受 VipsImg 参数 |
| subtract | vips_subtract | ✅ | 接受 VipsImg 参数 |
| multiply | vips_multiply | ✅ | 接受 VipsImg 参数 |
| divide | vips_divide | ✅ | 接受 VipsImg 参数 |
| avg | vips_avg | ❌ | 返回值类型不同 |
| deviate | vips_deviate | ❌ | 返回值类型不同 |
| getpoint | vips_getpoint | ❌ | 返回值类型不同 |
| max | vips_max | ❌ | 返回值类型不同 |
| min | vips_min | ❌ | 返回值类型不同 |
| maxpair | vips_maxpair | ✅ | 接受 VipsImg 参数 |
| minpair | vips_minpair | ✅ | 接受 VipsImg 参数 |
| pow | vips_pow | ❌ | 需要另一图像参数 |
| remainder | vips_remainder | ❌ | 需要另一图像参数 |
| round | vips_round | ❌ | |
| sign | vips_sign | ✅ | |
| stats | vips_stats | ❌ | 返回值类型不同 |
| sum | vips_sum | ❌ | 需要多图像参数 |
| math | vips_math | ❌ | |
| math2 | vips_math2 | ❌ | 需要另一图像参数 |
| measure | vips_measure | ❌ | |
| findTrim | vips_find_trim | ❌ | 返回值类型不同 |

## Complex (复数) - complex_ext.dart

| 方法 | 底层函数 | 状态 | 备注 |
|------|----------|------|------|
| polar | vips_polar | ✅ | |
| rect | vips_rect | ✅ | |
| conj | vips_conj | ✅ | |
| real | vips_real | ✅ | |
| imag | vips_imag | ✅ | |
| complex | vips_complex | ❌ | |
| complex2 | vips_complex2 | ✅ | 接受 VipsImg 参数 |
| complexform | vips_complexform | ✅ | 接受 VipsImg 参数 |
| complexget | vips_complexget | ❌ | |
| crossPhase | vips_cross_phase | ✅ | 接受 VipsImg 参数 |

## Composite (合成) - composite_ext.dart

| 方法 | 底层函数 | 状态 | 备注 |
|------|----------|------|------|
| composite2 | vips_composite2 | ✅ | |
| composite | vips_composite | ❌ | 需要多图像参数 |

## Create (创建) - create_ext.dart

| 方法 | 底层函数 | 状态 | 备注 |
|------|----------|------|------|
| 静态方法，非Pipeline扩展 | | | |

## Mosaicing (拼接) - mosaicing_ext.dart

| 方法 | 底层函数 | 状态 | 备注 |
|------|----------|------|------|
| globalbalance | vips_globalbalance | ✅ | |
| match | vips_match | ❌ | 需要另一图像参数 |
| merge | vips_merge | ❌ | 需要另一图像参数 |
| mosaic | vips_mosaic | ❌ | 需要另一图像参数 |
| mosaic1 | vips_mosaic1 | ❌ | 需要另一图像参数 |
| remosaic | vips_remosaic | ❌ | |

## Relational (关系) - relational_ext.dart

| 方法 | 底层函数 | 状态 | 备注 |
|------|----------|------|------|
| equal | vips_equal | ✅ | 接受 VipsImg 参数 |
| notequal | vips_notequal | ✅ | 接受 VipsImg 参数 |
| less | vips_less | ✅ | 接受 VipsImg 参数 |
| lesseq | vips_lesseq | ✅ | 接受 VipsImg 参数 |
| more | vips_more | ✅ | 接受 VipsImg 参数 |
| moreeq | vips_moreeq | ✅ | 接受 VipsImg 参数 |
| ifthenelse | vips_ifthenelse | ❌ | 需要多图像参数 |
| boolean | vips_boolean | ❌ | 需要另一图像参数 |
| bandbool | vips_bandbool | ❌ | |
| bandand | vips_bandand | ✅ | |
| bandor | vips_bandor | ✅ | |
| bandeor | vips_bandeor | ✅ | |

## Draw (绘制) - draw_ext.dart

| 方法 | 底层函数 | 状态 | 备注 |
|------|----------|------|------|
| drawCircle | vips_draw_circle | ✅ | |
| drawFlood | vips_draw_flood | ✅ | |
| drawImage | vips_draw_image | ✅ | 接受 VipsImg 参数 |
| drawLine | vips_draw_line | ✅ | |
| drawMask | vips_draw_mask | ✅ | 接受 VipsImg mask 参数 |
| drawPoint | vips_draw_point | ✅ | |
| drawRect | vips_draw_rect | ✅ | |
| drawSmudge | vips_draw_smudge | ✅ | |

## Morphology (形态学) - morphology_ext.dart

| 方法 | 底层函数 | 状态 | 备注 |
|------|----------|------|------|
| morph | vips_morph | ✅ | 接受 VipsImg mask 参数 |
| rank | vips_rank | ✅ | |
| median | vips_median | ✅ | |
| countlines | vips_countlines | ❌ | 返回数值 |
| fillNearest | vips_fill_nearest | ✅ | |
| labelregions | vips_labelregions | ✅ | |

## Frequency (频域) - frequency_ext.dart

| 方法 | 底层函数 | 状态 | 备注 |
|------|----------|------|------|
| fwfft | vips_fwfft | ✅ | |
| invfft | vips_invfft | ✅ | |
| freqmult | vips_freqmult | ✅ | 接受 VipsImg mask 参数 |
| phasecor | vips_phasecor | ✅ | 接受 VipsImg 参数 |
| spectrum | vips_spectrum | ✅ | |

## Histogram (直方图) - histogram_ext.dart

| 方法 | 底层函数 | 状态 | 备注 |
|------|----------|------|------|
| histCum | vips_hist_cum | ✅ | |
| histNorm | vips_hist_norm | ✅ | |
| histEqual | vips_hist_equal | ✅ | |
| histEntropy | vips_hist_entropy | ❌ | 返回 double |
| histFind | vips_hist_find | ✅ | |
| histFindIndexed | vips_hist_find_indexed | ❌ | 需要 index 参数 |
| histFindNdim | vips_hist_find_ndim | ✅ | |
| histIsmonotonic | vips_hist_ismonotonic | ❌ | 返回 bool |
| histLocal | vips_hist_local | ✅ | |
| histMatch | vips_hist_match | ✅ | 接受 VipsImg ref 参数 |
| histPlot | vips_hist_plot | ✅ | |
| maplut | vips_maplut | ✅ | 接受 VipsImg lut 参数 |
| percentile | vips_percentile | ❌ | 返回 double |
| stdif | vips_stdif | ✅ | |

---

## 统计

| 类别 | 已实现 (✅) | 未实现 (❌) | 完成率 |
|------|------------|------------|--------|
| Frequency | 5 | 0 | **100%** |
| Draw | 8 | 0 | **100%** |
| Resample | 11 | 2 | 85% |
| Morphology | 5 | 1 | 83% |
| Geometry | 10 | 0 | **100%** |
| Complex | 8 | 2 | 80% |
| Relational | 9 | 3 | 75% |
| Convolution | 13 | 3 | 81% |
| Arithmetic | 18 | 14 | 56% |
| Histogram | 10 | 4 | 71% |
| Colour | 23 | 9 | 72% |
| Conversion | 24 | 5 | 83% |
| Composite | 2 | 1 | 67% |
| Mosaicing | 1 | 5 | 17% |

**总计**: 147 已实现 / 182 总方法 = **81%**

---

## 返回非图像类型的方法 (需作为 VipsImg 方法)

这些方法返回数值/统计信息而非图像，不适合作为 Pipeline 扩展。

| 方法 | 底层函数 | 返回类型 | 状态 |
|------|----------|----------|------|
| avg | vips_avg | double | ❌ |
| deviate | vips_deviate | double | ❌ |
| max | vips_max | double | ❌ |
| min | vips_min | double | ❌ |
| getpoint | vips_getpoint | List<double> | ❌ |
| stats | vips_stats | VipsImg (统计矩阵) | ❌ |
| histEntropy | vips_hist_entropy | double | ❌ |
| histIsmonotonic | vips_hist_ismonotonic | bool | ❌ |
| percentile | vips_percentile | double | ❌ |
| findTrim | vips_find_trim | (left, top, width, height) | ❌ |
| countlines | vips_countlines | double | ❌ |

**总计**: 0 / 11 = **0%**

---

## 分类统计

### Pipeline 扩展方法 (返回 VipsPipeline)

| 类别 | 已实现 | 未实现 | 完成率 |
|------|--------|--------|--------|
| Frequency | 5 | 0 | **100%** |
| Draw | 8 | 0 | **100%** |
| Geometry | 10 | 0 | **100%** |
| Resample | 11 | 2 | 85% |
| Morphology | 5 | 1 | 83% |
| Conversion | 24 | 5 | 83% |
| Convolution | 13 | 3 | 81% |
| Complex | 8 | 2 | 80% |
| Relational | 9 | 3 | 75% |
| Colour | 23 | 9 | 72% |
| Histogram | 10 | 4 | 71% |
| Composite | 2 | 1 | 67% |
| Arithmetic | 18 | 14 | 56% |
| Mosaicing | 1 | 5 | 17% |

**Pipeline 扩展总计**: 147 / 182 = **81%**

### VipsImg 方法 (返回非图像)

| 类别 | 已实现 | 未实现 | 完成率 |
|------|--------|--------|--------|
| Statistics | 0 | 11 | 0% |

**VipsImg 方法总计**: 0 / 11 = **0%**

---

## 说明

1. **Pipeline 扩展**: 返回 `VipsPipeline`，支持链式调用
2. **VipsImg 方法**: 返回数值/统计，应作为 `VipsImg` 类的方法
3. **多图像操作**: 接受 `VipsImg` 参数（如 add, subtract）
4. **静态方法**: Create 类别应作为工厂方法

## 下一步 TODO

1. ✅ ~实现单图像操作~ 大部分已完成
2. ✅ ~设计多图像操作 API~ 已完成
3. ❌ 创建 Draw/Morphology/Frequency/Histogram 扩展
4. ❌ 在 VipsImg 中添加返回数值的方法
5. ❌ 实现剩余单图像操作
