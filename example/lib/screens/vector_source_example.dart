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
  MapboxMapController? _controller;

  /// Method to handle onMapCreated callback
  void _onMapCreated(MapboxMapController controller) {
    _controller = controller;
  }

  Future<void> _addVectorSource() async {
    _controller
        ?.addSource<VectorSource>(
      source: VectorSource(
        sourceId: "my-line-data-source",
        tiles: [
          "https://cleanup.naxa.com.np/api/v1/core/maps/vector_layer/{z}/{x}/{y}/?layer_id=3"
        ],
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
          sourceId: "my-line-data-source",
          layerProperties: LineLayerProperties(
              lineColor: "purple",
              lineWidth: 3.5,
              lineJoin: LineJoin.round,
              lineCap: LineCap.round,
              sourceLayer: "routes")),
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
            center: Point.fromLatLng(27.837785, 82.538961),
            zoom: 5.0,
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
