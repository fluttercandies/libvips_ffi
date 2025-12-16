import 'dart:typed_data';

import '../image/vips_img.dart';

/// Chainable image processing pipeline.
///
/// Internal operations keep VipsImg objects, only converting to buffer on output.
/// This follows the sharp (Node.js) API style for intuitive image processing.
class VipsPipeline {
  VipsImg _image;

  VipsPipeline._(this._image);

  /// Create pipeline from file.
  factory VipsPipeline.fromFile(String path) {
    return VipsPipeline._(VipsImg.fromFile(path));
  }

  /// Create pipeline from buffer.
  factory VipsPipeline.fromBuffer(Uint8List data) {
    return VipsPipeline._(VipsImg.fromBuffer(data));
  }

  /// Create pipeline from existing VipsImg (takes ownership).
  factory VipsPipeline.fromImage(VipsImg image) {
    return VipsPipeline._(image);
  }

  // ======= Internal Methods =======

  /// Get the current image (for extension methods).
  VipsImg get image => _image;

  /// Replace current image with new one, disposing old.
  void replaceImage(VipsImg newImage) {
    final old = _image;
    _image = newImage;
    old.dispose();
  }

  // ======= Output Methods =======

  /// Output as buffer (triggers encoding).
  Uint8List toBuffer({String format = '.png'}) {
    final data = _image.writeToBuffer(format);
    dispose();
    return data;
  }

  /// Output as JPEG buffer.
  Uint8List toJpeg({int quality = 75}) {
    final suffix = quality != 75 ? '.jpg[Q=$quality]' : '.jpg';
    return toBuffer(format: suffix);
  }

  /// Output as PNG buffer.
  Uint8List toPng({int compression = 6}) {
    final suffix = compression != 6 ? '.png[compression=$compression]' : '.png';
    return toBuffer(format: suffix);
  }

  /// Output as WebP buffer.
  Uint8List toWebp({int quality = 75, bool lossless = false}) {
    var suffix = '.webp';
    final params = <String>[];
    if (quality != 75) params.add('Q=$quality');
    if (lossless) params.add('lossless=1');
    if (params.isNotEmpty) suffix = '.webp[${params.join(',')}]';
    return toBuffer(format: suffix);
  }

  /// Write to file.
  void toFile(String path) {
    _image.writeToFile(path);
    dispose();
  }

  /// Get current image without disposing pipeline.
  /// Caller takes ownership of returned VipsImg.
  VipsImg getImage() {
    final img = _image.copy();
    return img;
  }

  /// Create checkpoint (returns buffer, pipeline continues).
  Uint8List checkpoint({String format = '.png'}) {
    return _image.writeToBuffer(format);
  }

  /// Dispose pipeline and free resources.
  void dispose() {
    if (!_image.isDisposed) {
      _image.dispose();
    }
  }

  // ======= Properties =======

  int get width => _image.width;
  int get height => _image.height;
  int get bands => _image.bands;
  bool get hasAlpha => _image.hasAlpha;
  bool get isDisposed => _image.isDisposed;

  @override
  String toString() {
    if (isDisposed) return 'VipsPipeline(disposed)';
    return 'VipsPipeline(${width}x$height, $bands bands)';
  }
}
