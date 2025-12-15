import 'dart:ffi';
import 'dart:io';

import 'package:libvips_ffi_core/libvips_ffi_core.dart';

/// macOS 库加载器
///
/// 加载预编译的 macOS libvips 库。
/// 自动检测 CPU 架构 (arm64/x86_64) 并加载对应的库。
/// 当预编译库不可用时，会回退到系统库。
class MacosVipsLoader implements VipsLibraryLoader {
  /// 获取预编译库路径
  static List<String> _getBundledLibraryPaths() {
    final paths = <String>[];
    
    // Get the executable path and derive Frameworks directory
    final executable = Platform.resolvedExecutable;
    final execDir = File(executable).parent.path;
    final frameworksDir = '$execDir/../Frameworks';
    
    // Primary path: Frameworks directory in app bundle
    paths.add('$frameworksDir/libvips.42.dylib');
    
    // Fallback: try @rpath (works for some configurations)
    paths.add('@rpath/libvips.42.dylib');
    
    return paths;
  }

  @override
  DynamicLibrary load() {
    // 首先尝试加载预编译库
    final paths = _getBundledLibraryPaths();
    final errors = <String>[];
    
    for (final path in paths) {
      try {
        final lib = DynamicLibrary.open(path);
        // ignore: avoid_print
        print('[MacosVipsLoader] Loaded libvips from: $path');
        return lib;
      } catch (e) {
        errors.add('$path: $e');
      }
    }

    // 打印所有尝试的路径和错误
    // ignore: avoid_print
    print('[MacosVipsLoader] Failed to load bundled library:');
    for (final error in errors) {
      // ignore: avoid_print
      print('  - $error');
    }

    // 回退到系统库
    // ignore: avoid_print
    print('[MacosVipsLoader] Falling back to system library...');
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
  static String get currentArchitecture {
    try {
      final result = Process.runSync('uname', ['-m']);
      if (result.exitCode == 0) {
        return (result.stdout as String).trim();
      }
    } catch (_) {}
    return 'arm64';
  }
}

/// 初始化 libvips (macOS)
///
/// 使用预编译库或系统库初始化 libvips。
/// 自动检测 CPU 架构并加载对应的库。
void initVipsMacos([String appName = 'libvips_ffi']) {
  initVipsWithLoader(MacosVipsLoader(), appName);
}
