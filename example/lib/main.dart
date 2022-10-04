import 'package:flutter/foundation.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MapboxMap(
          initialCameraPosition: CameraPosition(
            center: LatLng(27.837785, 82.538961),
            zoom: 15.0,
            // anchor: ScreenCoordinate(120.0, 200.0),
            animationOptions: AnimationOptions.mapAnimationOptions(
              startDelay: 300,
              duration: const Duration(milliseconds: 750),
            ),
          ),
          onMapCreated: (controller) {
            if (kDebugMode) {
              print("[Method Call -> onMapCreated] ---> From _MyAppState");
            }
          },
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
          onMapClick: (latLng, screenCoordinate) {
            if (kDebugMode) {
              print("[Method Call -> onMapClick] ---> ${latLng.toJson()}, ${screenCoordinate.toJson()}");
            }
          },
          onMapLongClick: (latLng, screenCoordinate) {
            if (kDebugMode) {
              print("[Method Call -> onMapLongClick] ---> ${latLng.toJson()}, ${screenCoordinate.toJson()}");
            }
          },
          onFeatureClick: (latLng, screenCoordinate, feature, source) {
            if (kDebugMode) {
              print("[Method Call -> onFeatureClick] ---> $source, ${feature.toString()}");
            }
          },
          onFeatureLongClick: (latLng, screenCoordinate, feature, source) {
            if (kDebugMode) {
              print("[Method Call -> onFeatureClick] ---> $source, ${feature.toString()}");
            }
          },
        ),
      ),
    );
  }
}
