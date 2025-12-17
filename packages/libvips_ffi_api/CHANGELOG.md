# Changelog

## 0.1.2+8.16.0

- Add `JoinPipelineSpec` for joining multiple images
  - Support vertical and horizontal join directions
  - Support input from file paths or buffer data
  - `JoinInput`, `JoinInputPath`, `JoinInputBuffer` input classes

## 0.1.1+8.16.0

- Fix `VipsImg.fromBuffer` memory management for libvips lazy evaluation
  - Native buffer is now kept alive until `dispose()` is called
  - Prevents "IDAT stream error" when using images created from buffer

## 0.1.0+8.16.0

- Initial release
- VipsPipeline chainable API
- Core operations: resample, convolution, colour, conversion, composite, foreign, create
