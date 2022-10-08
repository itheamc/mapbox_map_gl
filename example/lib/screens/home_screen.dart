import 'package:flutter/material.dart';
import 'package:mapbox_map_gl_example/screens/example1_screen.dart';
import 'package:mapbox_map_gl_example/screens/vector_source_example.dart';

import 'example2_screen.dart';
import 'example3_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapbox Map Gl"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const Example1Screen(),
                  ),
                );
              },
              child: const Text("Example 1"),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const Example2Screen(),
                  ),
                );
              },
              child: const Text("Example 2"),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const Example3Screen(),
                  ),
                );
              },
              child: const Text("GeoJson (Circle Layer)"),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const VectorSourceExampleScreen(),
                  ),
                );
              },
              child: const Text("Vector Source"),
            ),
          ],
        ),
      ),
    );
  }
}
