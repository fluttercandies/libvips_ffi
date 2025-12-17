import 'package:flutter/material.dart';
import 'package:libvips_flutter_example_base/libvips_flutter_example_base.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Vips Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const NavigationPage(),
    );
  }
}

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('libvips Example'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Home Page'),
            subtitle: const Text('Basic libvips examples'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.merge),
            title: const Text('Join Example'),
            subtitle: const Text('Widget to large image with chunks'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const JoinExamplePage()),
            ),
          ),
        ],
      ),
    );
  }
}
