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
    _controller?.addSource<GeoJsonSource>(
      source: GeoJsonSource(
        sourceId: "my-data-source",
        url:
            "https://d2ad6b4ur7yvpq.cloudfront.net/naturalearth-3.3.0/ne_10m_land_ocean_label_points.geojson",
        sourceProperties: GeoJsonSourceProperties(
            cluster: true, clusterRadius: 50, clusterMaxZoom: 14, maxZoom: 20),
      ),
    ).then((value) {
      _addCircleLayer();
    });
  }

  Future<void> _addCircleLayer() async {
    await _controller?.addLayer<CircleLayer>(
      layer: CircleLayer(
        layerId: "my-layer-id",
        sourceId: "my-data-source",
        layerProperties: CircleLayerProperties(
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
            duration: const Duration(milliseconds: 1000),
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
            3,
            2
          ],
          circleStrokeColor: "#fff",
          circleTranslate: [-5, -5],
          circleTranslateTransition: StyleTransition.build(
            delay: 0,
            duration: const Duration(milliseconds: 1000),
          ),
        ),
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
                Icons.layers,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: MapboxMap(
          initialCameraPosition: CameraPosition(
            center: Point.fromLatLng(27.837785, 82.538961),
            zoom: 2.0,
            // anchor: ScreenCoordinate(120.0, 200.0),
            animationOptions: AnimationOptions.mapAnimationOptions(
              startDelay: 300,
              duration: const Duration(milliseconds: 750),
            ),
          ),
          onMapCreated: _onMapCreated,
          onStyleLoaded: () {
            _addGeoJson();
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
