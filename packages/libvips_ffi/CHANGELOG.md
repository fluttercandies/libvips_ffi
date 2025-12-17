# Changelog

All notable changes to this project will be documented in this file.

## Version Format

`<plugin_version>+<libvips_version>`

- Plugin version follows [Semantic Versioning](https://semver.org/)
- Build metadata (`+8.16.0`) indicates the bundled libvips version

---

## 0.1.1+8.16.0

### Added

- **Image join support**: `VipsPipelineCompute.executeJoin()` and `executeJoinToFile()` for combining multiple images
- **JoinPipelineSpec**: Serializable spec for joining images vertically or horizontally
- **JoinPipelineComputeParams**: Parameters for join operations in isolate

---

## 0.1.0+8.16.0

### Added

- **libvips_ffi_api package**: High-level Dart API with Pipeline-style chainable operations
- **VipsPipeline API**: Synchronous chainable image processing API
- **VipsPipelineCompute API**: Async processing API using Flutter's `compute()`
- **PipelineSpec API**: Serializable pipeline definitions with JSON support
- **New FFI bindings**: `vips_clamp`, `vips_hough_circle`, `vips_hough_line`, `vips_profile`, `vips_project`, `vips_dzsave`
- **Pipeline extensions**: `clamp()`, `houghCircle()`, `houghLine()`, `toDeepZoom()`
- **Multi-image operations**: Boolean operations, statistics methods, convolution methods
- **Image collage**: Support for creating image collages

### Changed

- **Architecture refactor**: Split into `libvips_ffi_core` (pure Dart FFI) and `libvips_ffi_api` (high-level API)
- **API migration**: Migrated from `VipsCompute` to `VipsPipelineCompute`
- **Code refactor**: Converted image mixins to Dart extensions
- **VarArgs support**: Implemented support for libvips variadic functions

### Documentation

- Updated all documentation to use VipsPipeline API
- Added API function comparison document
- Improved package family documentation

---

## 0.0.1+8.16.0

### Features

- **High-performance image processing** using libvips FFI bindings
- **Cross-platform support** for Android (arm64-v8a, armeabi-v7a, x86_64) and iOS
- **Sync API** via `VipsPipeline` for fluent chainable image operations
- **Async API** via `VipsPipelineCompute` using Flutter's `compute()` for isolate-based processing
- **Spec API** via `PipelineSpec` for serializable pipeline definitions

### Image Operations

- Load/save images from files and memory buffers
- Resize, thumbnail, rotate, crop, flip
- Gaussian blur, sharpen, invert
- Brightness and contrast adjustment
- Auto-rotate based on EXIF orientation
- Smart crop (attention-based)
- Colorspace conversion (grayscale, sRGB, etc.)
- Format conversion (JPEG, PNG, WebP, etc.)

### Supported Platforms

- **Android**: arm64-v8a, armeabi-v7a, x86_64 (all 64-bit libraries are 16KB aligned for Android 15+ compatibility)
- **iOS**: arm64 (device), arm64 (simulator on Apple Silicon Mac)
  - Minimum iOS version: 12.0
  - Note: x86_64 simulator (Intel Mac) is not supported
