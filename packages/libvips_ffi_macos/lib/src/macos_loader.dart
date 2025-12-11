import 'dart:ffi';
import 'dart:io';

import 'package:libvips_ffi_core/libvips_ffi_core.dart';

/// 获取当前 CPU 架构
String _getCpuArchitecture() {
  // 使用 uname -m 获取 CPU 架构
  try {
    final result = Process.runSync('uname', ['-m']);
    if (result.exitCode == 0) {
      final arch = (result.stdout as String).trim();
      // arm64 或 x86_64
      return arch;
    }
  } catch (_) {}
  
  // 默认返回 arm64 (Apple Silicon)
  return 'arm64';
}

/// macOS 库加载器
///
/// 加载预编译的 macOS libvips 库。
/// 自动检测 CPU 架构 (arm64/x86_64) 并加载对应的库。
/// 当预编译库不可用时，会回退到系统库。
class MacosVipsLoader implements VipsLibraryLoader {
  /// 获取当前架构的预编译库路径
  static List<String> _getBundledLibraryPaths() {
    final arch = _getCpuArchitecture();
    return [
      // Flutter macOS app bundle - 架构特定
      '@executable_path/../Frameworks/$arch/libvips.42.dylib',
      // Flutter macOS app bundle - 通用
      '@executable_path/../Frameworks/libvips.42.dylib',
      // Relative to executable - 架构特定
      'Libraries/$arch/libvips.42.dylib',
      // Relative to package - 架构特定
      'packages/libvips_ffi_macos/macos/Libraries/$arch/libvips.42.dylib',
    ];
  }

  @override
  DynamicLibrary load() {
    // 首先尝试加载预编译库
    final paths = _getBundledLibraryPaths();
    for (final path in paths) {
      try {
        return DynamicLibrary.open(path);
      } catch (_) {
        // 继续尝试下一个路径
      }
    }

    // 回退到系统库
    return SystemVipsLoader().load();
  }

  @override
  bool isAvailable() {
    if (!Platform.isMacOS) return false;
    try {
      load();
      return true;
    } catch (_) {
      return false;
    }
  }
  
  /// 获取当前检测到的 CPU 架构
  static String get currentArchitecture => _getCpuArchitecture();
}

/// 初始化 libvips (macOS)
///
/// 使用预编译库或系统库初始化 libvips。
/// 自动检测 CPU 架构并加载对应的库。
void initVipsMacos([String appName = 'libvips_ffi']) {
  initVipsWithLoader(MacosVipsLoader(), appName);
}
