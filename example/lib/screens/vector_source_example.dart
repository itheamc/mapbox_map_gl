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
  /// Map controller
  MapboxMapController? _controller;

  /// Method to handle onMapCreated callback
  void _onMapCreated(MapboxMapController controller) {
    _controller = controller;
  }

  Future<void> _addVectorSource() async {
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
          lineColor: "#ff69b4",
          lineWidth: 1.5,
          lineJoin: LineJoin.round,
          lineCap: LineCap.round,
          sourceLayer: "contour",
        ),
      ),
    );
  }

  /// Method to change property
  Future<void> _changeProperty({String? color, double? lineWidth}) async {
    if (color != null || lineWidth != null) {
      final res = await _controller?.setStyleLayerProperty(
          layerId: "line-layer-id",
          property: color != null ? "line-color" : "line-width",
          value: color ?? lineWidth);

      if (kDebugMode) {
        print("[_VectorSourceExampleScreenState -> _changeProperty] ---> $res");
      }
    }
  }

  /// Method to change more than one properties at once
  Future<void> _changeProperties() async {
    await _controller?.setStyleLayerProperties(
      layerId: "line-layer-id",
      properties: <String, dynamic>{
        'line-color': 'green',
        'line-width': 1.0,
      },
    );
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
                onPressed: () => _changeProperty(color: 'red'),
                label: const Text(
                  "Change Color (Red)",
                  textScaleFactor: 0.75,
                ),
                icon: const Icon(
                  Icons.layers,
                  color: Colors.white,
                  size: 14.0,
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            SizedBox(
              height: 38.0,
              child: FloatingActionButton.extended(
                onPressed: () => _changeProperty(color: 'blue'),
                label: const Text(
                  "Change Color (Blue)",
                  textScaleFactor: 0.75,
                ),
                icon: const Icon(
                  Icons.layers,
                  color: Colors.white,
                  size: 14.0,
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            SizedBox(
              height: 38.0,
              child: FloatingActionButton.extended(
                onPressed: () => _changeProperty(lineWidth: 4.0),
                label: const Text(
                  "Line Width (4.0)",
                  textScaleFactor: 0.75,
                ),
                icon: const Icon(
                  Icons.layers,
                  color: Colors.white,
                  size: 14.0,
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            SizedBox(
              height: 38.0,
              child: FloatingActionButton.extended(
                onPressed: _changeProperties,
                label: const Text(
                  "Change Properties",
                  textScaleFactor: 0.75,
                ),
                icon: const Icon(
                  Icons.layers,
                  color: Colors.white,
                  size: 14.0,
                ),
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
          onStyleLoaded: () async {
            final isAlreadyAdded =
                await _controller?.isSourceExist("mapbox-terrain") ?? false;
            if (!isAlreadyAdded) {
              _addVectorSource();
            }
          },
          onStyleLoadError: (err) {
            if (kDebugMode) {
              print(
                  "[_VectorSourceExampleScreenState -> onStyleLoadError] ---> From _MyAppState -> $err");
            }
          },
          onMapClick: (point, screenCoordinate) {
            if (kDebugMode) {
              print(
                  "[_VectorSourceExampleScreenState -> onMapClick] ---> ${point.toMap()}, ${screenCoordinate.toMap()}");
            }
          },
          onMapLongClick: (point, screenCoordinate) {
            if (kDebugMode) {
              print(
                  "[_VectorSourceExampleScreenState -> onMapLongClick] ---> ${point.toMap()}, ${screenCoordinate.toMap()}");
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
