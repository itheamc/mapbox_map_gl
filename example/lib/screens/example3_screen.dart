import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_map_gl/mapbox_map_gl.dart';

import 'example1_screen.dart';

class Example3Screen extends StatefulWidget {
  const Example3Screen({Key? key}) : super(key: key);

  @override
  State<Example3Screen> createState() => _Example3ScreenState();
}

class _Example3ScreenState extends State<Example3Screen> {
  MapboxMapController? _controller;

  /// Method to handle onMapCreated callback
  void _onMapCreated(MapboxMapController controller) {
    _controller = controller;
  }

  Future<void> _addGeoJson() async {
    await _controller?.addGeoJsonSource(
      sourceId: "my-geojson-source",
      layerId: "my-layer",
      circleLayer: CircleLayer(
        layerId: "layerId",
        sourceId: "sourceId",
        options: CircleLayerOptions(
            circleColor: [
              'case',
              [
                'boolean',
                ['has', 'point_count'],
                true
              ],
              'red',
              'blue'
            ],
            circleColorTransition: StyleTransition.build(
              delay: 500,
              duration: const Duration(milliseconds: 1000)
            ),
            circleRadius: [
              'case',
              [
                'boolean',
                ['has', 'point_count'],
                true
              ],
              15,
              10
            ],
            circleStrokeWidth: [
              'case',
              [
                'boolean',
                ['has', 'point_count'],
                true
              ],
              4.5,
              2
            ],
            circleStrokeColor: "#fff"),
      ),
    );
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
                    builder: (_) => const Example1Screen(),
                  ),
                );
              },
            ),
            FloatingActionButton.small(
              onPressed: _addGeoJson,
              child: const Icon(
                Icons.place,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: MapboxMap(
          initialCameraPosition: CameraPosition(
            center: LatLng(27.837785, 82.538961),
            zoom: 2.0,
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
