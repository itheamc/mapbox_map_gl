import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_map_gl/mapbox_map_gl.dart';

class ToggleStyleExampleScreen extends StatefulWidget {
  const ToggleStyleExampleScreen({Key? key}) : super(key: key);

  @override
  State<ToggleStyleExampleScreen> createState() =>
      _ToggleStyleExampleScreenState();
}

class _ToggleStyleExampleScreenState extends State<ToggleStyleExampleScreen> {
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
  Future<void> _toggleBetween() async {
    await _controller?.toggleBetween(
      MapStyle.light,
      MapStyle.satellite,
      onStyleToggled: (style) {
        if (kDebugMode) {
          print("[ON STYLE TOGGLED]------->${style.name}");
        }
      },
    );
  }

  /// Method to toggle theme mode among styles
  Future<void> _toggleAmong() async {
    await _controller?.toggleAmong(MapStyle.values, onStyleToggled: (style) {
      if (kDebugMode) {
        print("[ON STYLE TOGGLED]------->${style.name}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 38.0,
              child: FloatingActionButton.extended(
                onPressed: _toggleBetween,
                label: const Text(
                  "Toggle Between",
                  textScaleFactor: 0.75,
                ),
                icon: const Icon(
                  Icons.style_outlined,
                  color: Colors.white,
                  size: 14.0,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 38.0,
              child: FloatingActionButton.extended(
                onPressed: _toggleAmong,
                label: const Text(
                  "Toggle Among",
                  textScaleFactor: 0.75,
                ),
                icon: const Icon(
                  Icons.style,
                  color: Colors.white,
                  size: 14.0,
                ),
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
              print("[ON STYLE LOADED]------->STYLE LOADED");
            }
          },
        ),
      ),
    );
  }
}
