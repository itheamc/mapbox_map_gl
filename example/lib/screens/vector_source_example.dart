import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_map_gl/mapbox_map_gl.dart';

class VectorSourceExampleScreen extends StatefulWidget {
  const VectorSourceExampleScreen({Key? key}) : super(key: key);

  @override
  State<VectorSourceExampleScreen> createState() =>
      _VectorSourceExampleScreenState();
}

class _VectorSourceExampleScreenState extends State<VectorSourceExampleScreen> {
  /// List of color
  final _colors = [
    "#ff69b4",
    "red",
    "blue",
    "green",
    "orange",
  ];

  /// Color Index
  int _i = 0;

  /// Map controller
  MapboxMapController? _controller;

  /// Method to handle onMapCreated callback
  void _onMapCreated(MapboxMapController controller) {
    _controller = controller;
  }

  Future<void> _addVectorSource() async {
    _i = (_i + 1) % _colors.length;
    _controller
        ?.addSource<VectorSource>(
      source: VectorSource(
        sourceId: "mapbox-terrain",
        url: 'mapbox://mapbox.mapbox-terrain-v2',
      ),
    )
        .then((value) {
      _addLineLayer();
    });
  }

  Future<void> _addLineLayer() async {
    await _controller?.addLayer<LineLayer>(
      layer: LineLayer(
        layerId: "line-layer-id",
        sourceId: "mapbox-terrain",
        layerProperties: LineLayerProperties(
            lineColor: _colors[_i],
            lineWidth: 1.5,
            lineJoin: LineJoin.round,
            lineCap: LineCap.round,
            sourceLayer: "contour"),
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
              onPressed: _addVectorSource,
              child: const Icon(
                Icons.layers,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: MapboxMap(
          initialCameraPosition: CameraPosition(
            center: Point.fromLatLng(37.283499, -122.158085),
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
