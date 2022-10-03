import 'package:flutter/material.dart';
import 'package:mapbox_map_gl/mapbox_map_gl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _mapboxMapGlPlugin = MapboxMapGl();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: _mapboxMapGlPlugin.buildView(
            creationParams: creationParams,
            onPlatformViewCreated: (id) {
              print("[PLATFORM CREATED] -----> $id");
            },
          ),
        ),
      ),
    );
  }
}
