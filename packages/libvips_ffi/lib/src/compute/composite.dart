import 'package:libvips_ffi_core/libvips_ffi_core.dart';

import '../platform_loader.dart';
import 'types.dart';

// ============ Composite Operations ============
// ============ 合成操作 ============

/// Parameters for collage creation.
///
/// 创建拼接的参数。
class CollageParams {
  final List<CollageItemData> items;
  final int canvasWidth;
  final int canvasHeight;
  final int backgroundColor;

  CollageParams({
    required this.items,
    required this.canvasWidth,
    required this.canvasHeight,
    required this.backgroundColor,
  });
}

/// Creates a collage from multiple images.
///
/// 从多张图像创建拼接。
VipsComputeResult createCollage(CollageParams p) {
  initVips();
  
  // Extract RGB from background color
  final r = (p.backgroundColor >> 16) & 0xFF;
  final g = (p.backgroundColor >> 8) & 0xFF;
  final b = p.backgroundColor & 0xFF;
  
  // Create canvas with solid color background (3-band RGB)
  var canvas = VipsImageWrapper.solidColor(p.canvasWidth, p.canvasHeight, r: r, g: g, b: b);
  
  // Debug: print canvas info
  // ignore: avoid_print
  print('[_createCollage] Canvas created: ${canvas.width}x${canvas.height}, bands=${canvas.bands}');
  
  // Keep track of all images to dispose after writing
  // This is important because libvips uses lazy loading
  final imagesToDispose = <VipsImageWrapper>[canvas];
  
  // Insert each image onto the canvas
  for (int i = 0; i < p.items.length; i++) {
    final item = p.items[i];
    // Load the image
    var img = VipsImageWrapper.fromBuffer(item.imageData);
    imagesToDispose.add(img);
    
    // ignore: avoid_print
    print('[_createCollage] Image $i loaded: ${img.width}x${img.height}, bands=${img.bands}');
    
    // Convert to 3-band sRGB if needed
    // First, convert to sRGB color space to handle CMYK and other formats
    if (img.bands >= 3) {
      try {
        final srgb = img.colourspace(VipsInterpretation.srgb);
        imagesToDispose.add(srgb);
        // ignore: avoid_print
        print('[_createCollage] Image $i converted to sRGB: ${srgb.bands} bands');
        
        // If still has alpha (4 bands), flatten it
        if (srgb.bands == 4) {
          final flattened = srgb.flatten();
          imagesToDispose.add(flattened);
          img = flattened;
          // ignore: avoid_print
          print('[_createCollage] Image $i flattened to ${img.bands} bands');
        } else {
          img = srgb;
        }
      } catch (e) {
        // ignore: avoid_print
        print('[_createCollage] Image $i colourspace conversion failed: $e');
      }
    }
    
    // Calculate scale to fit target dimensions
    final scaleX = item.width / img.width;
    final scaleY = item.height / img.height;
    final scale = scaleX < scaleY ? scaleX : scaleY;
    
    // Resize if needed
    VipsImageWrapper resized;
    if ((scale - 1.0).abs() > 0.01) {
      resized = img.resize(scale);
      imagesToDispose.add(resized);
      // ignore: avoid_print
      print('[_createCollage] Image $i resized: ${resized.width}x${resized.height} (scale=$scale)');
    } else {
      resized = img;
    }
    
    // ignore: avoid_print
    print('[_createCollage] Inserting image $i at (${item.x}, ${item.y})');
    
    // Insert into canvas
    final newCanvas = canvas.insert(resized, item.x, item.y);
    imagesToDispose.add(newCanvas);
    canvas = newCanvas;
    
    // ignore: avoid_print
    print('[_createCollage] Canvas after insert: ${canvas.width}x${canvas.height}');
  }
  
  // Write result to buffer BEFORE disposing any images
  final data = canvas.writeToBuffer('.png');
  final output = VipsComputeResult(
    data: data,
    width: canvas.width,
    height: canvas.height,
    bands: canvas.bands,
  );
  
  // Now dispose all images
  for (final img in imagesToDispose) {
    img.dispose();
  }
  
  return output;
}
