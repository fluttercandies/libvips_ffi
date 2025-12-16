import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import 'bindings/vips_bindings.dart';

/// Global VipsBindings instance from core package.
VipsBindings? _vipsBindings;

/// Global VipsApiBindings instance for variadic functions.
VipsApiBindings? _apiBindings;

/// Global DynamicLibrary instance.
ffi.DynamicLibrary? _vipsLibrary;

/// Whether libvips has been initialized for api package.
bool _initialized = false;

/// Get the core VipsBindings instance.
VipsBindings get vipsBindings {
  if (_vipsBindings == null) {
    throw StateError(
      'libvips_ffi_api not initialized. Call initVipsApi() first.',
    );
  }
  return _vipsBindings!;
}

/// Get the api variadic bindings instance.
VipsApiBindings get apiBindings {
  if (_apiBindings == null) {
    throw StateError(
      'libvips_ffi_api not initialized. Call initVipsApi() first.',
    );
  }
  return _apiBindings!;
}

/// Get the DynamicLibrary instance.
ffi.DynamicLibrary get vipsLibrary {
  if (_vipsLibrary == null) {
    throw StateError(
      'libvips_ffi_api not initialized. Call initVipsApi() first.',
    );
  }
  return _vipsLibrary!;
}

/// Whether the api package has been initialized.
bool get isVipsApiInitialized => _initialized;

/// Initialize libvips api with a DynamicLibrary.
///
/// This should be called after the library is loaded by user code
/// or by platform-specific loader packages.
void initVipsApi(ffi.DynamicLibrary library, [String appName = 'libvips_api']) {
  if (_initialized) return;

  _vipsLibrary = library;
  _vipsBindings = VipsBindings(library);
  _apiBindings = VipsApiBindings(library);

  final appNamePtr = appName.toNativeUtf8();
  try {
    final result = _vipsBindings!.vips_init(appNamePtr.cast());
    if (result != 0) {
      throw VipsApiException('Failed to initialize libvips: ${getVipsError()}');
    }
    _initialized = true;
  } finally {
    calloc.free(appNamePtr);
  }
}

/// Initialize libvips api with a custom lookup function.
///
/// This is useful when symbols are spread across multiple libraries.
void initVipsApiWithLookup(
  ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName) lookup,
  ffi.DynamicLibrary library, [
  String appName = 'libvips_api',
]) {
  if (_initialized) return;

  _vipsLibrary = library;
  _vipsBindings = VipsBindings.fromLookup(lookup);
  _apiBindings = VipsApiBindings(library);

  final appNamePtr = appName.toNativeUtf8();
  try {
    final result = _vipsBindings!.vips_init(appNamePtr.cast());
    if (result != 0) {
      throw VipsApiException('Failed to initialize libvips: ${getVipsError()}');
    }
    _initialized = true;
  } finally {
    calloc.free(appNamePtr);
  }
}

/// Shutdown libvips and free resources.
void shutdownVipsApi() {
  if (!_initialized) return;
  vipsBindings.vips_shutdown();
  _initialized = false;
}

/// Get the current libvips error message.
String? getVipsError() {
  final errorPtr = vipsBindings.vips_error_buffer();
  if (errorPtr == ffi.nullptr) return null;

  try {
    return errorPtr.cast<Utf8>().toDartString();
  } catch (e) {
    try {
      final bytes = <int>[];
      var i = 0;
      while (true) {
        final byte = errorPtr.cast<ffi.Uint8>()[i];
        if (byte == 0) break;
        bytes.add(byte);
        i++;
        if (i > 4096) break;
      }
      return String.fromCharCodes(bytes.where((b) => b < 128));
    } catch (_) {
      return 'Error reading vips error buffer';
    }
  }
}

/// Clear the libvips error buffer.
void clearVipsError() {
  vipsBindings.vips_error_clear();
}

/// Get libvips version information.
int vipsVersion(int flag) {
  return vipsBindings.vips_version(flag);
}

/// Get libvips version as string.
String get vipsVersionString {
  return '${vipsVersion(0)}.${vipsVersion(1)}.${vipsVersion(2)}';
}

/// Exception thrown by libvips api operations.
class VipsApiException implements Exception {
  final String message;
  VipsApiException(this.message);

  @override
  String toString() => 'VipsApiException: $message';
}
