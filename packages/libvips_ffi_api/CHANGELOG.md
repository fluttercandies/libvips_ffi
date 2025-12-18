# Changelog

## 0.1.3+8.16.0

### ✨ New Features

* **Ability to Load Image from Raw Memory Data:**
  * Introduced a new factory constructor `VipsImg.fromRawRgba` to the `VipsImg` class, allowing images to be created directly from raw RGBA or RGB byte arrays (`Uint8List`).
  * This function requires specifying the image `width`, `height`, and number of `bands` (channels, e.g., 3 for RGB, 4 for RGBA).
  * *Note: The input buffer data is copied internally by libvips.*

* **Enhanced `JoinPipelineSpec` for Image Stitching:**
  * `JoinPipelineSpec` now includes an `addInputRawRgba` method, enabling the use of raw RGBA/RGB memory data as an input source for image joining pipelines.
  * Added the corresponding `JoinInputRawRgba` class to encapsulate raw memory inputs.

### 🐛 Bug Fixes / Improvements

* Clarified the description of `JoinInputBuffer` (and its related methods) to explicitly indicate it is for **"Input from buffer data (encoded image like PNG/JPEG)"**, distinguishing it from the new raw data input method.

## 0.1.2+8.16.0

* Add `JoinPipelineSpec` for joining multiple images
  * Support vertical and horizontal join directions
  * Support input from file paths or buffer data
  * `JoinInput`, `JoinInputPath`, `JoinInputBuffer` input classes

## 0.1.1+8.16.0

* Fix `VipsImg.fromBuffer` memory management for libvips lazy evaluation
  * Native buffer is now kept alive until `dispose()` is called
  * Prevents "IDAT stream error" when using images created from buffer

## 0.1.0+8.16.0

* Initial release
* VipsPipeline chainable API
* Core operations: resample, convolution, colour, conversion, composite, foreign, create
