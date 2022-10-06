import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_map_gl/mapbox_map_gl.dart';

import 'example3_screen.dart';

class Example1Screen extends StatefulWidget {
  const Example1Screen({Key? key}) : super(key: key);

  @override
  State<Example1Screen> createState() => _Example1ScreenState();
}

class _Example1ScreenState extends State<Example1Screen> {
  MapboxMapController? _controller;

  /// Method to handle onMapCreated callback
  void _onMapCreated(MapboxMapController controller) {
    _controller = controller;
    if (kDebugMode) {
      print("[ON MAP CREATED]------->");
    }
  }

  /// Method to toggle theme mode
  /// Satellite and Street
  Future<void> _toggleMode() async {
    await _controller?.toggleMode(dark: true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.small(
              child: const Icon(
                Icons.alt_route,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const Example3Screen(),
                  ),
                );
              },
            ),
            FloatingActionButton.small(
              onPressed: _toggleMode,
              child: const Icon(
                Icons.toggle_off_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: MapboxMap(
          initialCameraPosition: CameraPosition(
            center: Point.fromLatLng(27.837785, 82.538961),
            zoom: 15.0,
            // anchor: ScreenCoordinate(120.0, 200.0),
            animationOptions: AnimationOptions.mapAnimationOptions(
              startDelay: 300,
              duration: const Duration(milliseconds: 750),
            ),
          ),
          onMapCreated: _onMapCreated,
          onStyleLoaded: () {
            if (kDebugMode) {
              print("[Method Call -> onStyleLoaded] ---> From _MyAppState");
            }
          },
          onStyleLoadError: (err) {
            if (kDebugMode) {
              print(
                  "[Method Call -> onStyleLoadError] ---> From _MyAppState -> $err");
            }
          },
          onMapClick: (point, screenCoordinate) {
            if (kDebugMode) {
              print(
                  "[Method Call -> onMapClick] ---> ${point.toMap()}, ${screenCoordinate.toMap()}");
            }
          },
          onMapLongClick: (point, screenCoordinate) {
            if (kDebugMode) {
              print(
                  "[Method Call -> onMapLongClick] ---> ${point.toMap()}, ${screenCoordinate.toMap()}");
            }
          },
          onFeatureClick: (point, screenCoordinate, feature, source) {
            if (kDebugMode) {
              print(
                  "[Method Call -> onFeatureClick] ---> $source, ${feature.properties}");
            }
          },
          onFeatureLongClick: (point, screenCoordinate, feature, source) {
            if (kDebugMode) {
              print(
                  "[Method Call -> onFeatureClick] ---> $source, ${feature.toString()}");
            }
          },
        ),
      ),
    );
  }
}
