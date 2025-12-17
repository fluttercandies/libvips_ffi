import 'package:libvips_ffi/libvips_ffi.dart';

/// Example category for grouping operations.
class ExampleCategory {
  final String id;
  final String title;
  final String titleZh;
  final String description;
  final List<CategoryExample> examples;

  const ExampleCategory({
    required this.id,
    required this.title,
    required this.titleZh,
    required this.description,
    required this.examples,
  });
}

/// Example item definition for category-based examples.
class CategoryExample {
  final String title;
  final String description;
  final String code;
  final String asyncCode;
  final VipsPipeline Function(VipsPipeline) operation;
  final PipelineSpec Function(String path)? specBuilder;

  const CategoryExample({
    required this.title,
    required this.description,
    required this.code,
    required this.asyncCode,
    required this.operation,
    this.specBuilder,
  });
}

/// All example categories organized by API type.
final List<ExampleCategory> exampleCategories = [
  // ======= Common Operations =======
  ExampleCategory(
    id: 'common',
    title: 'Common',
    titleZh: '常用操作',
    description: 'Frequently used image processing operations',
    examples: [
      CategoryExample(
        title: 'Resize / 调整大小',
        description: 'Scale image by a factor (0.5 = half size)',
        code: '''
final pipeline = VipsPipeline.fromFile('input.jpg');
pipeline.resize(0.5);  // 50% size
pipeline.toFile('output.jpg');
pipeline.dispose();''',
        asyncCode: '''
final spec = PipelineSpec()
  .input('input.jpg')
  .resize(0.5)
  .outputPng();
final result = await VipsPipelineCompute.execute(spec);''',
        operation: (p) => p.resize(0.5),
        specBuilder: (path) => PipelineSpec().input(path).resize(0.5).outputPng(),
      ),
      CategoryExample(
        title: 'Thumbnail / 缩略图',
        description: 'Create thumbnail with target width',
        code: '''
final pipeline = VipsPipeline.fromFile('input.jpg');
pipeline.thumbnail(200);  // 200px width
pipeline.toFile('thumb.jpg');
pipeline.dispose();''',
        asyncCode: '''
final spec = PipelineSpec()
  .input('input.jpg')
  .thumbnail(200)
  .outputJpeg(85);
final result = await VipsPipelineCompute.execute(spec);''',
        operation: (p) => p.thumbnail(200),
        specBuilder: (path) => PipelineSpec().input(path).thumbnail(200).outputPng(),
      ),
      CategoryExample(
        title: 'Blur / 模糊',
        description: 'Apply Gaussian blur with sigma value',
        code: '''
final pipeline = VipsPipeline.fromFile('input.jpg');
pipeline.blur(5.0);  // sigma = 5
pipeline.toFile('blurred.jpg');
pipeline.dispose();''',
        asyncCode: '''
final spec = PipelineSpec()
  .input('input.jpg')
  .blur(5.0)
  .outputPng();
final result = await VipsPipelineCompute.execute(spec);''',
        operation: (p) => p.blur(5.0),
        specBuilder: (path) => PipelineSpec().input(path).blur(5.0).outputPng(),
      ),
      CategoryExample(
        title: 'Chain Operations / 链式操作',
        description: 'Combine multiple operations',
        code: '''
final pipeline = VipsPipeline.fromFile('input.jpg');
pipeline
  .resize(0.5)
  .blur(2.0)
  .sharpen();
pipeline.toFile('output.jpg');
pipeline.dispose();''',
        asyncCode: '''
final spec = PipelineSpec()
  .input('input.jpg')
  .resize(0.5)
  .blur(2.0)
  .sharpen()
  .outputPng();
final result = await VipsPipelineCompute.execute(spec);''',
        operation: (p) => p.resize(0.5).blur(2.0).sharpen(),
        specBuilder: (path) => PipelineSpec()
            .input(path)
            .resize(0.5)
            .blur(2.0)
            .sharpen()
            .outputPng(),
      ),
    ],
  ),

  // ======= Resample =======
  ExampleCategory(
    id: 'resample',
    title: 'Resample',
    titleZh: '重采样',
    description: 'Resize, rotate, and resample operations',
    examples: [
      CategoryExample(
        title: 'Resize / 缩放',
        description: 'Scale image by a factor',
        code: '''
pipeline.resize(0.5);  // 50% size
pipeline.resize(2.0);  // 200% size''',
        asyncCode: '''
PipelineSpec().input(path).resize(0.5).outputPng()''',
        operation: (p) => p.resize(0.5),
        specBuilder: (path) => PipelineSpec().input(path).resize(0.5).outputPng(),
      ),
      CategoryExample(
        title: 'Thumbnail / 缩略图',
        description: 'Create thumbnail with target width (maintains aspect ratio)',
        code: '''pipeline.thumbnail(200);  // 200px width''',
        asyncCode: '''PipelineSpec().input(path).thumbnail(200).outputPng()''',
        operation: (p) => p.thumbnail(200),
        specBuilder: (path) => PipelineSpec().input(path).thumbnail(200).outputPng(),
      ),
      CategoryExample(
        title: 'Rotate / 旋转',
        description: 'Rotate image by angle in degrees',
        code: '''
pipeline.rotate(90);   // 90 degrees
pipeline.rotate(45);   // 45 degrees
pipeline.rotate(-30);  // -30 degrees''',
        asyncCode: '''PipelineSpec().input(path).rotate(90).outputPng()''',
        operation: (p) => p.rotate(90),
        specBuilder: (path) => PipelineSpec().input(path).rotate(90).outputPng(),
      ),
      CategoryExample(
        title: 'Reduce / 降采样',
        description: 'Reduce image size by factor',
        code: '''pipeline.reduce(2.0, 2.0);  // Half size''',
        asyncCode: '''PipelineSpec().input(path).reduce(2.0, 2.0).outputPng()''',
        operation: (p) => p.reduce(2.0, 2.0),
        specBuilder: (path) => PipelineSpec().input(path).reduce(2.0, 2.0).outputPng(),
      ),
      CategoryExample(
        title: 'Shrink / 收缩',
        description: 'Shrink image by integer factor',
        code: '''pipeline.shrink(2.0, 2.0);  // Half size (fast)''',
        asyncCode: '''PipelineSpec().input(path).shrink(2.0, 2.0).outputPng()''',
        operation: (p) => p.shrink(2.0, 2.0),
        specBuilder: (path) => PipelineSpec().input(path).shrink(2.0, 2.0).outputPng(),
      ),
      CategoryExample(
        title: 'Rot90 / 90度旋转',
        description: 'Rotate image by 90 degrees (lossless)',
        code: '''
pipeline.rot90();   // 90 degrees clockwise
pipeline.rot180();  // 180 degrees
pipeline.rot270();  // 270 degrees''',
        asyncCode: '''PipelineSpec().input(path).rot90().outputPng()''',
        operation: (p) => p.rot90(),
        specBuilder: (path) => PipelineSpec().input(path).rot90().outputPng(),
      ),
    ],
  ),

  // ======= Conversion =======
  ExampleCategory(
    id: 'conversion',
    title: 'Conversion',
    titleZh: '转换',
    description: 'Crop, flip, and format conversion',
    examples: [
      CategoryExample(
        title: 'Crop / 裁剪',
        description: 'Extract a rectangular region',
        code: '''pipeline.crop(100, 100, 200, 200);  // left, top, width, height''',
        asyncCode: '''PipelineSpec().input(path).crop(0, 0, 200, 200).outputPng()''',
        operation: (p) {
          final size = p.image.width < p.image.height ? p.image.width : p.image.height;
          return p.crop(0, 0, size ~/ 2, size ~/ 2);
        },
        specBuilder: (path) => PipelineSpec().input(path).crop(0, 0, 200, 200).outputPng(),
      ),
      CategoryExample(
        title: 'Smart Crop / 智能裁剪',
        description: 'Crop to focus on the most interesting part',
        code: '''pipeline.smartCrop(300, 300);  // width, height''',
        asyncCode: '''PipelineSpec().input(path).smartCrop(300, 300).outputPng()''',
        operation: (p) {
          final size = p.image.width < p.image.height ? p.image.width ~/ 2 : p.image.height ~/ 2;
          return p.smartCrop(size, size);
        },
        specBuilder: (path) => PipelineSpec().input(path).smartCrop(300, 300).outputPng(),
      ),
      CategoryExample(
        title: 'Flip Horizontal / 水平翻转',
        description: 'Mirror image horizontally',
        code: '''pipeline.flip(VipsDirection.horizontal);''',
        asyncCode: '''PipelineSpec().input(path).flipHorizontal().outputPng()''',
        operation: (p) => p.flip(VipsDirection.horizontal),
        specBuilder: (path) => PipelineSpec().input(path).flipHorizontal().outputPng(),
      ),
      CategoryExample(
        title: 'Flip Vertical / 垂直翻转',
        description: 'Flip image vertically',
        code: '''pipeline.flip(VipsDirection.vertical);''',
        asyncCode: '''PipelineSpec().input(path).flipVertical().outputPng()''',
        operation: (p) => p.flip(VipsDirection.vertical),
        specBuilder: (path) => PipelineSpec().input(path).flipVertical().outputPng(),
      ),
      CategoryExample(
        title: 'Embed / 嵌入',
        description: 'Embed image in larger canvas',
        code: '''pipeline.embed(50, 50, 400, 400);  // x, y, width, height''',
        asyncCode: '''PipelineSpec().input(path).embed(50, 50, 400, 400).outputPng()''',
        operation: (p) => p.embed(50, 50, p.image.width + 100, p.image.height + 100),
        specBuilder: (path) => PipelineSpec().input(path).embed(50, 50, 400, 400).outputPng(),
      ),
      CategoryExample(
        title: 'Zoom / 放大',
        description: 'Integer zoom (pixel doubling)',
        code: '''pipeline.zoom(2, 2);  // 2x zoom''',
        asyncCode: '''PipelineSpec().input(path).zoom(2, 2).outputPng()''',
        operation: (p) => p.thumbnail(100).zoom(2, 2),
        specBuilder: (path) => PipelineSpec().input(path).thumbnail(100).zoom(2, 2).outputPng(),
      ),
      CategoryExample(
        title: 'Auto Rotate / 自动旋转',
        description: 'Rotate based on EXIF orientation',
        code: '''pipeline.autoRotate();''',
        asyncCode: '''PipelineSpec().input(path).autoRotate().outputPng()''',
        operation: (p) => p.autoRotate(),
        specBuilder: (path) => PipelineSpec().input(path).autoRotate().outputPng(),
      ),
      CategoryExample(
        title: 'Flatten / 扁平化',
        description: 'Remove alpha channel with background color',
        code: '''pipeline.flatten();''',
        asyncCode: '''PipelineSpec().input(path).flatten().outputPng()''',
        operation: (p) => p.flatten(),
        specBuilder: (path) => PipelineSpec().input(path).flatten().outputPng(),
      ),
    ],
  ),

  // ======= Convolution =======
  ExampleCategory(
    id: 'convolution',
    title: 'Convolution',
    titleZh: '卷积',
    description: 'Blur, sharpen, and edge detection',
    examples: [
      CategoryExample(
        title: 'Blur / 模糊',
        description: 'Gaussian blur with sigma value',
        code: '''
pipeline.blur(2.0);   // Slight blur
pipeline.blur(5.0);   // Medium blur
pipeline.blur(10.0);  // Heavy blur''',
        asyncCode: '''PipelineSpec().input(path).blur(5.0).outputPng()''',
        operation: (p) => p.blur(5.0),
        specBuilder: (path) => PipelineSpec().input(path).blur(5.0).outputPng(),
      ),
      CategoryExample(
        title: 'Sharpen / 锐化',
        description: 'Sharpen image using unsharp masking',
        code: '''pipeline.sharpen();''',
        asyncCode: '''PipelineSpec().input(path).sharpen().outputPng()''',
        operation: (p) => p.sharpen(),
        specBuilder: (path) => PipelineSpec().input(path).sharpen().outputPng(),
      ),
      CategoryExample(
        title: 'Sobel / Sobel边缘',
        description: 'Sobel edge detection',
        code: '''pipeline.sobel();''',
        asyncCode: '''PipelineSpec().input(path).sobel().outputPng()''',
        operation: (p) => p.sobel(),
        specBuilder: (path) => PipelineSpec().input(path).sobel().outputPng(),
      ),
      CategoryExample(
        title: 'Canny / Canny边缘',
        description: 'Canny edge detection',
        code: '''pipeline.canny();''',
        asyncCode: '''PipelineSpec().input(path).canny().outputPng()''',
        operation: (p) => p.canny(),
        specBuilder: (path) => PipelineSpec().input(path).canny().outputPng(),
      ),
    ],
  ),

  // ======= Colour =======
  ExampleCategory(
    id: 'colour',
    title: 'Colour',
    titleZh: '颜色',
    description: 'Brightness, contrast, and color adjustments',
    examples: [
      CategoryExample(
        title: 'Brightness / 亮度',
        description: 'Adjust brightness (1.0 = no change)',
        code: '''
pipeline.brightness(1.3);  // +30% brighter
pipeline.brightness(0.7);  // 30% darker''',
        asyncCode: '''PipelineSpec().input(path).brightness(1.3).outputPng()''',
        operation: (p) => p.brightness(1.3),
        specBuilder: (path) => PipelineSpec().input(path).brightness(1.3).outputPng(),
      ),
      CategoryExample(
        title: 'Contrast / 对比度',
        description: 'Adjust contrast (1.0 = no change)',
        code: '''
pipeline.contrast(1.5);  // +50% contrast
pipeline.contrast(0.5);  // -50% contrast''',
        asyncCode: '''PipelineSpec().input(path).contrast(1.5).outputPng()''',
        operation: (p) => p.contrast(1.5),
        specBuilder: (path) => PipelineSpec().input(path).contrast(1.5).outputPng(),
      ),
      CategoryExample(
        title: 'Grayscale / 灰度',
        description: 'Convert image to grayscale',
        code: '''
pipeline.grayscale();
// or
pipeline.colourspace(VipsInterpretation.bw);''',
        asyncCode: '''PipelineSpec().input(path).grayscale().outputPng()''',
        operation: (p) => p.grayscale(),
        specBuilder: (path) => PipelineSpec().input(path).grayscale().outputPng(),
      ),
      CategoryExample(
        title: 'Invert / 反色',
        description: 'Invert image colors (negative effect)',
        code: '''pipeline.invert();''',
        asyncCode: '''PipelineSpec().input(path).invert().outputPng()''',
        operation: (p) => p.invert(),
        specBuilder: (path) => PipelineSpec().input(path).invert().outputPng(),
      ),
      CategoryExample(
        title: 'Gamma / 伽马',
        description: 'Apply gamma correction',
        code: '''pipeline.gamma();''',
        asyncCode: '''PipelineSpec().input(path).gamma().outputPng()''',
        operation: (p) => p.gamma(),
        specBuilder: (path) => PipelineSpec().input(path).gamma().outputPng(),
      ),
    ],
  ),

  // ======= Morphology =======
  ExampleCategory(
    id: 'morphology',
    title: 'Morphology',
    titleZh: '形态学',
    description: 'Morphological operations',
    examples: [
      CategoryExample(
        title: 'Median / 中值滤波',
        description: 'Median filter for noise reduction',
        code: '''pipeline.median(3);  // 3x3 median filter''',
        asyncCode: '''PipelineSpec().input(path).median(3).outputPng()''',
        operation: (p) => p.median(3),
        specBuilder: (path) => PipelineSpec().input(path).median(3).outputPng(),
      ),
      CategoryExample(
        title: 'Rank / 排序滤波',
        description: 'Rank filter (generalized median)',
        code: '''pipeline.rank(3, 3, 4);  // width, height, index''',
        asyncCode: '''PipelineSpec().input(path).rank(3, 3, 4).outputPng()''',
        operation: (p) => p.rank(3, 3, 4),
        specBuilder: (path) => PipelineSpec().input(path).rank(3, 3, 4).outputPng(),
      ),
    ],
  ),

  // ======= Histogram =======
  ExampleCategory(
    id: 'histogram',
    title: 'Histogram',
    titleZh: '直方图',
    description: 'Histogram operations',
    examples: [
      CategoryExample(
        title: 'Hist Equal / 直方图均衡',
        description: 'Histogram equalization for contrast enhancement',
        code: '''pipeline.histEqual();''',
        asyncCode: '''PipelineSpec().input(path).histEqual().outputPng()''',
        operation: (p) => p.histEqual(),
        specBuilder: (path) => PipelineSpec().input(path).histEqual().outputPng(),
      ),
    ],
  ),
];
