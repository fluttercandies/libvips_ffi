# libvips_ffi_api 函数实现状态

基于 [libvips 官方文档](https://www.libvips.org/API/current/function-list.html) 的操作符列表。

**目标**: 所有操作都要在 api 包中实现 variadic 绑定。

## 图例

- ✅ 已实现 (在 api 包的 bindings 中有 variadic 绑定)
- ❌ 未实现 (需要添加)

---

## Arithmetic (算术操作)

| 操作 | C 函数 | 状态 | 备注 |
|------|--------|------|------|
| abs | vips_abs() | ✅ | arithmetic_bindings |
| add | vips_add() | ✅ | arithmetic_bindings |
| avg | vips_avg() | ✅ | arithmetic_bindings |
| ceil | vips_ceil() | ✅ | arithmetic_bindings |
| cos | vips_cos() | ✅ | arithmetic_bindings |
| deviate | vips_deviate() | ✅ | arithmetic_bindings |
| divide | vips_divide() | ✅ | arithmetic_bindings |
| exp | vips_exp() | ✅ | arithmetic_bindings |
| exp10 | vips_exp10() | ✅ | arithmetic_bindings |
| floor | vips_floor() | ✅ | arithmetic_bindings |
| getpoint | vips_getpoint() | ✅ | arithmetic_bindings |
| linear | vips_linear() | ✅ | vips_bindings (api) |
| linear1 | vips_linear1() | ✅ | vips_bindings (api) |
| log | vips_log() | ✅ | arithmetic_bindings |
| log10 | vips_log10() | ✅ | arithmetic_bindings |
| math | vips_math() | ✅ | arithmetic_bindings |
| math2 | vips_math2() | ✅ | arithmetic_bindings |
| max | vips_max() | ✅ | arithmetic_bindings |
| maxpair | vips_maxpair() | ✅ | arithmetic_bindings |
| measure | vips_measure() | ✅ | arithmetic_bindings |
| min | vips_min() | ✅ | arithmetic_bindings |
| minpair | vips_minpair() | ✅ | arithmetic_bindings |
| multiply | vips_multiply() | ✅ | arithmetic_bindings |
| pow | vips_pow() | ✅ | arithmetic_bindings |
| remainder | vips_remainder() | ✅ | arithmetic_bindings |
| rint | vips_rint() | ✅ | arithmetic_bindings |
| round | vips_round() | ✅ | arithmetic_bindings |
| sign | vips_sign() | ✅ | arithmetic_bindings |
| sin | vips_sin() | ✅ | arithmetic_bindings |
| stats | vips_stats() | ✅ | arithmetic_bindings |
| subtract | vips_subtract() | ✅ | arithmetic_bindings |
| sum | vips_sum() | ✅ | arithmetic_bindings |
| tan | vips_tan() | ✅ | arithmetic_bindings |
| find_trim | vips_find_trim() | ✅ | arithmetic_bindings |
| clamp | vips_clamp() | ✅ | arithmetic_bindings |
| hough_circle | vips_hough_circle() | ✅ | arithmetic_bindings |
| hough_line | vips_hough_line() | ✅ | arithmetic_bindings |
| profile | vips_profile() | ✅ | arithmetic_bindings |
| project | vips_project() | ✅ | arithmetic_bindings |

## Relational / Boolean (关系/布尔操作)

| 操作 | C 函数 | 状态 | 备注 |
|------|--------|------|------|
| equal | vips_equal() | ✅ | relational_bindings |
| equal_const | vips_equal_const() | ✅ | relational_bindings |
| equal_const1 | vips_equal_const1() | ✅ | relational_bindings |
| notequal | vips_notequal() | ✅ | relational_bindings |
| notequal_const | vips_notequal_const() | ✅ | relational_bindings |
| notequal_const1 | vips_notequal_const1() | ✅ | relational_bindings |
| less | vips_less() | ✅ | relational_bindings |
| less_const | vips_less_const() | ✅ | relational_bindings |
| less_const1 | vips_less_const1() | ✅ | relational_bindings |
| lesseq | vips_lesseq() | ✅ | relational_bindings |
| lesseq_const | vips_lesseq_const() | ✅ | relational_bindings |
| lesseq_const1 | vips_lesseq_const1() | ✅ | relational_bindings |
| more | vips_more() | ✅ | relational_bindings |
| more_const | vips_more_const() | ✅ | relational_bindings |
| more_const1 | vips_more_const1() | ✅ | relational_bindings |
| moreeq | vips_moreeq() | ✅ | relational_bindings |
| moreeq_const | vips_moreeq_const() | ✅ | relational_bindings |
| moreeq_const1 | vips_moreeq_const1() | ✅ | relational_bindings |
| andimage | vips_andimage() | ✅ | relational_bindings |
| andimage_const | vips_andimage_const() | ✅ | relational_bindings |
| andimage_const1 | vips_andimage_const1() | ✅ | relational_bindings |
| orimage | vips_orimage() | ✅ | relational_bindings |
| orimage_const | vips_orimage_const() | ✅ | relational_bindings |
| orimage_const1 | vips_orimage_const1() | ✅ | relational_bindings |
| eorimage | vips_eorimage() | ✅ | relational_bindings |
| lshift | vips_lshift() | ✅ | relational_bindings |
| lshift_const | vips_lshift_const() | ✅ | relational_bindings |
| lshift_const1 | vips_lshift_const1() | ✅ | relational_bindings |
| rshift | vips_rshift() | ✅ | relational_bindings |
| rshift_const | vips_rshift_const() | ✅ | relational_bindings |
| rshift_const1 | vips_rshift_const1() | ✅ | relational_bindings |
| ifthenelse | vips_ifthenelse() | ✅ | relational_bindings |
| boolean | vips_boolean() | ✅ | relational_bindings |
| boolean_const | vips_boolean_const() | ✅ | relational_bindings |
| bandbool | vips_bandbool() | ✅ | relational_bindings |
| bandand | vips_bandand() | ✅ | relational_bindings |
| bandor | vips_bandor() | ✅ | relational_bindings |
| bandeor | vips_bandeor() | ✅ | relational_bindings |

## Colour (颜色操作)

| 操作 | C 函数 | 状态 | 备注 |
|------|--------|------|------|
| CMC2LCh | vips_CMC2LCh() | ✅ | colour_bindings |
| CMYK2XYZ | vips_CMYK2XYZ() | ✅ | colour_bindings |
| HSV2sRGB | vips_HSV2sRGB() | ✅ | colour_bindings |
| LCh2CMC | vips_LCh2CMC() | ✅ | colour_bindings |
| LCh2Lab | vips_LCh2Lab() | ✅ | colour_bindings |
| Lab2LCh | vips_Lab2LCh() | ✅ | colour_bindings |
| Lab2LabQ | vips_Lab2LabQ() | ✅ | colour_bindings |
| Lab2LabS | vips_Lab2LabS() | ✅ | colour_bindings |
| Lab2XYZ | vips_Lab2XYZ() | ✅ | colour_bindings |
| LabQ2Lab | vips_LabQ2Lab() | ✅ | colour_bindings |
| LabQ2LabS | vips_LabQ2LabS() | ✅ | colour_bindings |
| LabQ2sRGB | vips_LabQ2sRGB() | ✅ | colour_bindings |
| LabS2Lab | vips_LabS2Lab() | ✅ | colour_bindings |
| LabS2LabQ | vips_LabS2LabQ() | ✅ | colour_bindings |
| XYZ2CMYK | vips_XYZ2CMYK() | ✅ | colour_bindings |
| XYZ2Lab | vips_XYZ2Lab() | ✅ | colour_bindings |
| XYZ2Yxy | vips_XYZ2Yxy() | ✅ | colour_bindings |
| XYZ2scRGB | vips_XYZ2scRGB() | ✅ | colour_bindings |
| Yxy2XYZ | vips_Yxy2XYZ() | ✅ | colour_bindings |
| colourspace | vips_colourspace() | ✅ | vips_bindings (api) |
| dE00 | vips_dE00() | ✅ | colour_bindings |
| dE76 | vips_dE76() | ✅ | colour_bindings |
| dECMC | vips_dECMC() | ✅ | colour_bindings |
| falsecolour | vips_falsecolour() | ✅ | colour_bindings |
| icc_export | vips_icc_export() | ✅ | colour_bindings |
| icc_import | vips_icc_import() | ✅ | colour_bindings |
| icc_transform | vips_icc_transform() | ✅ | colour_bindings |
| recomb | vips_recomb() | ✅ | colour_bindings |
| sRGB2HSV | vips_sRGB2HSV() | ✅ | colour_bindings |
| sRGB2scRGB | vips_sRGB2scRGB() | ✅ | colour_bindings |
| scRGB2BW | vips_scRGB2BW() | ✅ | colour_bindings |
| scRGB2XYZ | vips_scRGB2XYZ() | ✅ | colour_bindings |
| scRGB2sRGB | vips_scRGB2sRGB() | ✅ | colour_bindings |

## Conversion (转换操作)

| 操作 | C 函数 | 状态 | 备注 |
|------|--------|------|------|
| addalpha | vips_addalpha() | ✅ | conversion_bindings |
| autorot | vips_autorot() | ✅ | vips_bindings (api) |
| bandfold | vips_bandfold() | ✅ | conversion_bindings |
| bandjoin | vips_bandjoin() | ✅ | conversion_bindings |
| bandjoin2 | vips_bandjoin2() | ✅ | conversion_bindings |
| bandjoin_const | vips_bandjoin_const() | ✅ | vips_bindings (api) |
| bandmean | vips_bandmean() | ✅ | conversion_bindings |
| bandunfold | vips_bandunfold() | ✅ | conversion_bindings |
| byteswap | vips_byteswap() | ✅ | conversion_bindings |
| cast | vips_cast() | ✅ | vips_bindings (api) |
| copy | vips_copy() | ✅ | conversion_bindings |
| embed | vips_embed() | ✅ | vips_bindings (api) |
| extract_area | vips_extract_area() | ✅ | vips_bindings (api) |
| extract_band | vips_extract_band() | ✅ | vips_bindings (api) |
| flatten | vips_flatten() | ✅ | vips_bindings (api) |
| flip | vips_flip() | ✅ | vips_bindings (api) |
| gamma | vips_gamma() | ✅ | vips_bindings (api) |
| gravity | vips_gravity() | ✅ | vips_bindings (api) |
| grid | vips_grid() | ✅ | conversion_bindings |
| insert | vips_insert() | ✅ | vips_bindings (api) |
| invert | vips_invert() | ✅ | vips_bindings (api) |
| join | vips_join() | ✅ | vips_bindings (api) |
| msb | vips_msb() | ✅ | conversion_bindings |
| premultiply | vips_premultiply() | ✅ | conversion_bindings |
| replicate | vips_replicate() | ✅ | conversion_bindings |
| rot | vips_rot() | ✅ | conversion_bindings |
| rot45 | vips_rot45() | ✅ | conversion_bindings |
| rot90 | vips_rot90() | ✅ | conversion_bindings |
| rot180 | vips_rot180() | ✅ | conversion_bindings |
| rot270 | vips_rot270() | ✅ | conversion_bindings |
| scale | vips_scale() | ✅ | conversion_bindings |
| sequential | vips_sequential() | ✅ | conversion_bindings |
| smartcrop | vips_smartcrop() | ✅ | vips_bindings (api) |
| subsample | vips_subsample() | ✅ | conversion_bindings |
| transpose3d | vips_transpose3d() | ✅ | conversion_bindings |
| unpremultiply | vips_unpremultiply() | ✅ | conversion_bindings |
| wrap | vips_wrap() | ✅ | conversion_bindings |
| zoom | vips_zoom() | ✅ | vips_bindings (api) |

## Convolution (卷积操作)

| 操作 | C 函数 | 状态 | 备注 |
|------|--------|------|------|
| canny | vips_canny() | ✅ | vips_bindings (api) |
| compass | vips_compass() | ✅ | convolution_bindings |
| conv | vips_conv() | ✅ | convolution_bindings |
| conva | vips_conva() | ✅ | convolution_bindings |
| convasep | vips_convasep() | ✅ | convolution_bindings |
| convf | vips_convf() | ✅ | convolution_bindings |
| convi | vips_convi() | ✅ | convolution_bindings |
| convsep | vips_convsep() | ✅ | convolution_bindings |
| fastcor | vips_fastcor() | ✅ | convolution_bindings |
| gaussblur | vips_gaussblur() | ✅ | vips_bindings (api) |
| prewitt | vips_prewitt() | ✅ | convolution_bindings |
| scharr | vips_scharr() | ✅ | convolution_bindings |
| sharpen | vips_sharpen() | ✅ | vips_bindings (api) |
| sobel | vips_sobel() | ✅ | vips_bindings (api) |
| spcor | vips_spcor() | ✅ | convolution_bindings |

## Create (创建操作)

| 操作 | C 函数 | 状态 | 备注 |
|------|--------|------|------|
| black | vips_black() | ✅ | vips_bindings (api) |
| buildlut | vips_buildlut() | ✅ | create_bindings |
| eye | vips_eye() | ✅ | create_bindings |
| fractsurf | vips_fractsurf() | ✅ | create_bindings |
| gaussmat | vips_gaussmat() | ✅ | create_bindings |
| gaussnoise | vips_gaussnoise() | ✅ | vips_bindings (api) |
| grey | vips_grey() | ✅ | vips_bindings (api) |
| identity | vips_identity() | ✅ | create_bindings |
| invertlut | vips_invertlut() | ✅ | create_bindings |
| logmat | vips_logmat() | ✅ | create_bindings |
| mask_butterworth | vips_mask_butterworth() | ✅ | create_bindings |
| mask_butterworth_band | vips_mask_butterworth_band() | ✅ | create_bindings |
| mask_butterworth_ring | vips_mask_butterworth_ring() | ✅ | create_bindings |
| mask_fractal | vips_mask_fractal() | ✅ | create_bindings |
| mask_gaussian | vips_mask_gaussian() | ✅ | create_bindings |
| mask_gaussian_band | vips_mask_gaussian_band() | ✅ | create_bindings |
| mask_gaussian_ring | vips_mask_gaussian_ring() | ✅ | create_bindings |
| mask_ideal | vips_mask_ideal() | ✅ | create_bindings |
| mask_ideal_band | vips_mask_ideal_band() | ✅ | create_bindings |
| mask_ideal_ring | vips_mask_ideal_ring() | ✅ | create_bindings |
| perlin | vips_perlin() | ✅ | create_bindings |
| sdf | vips_sdf() | ✅ | create_bindings |
| sines | vips_sines() | ✅ | create_bindings |
| text | vips_text() | ✅ | vips_bindings (api) |
| tonelut | vips_tonelut() | ✅ | create_bindings |
| worley | vips_worley() | ✅ | create_bindings |
| xyz | vips_xyz() | ✅ | vips_bindings (api) |
| zone | vips_zone() | ✅ | create_bindings |

## Draw (绘制操作)

| 操作 | C 函数 | 状态 | 备注 |
|------|--------|------|------|
| draw_circle | vips_draw_circle() | ✅ | draw_bindings |
| draw_circle1 | vips_draw_circle1() | ✅ | draw_bindings |
| draw_flood | vips_draw_flood() | ✅ | draw_bindings |
| draw_flood1 | vips_draw_flood1() | ✅ | draw_bindings |
| draw_image | vips_draw_image() | ✅ | draw_bindings |
| draw_line | vips_draw_line() | ✅ | draw_bindings |
| draw_line1 | vips_draw_line1() | ✅ | draw_bindings |
| draw_mask | vips_draw_mask() | ✅ | draw_bindings |
| draw_mask1 | vips_draw_mask1() | ✅ | draw_bindings |
| draw_point | vips_draw_point() | ✅ | draw_bindings |
| draw_point1 | vips_draw_point1() | ✅ | draw_bindings |
| draw_rect | vips_draw_rect() | ✅ | draw_bindings |
| draw_rect1 | vips_draw_rect1() | ✅ | draw_bindings |
| draw_smudge | vips_draw_smudge() | ✅ | draw_bindings |

## Fourier / Frequency (频域操作)

| 操作 | C 函数 | 状态 | 备注 |
|------|--------|------|------|
| freqmult | vips_freqmult() | ✅ | frequency_bindings |
| fwfft | vips_fwfft() | ✅ | frequency_bindings |
| invfft | vips_invfft() | ✅ | frequency_bindings |
| phasecor | vips_phasecor() | ✅ | frequency_bindings |
| spectrum | vips_spectrum() | ✅ | frequency_bindings |

## Histogram (直方图操作)

| 操作 | C 函数 | 状态 | 备注 |
|------|--------|------|------|
| hist_cum | vips_hist_cum() | ✅ | colour_bindings |
| hist_entropy | vips_hist_entropy() | ✅ | colour_bindings |
| hist_equal | vips_hist_equal() | ✅ | colour_bindings |
| hist_find | vips_hist_find() | ✅ | colour_bindings |
| hist_find_indexed | vips_hist_find_indexed() | ✅ | colour_bindings |
| hist_find_ndim | vips_hist_find_ndim() | ✅ | colour_bindings |
| hist_ismonotonic | vips_hist_ismonotonic() | ✅ | colour_bindings |
| hist_local | vips_hist_local() | ✅ | colour_bindings |
| hist_match | vips_hist_match() | ✅ | colour_bindings |
| hist_norm | vips_hist_norm() | ✅ | colour_bindings |
| hist_plot | vips_hist_plot() | ✅ | colour_bindings |
| maplut | vips_maplut() | ✅ | colour_bindings |
| percent | vips_percent() | ✅ | colour_bindings |
| stdif | vips_stdif() | ✅ | colour_bindings |

## Morphology (形态学操作)

| 操作 | C 函数 | 状态 | 备注 |
|------|--------|------|------|
| countlines | vips_countlines() | ✅ | morphology_bindings |
| fill_nearest | vips_fill_nearest() | ✅ | morphology_bindings |
| labelregions | vips_labelregions() | ✅ | morphology_bindings |
| median | vips_median() | ✅ | morphology_bindings |
| morph | vips_morph() | ✅ | morphology_bindings |
| rank | vips_rank() | ✅ | morphology_bindings |

## Mosaicing (拼接操作)

| 操作 | C 函数 | 状态 | 备注 |
|------|--------|------|------|
| globalbalance | vips_globalbalance() | ✅ | mosaicing_bindings |
| match | vips_match() | ✅ | mosaicing_bindings |
| merge | vips_merge() | ✅ | mosaicing_bindings |
| mosaic | vips_mosaic() | ✅ | mosaicing_bindings |
| mosaic1 | vips_mosaic1() | ✅ | mosaicing_bindings |
| remosaic | vips_remosaic() | ✅ | mosaicing_bindings |

## Resample (重采样操作)

| 操作 | C 函数 | 状态 | 备注 |
|------|--------|------|------|
| affine | vips_affine() | ✅ | resample_bindings |
| mapim | vips_mapim() | ✅ | resample_bindings |
| quadratic | vips_quadratic() | ✅ | resample_bindings |
| reduce | vips_reduce() | ✅ | vips_bindings (api) |
| reduceh | vips_reduceh() | ✅ | resample_bindings |
| reducev | vips_reducev() | ✅ | resample_bindings |
| resize | vips_resize() | ✅ | vips_bindings (api) |
| rotate | vips_rotate() | ✅ | vips_bindings (api) |
| shrink | vips_shrink() | ✅ | vips_bindings (api) |
| shrinkh | vips_shrinkh() | ✅ | resample_bindings |
| shrinkv | vips_shrinkv() | ✅ | resample_bindings |
| similarity | vips_similarity() | ✅ | resample_bindings |
| thumbnail | vips_thumbnail() | ✅ | resample_bindings |
| thumbnail_buffer | vips_thumbnail_buffer() | ✅ | resample_bindings |
| thumbnail_image | vips_thumbnail_image() | ✅ | vips_bindings (api) |
| thumbnail_source | vips_thumbnail_source() | ✅ | resample_bindings |

## Foreign / I/O (文件格式)

| 操作 | C 函数 | 状态 | 备注 |
|------|--------|------|------|
| jpegload | vips_jpegload() | ✅ | io_bindings |
| jpegload_buffer | vips_jpegload_buffer() | ✅ | io_bindings |
| jpegsave | vips_jpegsave() | ✅ | io_bindings |
| jpegsave_buffer | vips_jpegsave_buffer() | ✅ | io_bindings |
| pngload | vips_pngload() | ✅ | io_bindings |
| pngload_buffer | vips_pngload_buffer() | ✅ | io_bindings |
| pngsave | vips_pngsave() | ✅ | io_bindings |
| pngsave_buffer | vips_pngsave_buffer() | ✅ | io_bindings |
| webpload | vips_webpload() | ✅ | io_bindings |
| webpload_buffer | vips_webpload_buffer() | ✅ | io_bindings |
| webpsave | vips_webpsave() | ✅ | io_bindings |
| webpsave_buffer | vips_webpsave_buffer() | ✅ | io_bindings |
| tiffload | vips_tiffload() | ✅ | io_bindings |
| tiffload_buffer | vips_tiffload_buffer() | ✅ | io_bindings |
| tiffsave | vips_tiffsave() | ✅ | io_bindings |
| tiffsave_buffer | vips_tiffsave_buffer() | ✅ | io_bindings |
| gifload | vips_gifload() | ✅ | io_bindings |
| gifload_buffer | vips_gifload_buffer() | ✅ | io_bindings |
| gifsave | vips_gifsave() | ✅ | io_bindings |
| gifsave_buffer | vips_gifsave_buffer() | ✅ | io_bindings |
| heifload | vips_heifload() | ✅ | io_bindings |
| heifload_buffer | vips_heifload_buffer() | ✅ | io_bindings |
| heifsave | vips_heifsave() | ✅ | io_bindings |
| heifsave_buffer | vips_heifsave_buffer() | ✅ | io_bindings |
| pdfload | vips_pdfload() | ✅ | io_bindings |
| pdfload_buffer | vips_pdfload_buffer() | ✅ | io_bindings |
| svgload | vips_svgload() | ✅ | io_bindings |
| svgload_buffer | vips_svgload_buffer() | ✅ | io_bindings |
| vips_image_new_from_file | | ✅ | vips_bindings (api) |
| vips_image_new_from_buffer | | ✅ | vips_bindings (api) |
| vips_image_write_to_file | | ✅ | vips_bindings (api) |
| vips_image_write_to_buffer | | ✅ | vips_bindings (api) |
| jp2kload | vips_jp2kload() | ✅ | io_bindings |
| jp2ksave | vips_jp2ksave() | ✅ | io_bindings |
| jxlload | vips_jxlload() | ✅ | io_bindings |
| jxlsave | vips_jxlsave() | ✅ | io_bindings |
| magickload | vips_magickload() | ✅ | io_bindings |
| magicksave | vips_magicksave() | ✅ | io_bindings |
| niftiload | vips_niftiload() | ✅ | io_bindings |
| niftisave | vips_niftisave() | ✅ | io_bindings |
| openexrload | vips_openexrload() | ✅ | io_bindings |
| openslideload | vips_openslideload() | ✅ | io_bindings |
| radload | vips_radload() | ✅ | io_bindings |
| radsave | vips_radsave() | ✅ | io_bindings |
| rawload | vips_rawload() | ✅ | io_bindings |
| rawsave | vips_rawsave() | ✅ | io_bindings |
| dzsave | vips_dzsave() | ✅ | io_bindings |

## Composite (合成操作)

| 操作 | C 函数 | 状态 | 备注 |
|------|--------|------|------|
| composite | vips_composite() | ✅ | create_bindings |
| composite2 | vips_composite2() | ✅ | vips_bindings (api) |

## Complex (复数操作)

| 操作 | C 函数 | 状态 | 备注 |
|------|--------|------|------|
| complex | vips_complex() | ✅ | complex_bindings |
| complex2 | vips_complex2() | ✅ | complex_bindings |
| complexform | vips_complexform() | ✅ | complex_bindings |
| complexget | vips_complexget() | ✅ | complex_bindings |
| polar | vips_polar() | ✅ | complex_bindings |
| rect | vips_rect() | ✅ | complex_bindings |
| conj | vips_conj() | ✅ | complex_bindings |
| real | vips_real() | ✅ | complex_bindings |
| imag | vips_imag() | ✅ | complex_bindings |
| cross_phase | vips_cross_phase() | ✅ | complex_bindings |

---

## 统计

| 类别 | 已实现 (✅) | 未实现 (❌) | 完成率 |
|------|------------|------------|--------|
| Arithmetic | 41 | 0 | **100%** |
| Relational | 38 | 0 | **100%** |
| Colour | 34 | 0 | **100%** |
| Conversion | 38 | 0 | **100%** |
| Convolution | 15 | 0 | **100%** |
| Create | 27 | 0 | **100%** |
| Draw | 14 | 0 | **100%** |
| Frequency | 5 | 0 | **100%** |
| Histogram | 14 | 0 | **100%** |
| Morphology | 6 | 0 | **100%** |
| Mosaicing | 6 | 0 | **100%** |
| Resample | 16 | 0 | **100%** |
| I/O | 47 | 0 | **100%** |
| Composite | 2 | 0 | **100%** |
| Complex | 10 | 0 | **100%** |

**总计**: ~313 已实现 / ~313 总函数 = **100%**

---

## 下一步 (TODO)

1. ✅ ~实现 Colour 类别的颜色空间转换函数~ 已完成
2. ✅ ~实现 Conversion 类别的剩余函数~ 已完成
3. ✅ ~实现 Arithmetic 类别的数学函数~ 已完成
4. ✅ ~实现 Convolution 类别的卷积函数~ 已完成
5. ✅ ~实现 Resample 类别的剩余函数~ 已完成
6. ✅ ~实现 Complex 类别~ 已完成
7. ✅ ~实现 I/O 类别的剩余格式~ 已完成
8. ✅ ~实现 Mosaicing 类别~ 已完成
9. ✅ ~实现 Relational 类别的剩余函数~ 已完成
10. ✅ ~实现 Conversion rot90/rot180/rot270~ 已完成
11. ✅ ~实现 composite~ 已完成
12. ❌ 添加对应的 Pipeline 扩展方法
13. ❌ 更新 PipelineSpec 支持所有操作
