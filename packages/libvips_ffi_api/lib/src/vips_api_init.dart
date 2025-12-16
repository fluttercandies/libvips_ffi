import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:libvips_ffi_core/src/bindings/vips_bindings_generated.dart';

import 'bindings/vips_bindings.dart';
import 'bindings/io_bindings.dart';
import 'bindings/arithmetic_bindings.dart';
import 'bindings/draw_bindings.dart';
import 'bindings/morphology_bindings.dart';
import 'bindings/frequency_bindings.dart';
import 'bindings/create_bindings.dart';
import 'bindings/colour_bindings.dart';
import 'bindings/relational_bindings.dart';
import 'bindings/conversion_bindings.dart';
import 'bindings/convolution_bindings.dart';
import 'bindings/resample_bindings.dart';
import 'bindings/complex_bindings.dart';
import 'bindings/mosaicing_bindings.dart';

/// Global VipsBindings instance from core package.
VipsBindings? _vipsBindings;

/// Global VipsApiBindings instance for variadic functions.
VipsApiBindings? _apiBindings;

/// Additional category bindings.
VipsIoBindings? _ioBindings;
VipsArithmeticBindings? _arithmeticBindings;
VipsDrawBindings? _drawBindings;
VipsMorphologyBindings? _morphologyBindings;
VipsFrequencyBindings? _frequencyBindings;
VipsCreateBindings? _createBindings;
VipsColourBindings? _colourBindings;
VipsRelationalBindings? _relationalBindings;
VipsConversionBindings? _conversionBindings;
VipsConvolutionBindings? _convolutionBindings;
VipsResampleBindings? _resampleBindings;
VipsComplexBindings? _complexBindings;
VipsMosaicingBindings? _mosaicingBindings;

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

/// Get I/O bindings.
VipsIoBindings get ioBindings => _ioBindings ??= VipsIoBindings(vipsLibrary);

/// Get arithmetic bindings.
VipsArithmeticBindings get arithmeticBindings => _arithmeticBindings ??= VipsArithmeticBindings(vipsLibrary);

/// Get draw bindings.
VipsDrawBindings get drawBindings => _drawBindings ??= VipsDrawBindings(vipsLibrary);

/// Get morphology bindings.
VipsMorphologyBindings get morphologyBindings => _morphologyBindings ??= VipsMorphologyBindings(vipsLibrary);

/// Get frequency bindings.
VipsFrequencyBindings get frequencyBindings => _frequencyBindings ??= VipsFrequencyBindings(vipsLibrary);

/// Get create bindings.
VipsCreateBindings get createBindings => _createBindings ??= VipsCreateBindings(vipsLibrary);

/// Get colour bindings.
VipsColourBindings get colourBindings => _colourBindings ??= VipsColourBindings(vipsLibrary);

/// Get relational bindings.
VipsRelationalBindings get relationalBindings => _relationalBindings ??= VipsRelationalBindings(vipsLibrary);

/// Get conversion bindings.
VipsConversionBindings get conversionBindings => _conversionBindings ??= VipsConversionBindings(vipsLibrary);

/// Get convolution bindings.
VipsConvolutionBindings get convolutionBindings => _convolutionBindings ??= VipsConvolutionBindings(vipsLibrary);

/// Get resample bindings.
VipsResampleBindings get resampleBindings => _resampleBindings ??= VipsResampleBindings(vipsLibrary);

/// Get complex bindings.
VipsComplexBindings get complexBindings => _complexBindings ??= VipsComplexBindings(vipsLibrary);

/// Get mosaicing bindings.
VipsMosaicingBindings get mosaicingBindings => _mosaicingBindings ??= VipsMosaicingBindings(vipsLibrary);

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
