import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_map_gl/mapbox_map_gl.dart';

class GeoJsonSourceExample2Screen extends StatefulWidget {
  const GeoJsonSourceExample2Screen({Key? key}) : super(key: key);

  @override
  State<GeoJsonSourceExample2Screen> createState() =>
      _GeoJsonSourceExample2ScreenState();
}

class _GeoJsonSourceExample2ScreenState
    extends State<GeoJsonSourceExample2Screen> {
  MapboxMapController? _controller;

  /// Method to handle onMapCreated callback
  void _onMapCreated(MapboxMapController controller) {
    _controller = controller;
  }

  /// Method to add local style image
  Future<void> _addLocalStyleImage() async {
    await _controller?.addStyleImage<LocalStyleImage>(
      image: LocalStyleImage(
        imageId: "icon",
        imageName: "assets/images/composting.png",
        sdf: false,
      ),
    );
  }

  /// Method to add network style image
  // Future<void> _addNetworkStyleImage() async {
  //   await _controller?.addStyleImage<NetworkStyleImage>(
  //     image: NetworkStyleImage(
  //       imageId: "icon",
  //       url:
  //           "",
  //       sdf: true,
  //     ),
  //   );
  // }

  Future<void> _addGeoJson() async {
    await _addLocalStyleImage();
    // await _addNetworkStyleImage();
    await _controller
        ?.addSource<GeoJsonSource>(
      source: GeoJsonSource(
        sourceId: "my-data-source",
        url:
            "https://d2ad6b4ur7yvpq.cloudfront.net/naturalearth-3.3.0/ne_50m_geography_regions_points.geojson",
        sourceProperties: GeoJsonSourceProperties(
          cluster: false,
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
          circleColor: 'red',
          circleColorTransition: StyleTransition.build(
            delay: 500,
            duration: const Duration(milliseconds: 1000),
          ),
          circleRadius: 12,
          circleStrokeWidth: 2.5,
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
          iconImage: "icon",
          iconColor: "#fff", // Only work if sdf is true
          iconSize: 0.75,
          iconAllowOverlap: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: SizedBox(
          height: 38.0,
          child: FloatingActionButton.extended(
            onPressed: _addGeoJson,
            label: const Text(
              "Add GeoJson Source, Circle & Symbol Layer",
              textScaleFactor: 0.75,
            ),
            icon: const Icon(
              Icons.layers,
              color: Colors.white,
              size: 14.0,
            ),
          ),
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
