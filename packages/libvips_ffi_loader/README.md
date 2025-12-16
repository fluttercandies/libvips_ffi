# libvips_ffi_loader

Dynamic library loader for libvips_ffi with callback-based download support.

## Features

- Download libvips binaries on demand
- Callback-based progress reporting
- Platform-specific library management

## Usage

```dart
import 'package:libvips_ffi_loader/libvips_ffi_loader.dart';

import 'dart:io';

void main() async {
  await VipsLoader.init(
    provider: (request) async {
      final cacheDir = request.suggestedCacheDir;
      final libPath = '$cacheDir/${request.libraryFileName}';

      if (await File(libPath).exists()) {
        return libPath;
      }

      final zipPath = '$cacheDir/libvips.zip';
      final url = 'https://your-cdn.example.com/libvips/'
          '${request.platformArchIdentifier}/'
          '${request.recommendedVersion}/'
          'libvips.zip';

      // Download zip (placeholder; implement your own HTTP client / retry / checksum).
      await downloadToFile(url: url, to: zipPath);

      // Extract zip into cacheDir (placeholder; implement your own unzip logic).
      // Make sure the extracted files include request.libraryFileName.
      await extractZip(zipPath: zipPath, toDir: cacheDir);

      return libPath;
    },
    onStateChanged: (state) {
      // checking/downloading/extracting/loading/ready/error
      print('libvips loading: $state');
    },
  );

  // After init, use VipsPipeline from libvips_ffi_api
  final pipeline = VipsPipeline.fromFile('input.jpg');
  pipeline.resize(0.5);
  pipeline.toFile('output.jpg');
  pipeline.dispose();
}
```

## Download & Extract Notes

The `provider` callback must return an absolute path to the final dynamic library:

- Windows: `libvips-42.dll`
- macOS: `libvips.dylib`
- Linux: `libvips.so.42`

Use `request.libraryFileName` to avoid hardcoding.

### Windows (example package suggestion)

If you only need FFI calls, a practical source of prebuilt runtime DLLs is the
`vips-dev-w64-web-<version>.zip` asset from:

[https://github.com/libvips/build-win64-mxe/releases](https://github.com/libvips/build-win64-mxe/releases)

When you package your zip for download, ensure `libvips-42.dll` and its dependent
DLLs are placed together (typically in the same extracted directory).

## Related Packages

- [libvips_ffi_core](https://pub.dev/packages/libvips_ffi_core) - Core FFI bindings
