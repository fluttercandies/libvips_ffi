import 'package:flutter/material.dart';
import 'package:libvips_ffi_macos/libvips_ffi_macos.dart';
import 'package:libvips_flutter_example_base/libvips_flutter_example_base.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'libvips macOS Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: HomePage(loader: MacosVipsLoader()),
    );
  }
}

