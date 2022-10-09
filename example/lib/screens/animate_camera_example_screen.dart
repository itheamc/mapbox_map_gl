import 'package:flutter/material.dart';
import 'package:mapbox_map_gl/mapbox_map_gl.dart';

class AnimateCameraExampleScreen extends StatefulWidget {
  const AnimateCameraExampleScreen({Key? key}) : super(key: key);

  @override
  State<AnimateCameraExampleScreen> createState() => _AnimateCameraExampleScreenState();
}

class _AnimateCameraExampleScreenState extends State<AnimateCameraExampleScreen> {
  MapboxMapController? _controller;

  /// Method to handle onMapCreated callback
  void _onMapCreated(MapboxMapController controller) {
    _controller = controller;
  }

  /// Method to animate camera to specific latLng
  Future<void> _animateCameraPosition() async {
    final cameraPosition = CameraPosition(
      center: Point.fromLatLng(27.707818, 85.315355),
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
        floatingActionButton: SizedBox(
          height: 38.0,
          child: FloatingActionButton.extended(
            onPressed: _animateCameraPosition,
            label: const Text(
              "Animate Camera",
              textScaleFactor: 0.75,
            ),
            icon: const Icon(
              Icons.gps_fixed_outlined,
              color: Colors.white,
              size: 14.0,
            ),
          ),
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
        ),
      ),
    );
  }
}
