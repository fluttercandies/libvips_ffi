import 'dart:ffi';
import 'dart:io';

/// Loads the libvips dynamic library based on the current platform.
///
/// 根据当前平台加载 libvips 动态库。
///
/// Platform-specific behavior:
/// 平台特定行为：
///
/// - **Android**: Loads `libvips.so` from jniLibs directory.
///   **Android**：从 jniLibs 目录加载 `libvips.so`。
///
/// - **iOS**: Uses `DynamicLibrary.process()` for statically linked library.
///   **iOS**：使用 `DynamicLibrary.process()` 加载静态链接的库。
///
/// Throws [UnsupportedError] if the platform is not supported.
/// 如果平台不受支持，则抛出 [UnsupportedError]。
///
/// Returns the loaded [DynamicLibrary] instance.
/// 返回加载的 [DynamicLibrary] 实例。
DynamicLibrary loadVipsLibrary() {
  if (Platform.isAndroid) {
    return DynamicLibrary.open('libvips.so');
  } else if (Platform.isIOS) {
    // iOS uses static linking, symbols are in the main process
    return DynamicLibrary.process();
  }
  throw UnsupportedError(
    'Unsupported platform: ${Platform.operatingSystem}. '
    'Only Android and iOS are supported.',
  );
}

/// Cached library instance for lazy initialization.
///
/// 用于延迟初始化的缓存库实例。
DynamicLibrary? _cachedLibrary;

/// Gets the libvips library instance (lazy loaded and cached).
///
/// 获取 libvips 库实例（延迟加载并缓存）。
///
/// The library is loaded on first access and cached for subsequent calls.
/// 库在首次访问时加载，并为后续调用缓存。
///
/// Returns the cached [DynamicLibrary] instance.
/// 返回缓存的 [DynamicLibrary] 实例。
DynamicLibrary get vipsLibrary {
  return _cachedLibrary ??= loadVipsLibrary();
}
