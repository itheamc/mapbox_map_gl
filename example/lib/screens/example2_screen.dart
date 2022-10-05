import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_map_gl/mapbox_map_gl.dart';

class Example2Screen extends StatefulWidget {
  const Example2Screen({Key? key}) : super(key: key);

  @override
  State<Example2Screen> createState() => _Example2ScreenState();
}

class _Example2ScreenState extends State<Example2Screen> {
  MapboxMapController? _controller;

  /// Method to handle onMapCreated callback
  void _onMapCreated(MapboxMapController controller) {
    _controller = controller;
  }

  /// Method to animate camera to specific latLng
  Future<void> _animateCameraPosition() async {
    final cameraPosition = CameraPosition(
      center: LatLng(27.707818, 85.315355),
      zoom: 14.0,
      // anchor: ScreenCoordinate(120.0, 200.0),
      animationOptions: AnimationOptions.mapAnimationOptions(
        startDelay: 375,
        duration: const Duration(milliseconds: 3000),
      ),
    );

    await _controller?.animateCameraPosition(cameraPosition);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton.small(
          onPressed: _animateCameraPosition,
          child: const Icon(
            Icons.gps_fixed_outlined,
            color: Colors.white,
          ),
        ),
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
          onMapClick: (latLng, screenCoordinate) {
            if (kDebugMode) {
              print(
                  "[Method Call -> onMapClick] ---> ${latLng.toJson()}, ${screenCoordinate.toJson()}");
            }
          },
          onMapLongClick: (latLng, screenCoordinate) {
            if (kDebugMode) {
              print(
                  "[Method Call -> onMapLongClick] ---> ${latLng.toJson()}, ${screenCoordinate.toJson()}");
            }
          },
          onFeatureClick: (latLng, screenCoordinate, feature, source) {
            if (kDebugMode) {
              print(
                  "[Method Call -> onFeatureClick] ---> $source, ${feature.properties}");
            }
          },
          onFeatureLongClick: (latLng, screenCoordinate, feature, source) {
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
