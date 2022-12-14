import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_map_gl/mapbox_map_gl.dart';

class GeoJsonSourceExampleScreen extends StatefulWidget {
  const GeoJsonSourceExampleScreen({Key? key}) : super(key: key);

  @override
  State<GeoJsonSourceExampleScreen> createState() =>
      _GeoJsonSourceExampleScreenState();
}

class _GeoJsonSourceExampleScreenState
    extends State<GeoJsonSourceExampleScreen> {
  MapboxMapController? _controller;

  /// Method to handle onMapCreated callback
  void _onMapCreated(MapboxMapController controller) {
    _controller = controller;
  }

  Future<void> _addGeoJson() async {
    await _controller
        ?.addSource<GeoJsonSource>(
      source: GeoJsonSource(
        sourceId: "my-data-source",
        url:
            "https://d2ad6b4ur7yvpq.cloudfront.net/naturalearth-3.3.0/ne_10m_land_ocean_label_points.geojson",
        sourceProperties: GeoJsonSourceProperties(
          cluster: true,
          clusterRadius: 50,
          clusterMaxZoom: 14,
          maxZoom: 20,
        ),
      ),
    )
        .then((value) {
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
          circleRadiusTransition: StyleTransition.build(
            delay: 500,
            duration: const Duration(milliseconds: 1000),
          ),
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
          circleTranslateTransition: StyleTransition.build(
            delay: 0,
            duration: const Duration(milliseconds: 1000),
          ),
        ),
      ),
    );
    await _addSymbolLayer();
  }

  Future<void> _addSymbolLayer() async {
    await _controller?.addLayer<SymbolLayer>(
      layer: SymbolLayer(
        layerId: "symbol-layer-example",
        sourceId: "my-data-source",
        layerProperties: SymbolLayerProperties(
          textField: ['get', 'point_count_abbreviated'],
          textSize: 12,
          textColor: '#fff',
          iconSize: 1,
          iconAllowOverlap: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
          onStyleLoaded: () async {
            final isAlreadyAdded =
                await _controller?.isSourceExist("my-data-source") ?? false;
            if (!isAlreadyAdded) {
              _addGeoJson();
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
          onFeatureClick: (details) {
            if (kDebugMode) {
              print(
                  "[_GeoJsonSourceExample2ScreenState -> onFeatureClick] ---> ${details.source}, ${details.feature.properties}");
            }
          },
          onFeatureLongClick: (details) {
            if (kDebugMode) {
              print(
                  "[_GeoJsonSourceExample2ScreenState -> onFeatureClick] ---> ${details.source}, ${details.feature.properties}");
            }
          },
        ),
      ),
    );
  }
}
