# libvips API 函数对比分析

本文档分析官方 libvips 函数列表（419 个）与 `api-function-todo.md`（306 个）之间的差异。

## 差异原因概述

| 类型 | 说明 | 估计数量 |
|------|------|----------|
| 便捷函数 | 基础操作的类型特化包装 | ~50 |
| Source/Target 变体 | I/O 函数的流式变体 | ~40 |
| 未列入文档 | 非图像处理函数 | ~15 |
| 已包含但合并统计 | 同一操作的多个函数 | ~8 |

**总计**: 306 (已列出) + ~113 (差异) ≈ 419

---

## 1. 便捷函数（Convenience Functions）

这些是基础操作的类型特化包装，调用时会转发到基础函数。

### cast 系列（基础: vips_cast）

| 便捷函数 | 状态 | 说明 |
|----------|------|------|
| vips_cast_uchar | ❌ | 转换为 unsigned char |
| vips_cast_char | ❌ | 转换为 char |
| vips_cast_ushort | ❌ | 转换为 unsigned short |
| vips_cast_short | ❌ | 转换为 short |
| vips_cast_uint | ❌ | 转换为 unsigned int |
| vips_cast_int | ❌ | 转换为 int |
| vips_cast_float | ❌ | 转换为 float |
| vips_cast_double | ❌ | 转换为 double |
| vips_cast_complex | ❌ | 转换为 complex |
| vips_cast_dpcomplex | ❌ | 转换为 double complex |

**不实现原因**: 可通过 `vips_cast()` + 枚举参数实现相同功能。

### rot 系列（基础: vips_rot）

| 便捷函数 | 状态 | 说明 |
|----------|------|------|
| vips_rot90 | ✅ | 已实现 |
| vips_rot180 | ✅ | 已实现 |
| vips_rot270 | ✅ | 已实现 |

### math 三角函数系列（基础: vips_math）

| 便捷函数 | 状态 | 说明 |
|----------|------|------|
| vips_asin | ❌ | 反正弦 |
| vips_acos | ❌ | 反余弦 |
| vips_atan | ❌ | 反正切 |
| vips_sinh | ❌ | 双曲正弦 |
| vips_cosh | ❌ | 双曲余弦 |
| vips_tanh | ❌ | 双曲正切 |
| vips_asinh | ❌ | 反双曲正弦 |
| vips_acosh | ❌ | 反双曲余弦 |
| vips_atanh | ❌ | 反双曲正切 |

**不实现原因**: 可通过 `vips_math()` + `VipsOperationMath` 枚举实现。

### math2 系列

| 便捷函数 | 状态 | 说明 |
|----------|------|------|
| vips_atan2 | ❌ | 两参数反正切 |
| vips_wop | ❌ | 反向幂运算 |

**不实现原因**: 可通过 `vips_math2()` + 枚举实现。

### boolean_const 系列

| 便捷函数 | 状态 | 说明 |
|----------|------|------|
| vips_eorimage_const | ❌ | XOR 与常数 |
| vips_eorimage_const1 | ❌ | XOR 与单常数 |
| vips_boolean_const1 | ❌ | 布尔操作与单常数 |

**不实现原因**: 可通过基础函数 + 枚举实现。

---

## 2. Source/Target 变体

这些是 I/O 函数的流式读写变体，用于从 VipsSource/VipsTarget 读写。

### 未实现的 Source 变体

| 函数 | 说明 |
|------|------|
| vips_csvload_source | CSV 源加载 |
| vips_fitsload_source | FITS 源加载 |
| vips_gifload_source | GIF 源加载 |
| vips_heifload_source | HEIF 源加载 |
| vips_jp2kload_source | JPEG2000 源加载 |
| vips_jpegload_source | JPEG 源加载 |
| vips_jxlload_source | JPEG XL 源加载 |
| vips_matrixload_source | Matrix 源加载 |
| vips_niftiload_source | NIFTI 源加载 |
| vips_openslideload_source | OpenSlide 源加载 |
| vips_pdfload_source | PDF 源加载 |
| vips_pngload_source | PNG 源加载 |
| vips_ppmload_source | PPM 源加载 |
| vips_radload_source | RAD 源加载 |
| vips_svgload_source | SVG 源加载 |
| vips_webpload_source | WebP 源加载 |

### 未实现的 Target 变体

| 函数 | 说明 |
|------|------|
| vips_csvsave_target | CSV 目标保存 |
| vips_dzsave_target | DeepZoom 目标保存 |
| vips_gifsave_target | GIF 目标保存 |
| vips_heifsave_target | HEIF 目标保存 |
| vips_jp2ksave_target | JPEG2000 目标保存 |
| vips_jpegsave_target | JPEG 目标保存 |
| vips_jxlsave_target | JPEG XL 目标保存 |
| vips_matrixsave_target | Matrix 目标保存 |
| vips_pngsave_target | PNG 目标保存 |
| vips_ppmsave_target | PPM 目标保存 |
| vips_radsave_target | RAD 目标保存 |
| vips_rawsave_target | RAW 目标保存 |
| vips_webpsave_target | WebP 目标保存 |

**不实现原因**: 当前优先支持 file 和 buffer 变体，source/target 变体需要 VipsSource/VipsTarget 绑定。

---

## 3. 特殊格式加载器

这些是特定文件格式的加载器，部分未常用或需要特殊依赖。

| 函数 | 状态 | 说明 |
|------|------|------|
| vips_analyzeload | ❌ | Analyze 医学图像格式 |
| vips_csvload / vips_csvsave | ❌ | CSV 数据格式 |
| vips_fitsload / vips_fitssave | ❌ | FITS 天文图像格式 |
| vips_matload | ❌ | Matlab 格式 |
| vips_matrixload / vips_matrixsave | ❌ | VIPS matrix 格式 |
| vips_ppmload / vips_ppmsave | ❌ | PPM/PGM/PBM 格式 |

**不实现原因**: 非常用格式，按需添加。

---

## 4. 其他未实现函数

### 缓存/辅助函数

| 函数 | 状态 | 说明 |
|------|------|------|
| vips_linecache | ❌ | 行缓存 |
| vips_tilecache | ❌ | 瓦片缓存 |
| vips_cache_operation_build | ❌ | 操作缓存构建 |

### 特殊操作

| 函数 | 状态 | 说明 |
|------|------|------|
| vips_case | ❌ | 条件选择 (switch) |
| vips_switch | ❌ | 多路选择 |
| vips_clamp | ❌ | 值域限制 |
| vips_profile | ❌ | 行/列剖面 |
| vips_project | ❌ | 投影 |
| vips_hough_circle | ❌ | 霍夫圆检测 |
| vips_hough_line | ❌ | 霍夫线检测 |
| vips_bandrank | ❌ | 波段排序 |
| vips_arrayjoin | ❌ | 数组拼接 |
| vips_matrixinvert | ❌ | 矩阵求逆 |
| vips_matrixmultiply | ❌ | 矩阵乘法 |
| vips_matrixprint | ❌ | 矩阵打印 |
| vips_float2rad | ❌ | float 转 RAD |
| vips_rad2float | ❌ | RAD 转 float |
| vips_dzsave | ❌ | DeepZoom 保存 |
| vips_dzsave_buffer | ❌ | DeepZoom buffer 保存 |
| vips_profile_load | ❌ | ICC profile 加载 |
| vips_system | ❌ | 系统命令执行 |

---

## 5. 已实现但未单独列出

以下函数已通过基础函数实现，但在 `api-function-todo.md` 中合并统计：

| 基础函数 | 包含的便捷函数 |
|----------|---------------|
| vips_boolean | vips_andimage, vips_orimage, vips_eorimage, vips_lshift, vips_rshift |
| vips_relational | vips_equal, vips_notequal, vips_less, vips_lesseq, vips_more, vips_moreeq |
| vips_complex | vips_polar, vips_rect, vips_conj |
| vips_complexget | vips_real, vips_imag |
| vips_round | vips_floor, vips_ceil, vips_rint |
| vips_extract_area | vips_crop |

---

## 6. 实现建议与替代方案

### ✅ 已实现（高价值函数）

| 函数 | 状态 | 位置 |
|------|------|------|
| `vips_clamp` | ✅ 已实现 | arithmetic_bindings |
| `vips_arrayjoin` | ✅ 已实现 | conversion_bindings |
| `vips_dzsave` | ✅ 已实现 | io_bindings |
| `vips_hough_circle` | ✅ 已实现 | arithmetic_bindings |
| `vips_hough_line` | ✅ 已实现 | arithmetic_bindings |
| `vips_profile` | ✅ 已实现 | arithmetic_bindings |
| `vips_project` | ✅ 已实现 | arithmetic_bindings |

### ❌ 不需要实现（有替代方案）

| 函数 | 替代方案 |
|------|----------|
| `vips_cast_uchar` | `vips_cast(img, VipsBandFormat.uchar)` |
| `vips_cast_char` | `vips_cast(img, VipsBandFormat.char)` |
| `vips_cast_ushort` | `vips_cast(img, VipsBandFormat.ushort)` |
| `vips_cast_short` | `vips_cast(img, VipsBandFormat.short)` |
| `vips_cast_uint` | `vips_cast(img, VipsBandFormat.uint)` |
| `vips_cast_int` | `vips_cast(img, VipsBandFormat.int)` |
| `vips_cast_float` | `vips_cast(img, VipsBandFormat.float)` |
| `vips_cast_double` | `vips_cast(img, VipsBandFormat.double)` |
| `vips_cast_complex` | `vips_cast(img, VipsBandFormat.complex)` |
| `vips_cast_dpcomplex` | `vips_cast(img, VipsBandFormat.dpcomplex)` |
| `vips_asin` | `vips_math(img, VipsOperationMath.asin)` |
| `vips_acos` | `vips_math(img, VipsOperationMath.acos)` |
| `vips_atan` | `vips_math(img, VipsOperationMath.atan)` |
| `vips_sinh` | `vips_math(img, VipsOperationMath.sinh)` |
| `vips_cosh` | `vips_math(img, VipsOperationMath.cosh)` |
| `vips_tanh` | `vips_math(img, VipsOperationMath.tanh)` |
| `vips_asinh` | `vips_math(img, VipsOperationMath.asinh)` |
| `vips_acosh` | `vips_math(img, VipsOperationMath.acosh)` |
| `vips_atanh` | `vips_math(img, VipsOperationMath.atanh)` |
| `vips_atan2` | `vips_math2(img1, img2, VipsOperationMath2.atan2)` |
| `vips_wop` | `vips_math2(img1, img2, VipsOperationMath2.wop)` |
| `vips_crop` | `vips_extract_area(img, left, top, width, height)` - 完全等价 |
| `vips_bandjoin_const1` | `vips_bandjoin_const(img, [value])` |

### ⏸️ 暂不实现（低优先级/特殊依赖）

| 函数 | 原因 |
|------|------|
| `vips_*load_source` | 需要 VipsSource 绑定，流式 API 暂不支持 |
| `vips_*save_target` | 需要 VipsTarget 绑定，流式 API 暂不支持 |
| `vips_analyzeload` | Analyze 医学格式，需求极少 |
| `vips_csvload/save` | CSV 数据格式，非图像处理 |
| `vips_fitsload/save` | FITS 天文格式，需求极少 |
| `vips_matload` | Matlab 格式，需求极少 |
| `vips_matrixload/save` | VIPS 内部 matrix 格式 |
| `vips_ppmload/save` | PPM 格式较旧，可用 PNG 替代 |
| `vips_linecache` | 内部缓存优化，用户无需直接调用 |
| `vips_tilecache` | 内部缓存优化，用户无需直接调用 |
| `vips_matrixinvert` | 矩阵操作，非核心图像处理 |
| `vips_matrixmultiply` | 矩阵操作，非核心图像处理 |
| `vips_matrixprint` | 调试用，非核心功能 |
| `vips_float2rad` | RAD 格式转换，需求极少 |
| `vips_rad2float` | RAD 格式转换，需求极少 |
| `vips_system` | 执行系统命令，安全风险 |
| `vips_case` | 复杂条件选择，可用 ifthenelse 组合 |
| `vips_switch` | 多路选择，可用多次 ifthenelse |

### 📝 替代方案示例代码

```dart
// 替代 vips_cast_uchar
pipeline.cast(VipsBandFormat.uchar);

// 替代 vips_asin  
pipeline.math(VipsOperationMath.asin);

// 替代 vips_crop (完全等价于 extract_area)
pipeline.extractArea(left, top, width, height);

// 替代 vips_case/switch (使用多次 ifthenelse)
pipeline
  .ifthenelse(condition1, result1)
  .ifthenelse(condition2, result2);
```

---

## 总结

| 类别 | 数量 | 备注 |
|------|------|------|
| 已实现 | 306 | 核心操作全覆盖 |
| 便捷函数（可选） | ~50 | 通过基础函数 + 枚举替代 |
| Source/Target | ~40 | 需要流式绑定支持 |
| 特殊格式 | ~10 | 按需添加 |
| 辅助/特殊 | ~13 | 按需添加 |

**核心 API 覆盖率**: 306/306 = **100%**（按操作符统计）

**全函数覆盖率**: 306/419 ≈ **73%**（按 C 函数统计）

---

*文档更新时间: 2025-01*
