/// Flutter FFI bindings for libvips image processing library.
///
/// libvips 图像处理库的 Flutter FFI 绑定。
///
/// This library provides Dart bindings for the libvips image processing
/// library, allowing you to perform high-performance image operations
/// in Flutter applications.
/// 此库为 libvips 图像处理库提供 Dart 绑定，允许你在 Flutter 应用程序中
/// 执行高性能图像操作。
///
/// ## Getting Started / 入门
///
/// ```dart
/// import 'package:libvips_ffi/libvips_ffi.dart';
///
/// void main() {
///   initVips();
///   // Your code here / 你的代码
///   shutdownVips();
/// }
/// ```
///
/// ## Synchronous API / 同步 API
///
/// Use [VipsPipeline] for synchronous image processing:
/// 使用 [VipsPipeline] 进行同步图像处理：
///
/// ```dart
/// final pipeline = VipsPipeline.fromFile('input.jpg')
///   ..resize(0.5)
///   ..gaussblur(2.0);
/// pipeline.toFile('output.jpg');
/// pipeline.dispose();
/// ```
///
/// ## Asynchronous API / 异步 API
///
/// For async operations that don't block the UI thread, use [VipsPipelineCompute]:
/// 对于不阻塞 UI 线程的异步操作，使用 [VipsPipelineCompute]：
///
/// ```dart
/// final result = await VipsPipelineCompute.processFile(
///   'input.jpg',
///   (p) => p.resize(0.5).gaussblur(2.0),
/// );
/// ```
///
/// ## Supported Operations / 支持的操作
///
/// - **Resize / 调整大小** - Scale images up or down / 放大或缩小图像
/// - **Thumbnail / 缩略图** - Efficient thumbnail generation / 高效缩略图生成
/// - **Rotate / 旋转** - Rotate by any angle / 按任意角度旋转
/// - **Crop / 裁剪** - Extract regions from images / 从图像提取区域
/// - **Flip / 翻转** - Horizontal or vertical flip / 水平或垂直翻转
/// - **Blur / 模糊** - Gaussian blur / 高斯模糊
/// - **Sharpen / 锐化** - Unsharp masking / 反锐化蒙版
/// - **Colour space / 色彩空间** - Convert between colour spaces / 色彩空间转换
/// - **Brightness/Contrast / 亮度/对比度** - Adjust image levels / 调整图像级别
/// - And more... / 更多...
library libvips_ffi;

// Re-export everything from core package
// 重新导出 core 包的所有内容
export 'package:libvips_ffi_core/libvips_ffi_core.dart';

// Export platform loader and initVips function
// 导出平台加载器和 initVips 函数
export 'src/platform_loader.dart' show PlatformVipsLoader, initVips;

// Export compute-based async API (uses Flutter's compute).
// 导出基于 compute 的异步 API（使用 Flutter 的 compute）。
export 'src/compute/types.dart' show VipsComputeResult;
export 'src/compute/pipeline_compute.dart' show VipsPipelineCompute;

// Re-export api package for pipeline-based processing.
// 重新导出 api 包，用于基于管道的处理。
// Note: Extensions are automatically available when VipsPipeline is in scope.
// 注意：当 VipsPipeline 在作用域内时，扩展自动可用。
export 'package:libvips_ffi_api/libvips_ffi_api.dart'
    hide
        // Hide conflicting/duplicate names from core
        vipsVersion,
        vipsVersionString,
        initVipsApi,
        shutdownVipsApi,
        VipsApiException;
