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
        sdf: true,
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
            delay: 0,
            duration: const Duration(milliseconds: 1000),
          ),
          circleRadius: 12,
          circleRadiusTransition: StyleTransition.build(
            delay: 0,
            duration: const Duration(milliseconds: 1000),
          ),
          circleStrokeWidth: 2.5,
          circleStrokeWidthTransition: StyleTransition.build(
            delay: 0,
            duration: const Duration(milliseconds: 1000),
          ),
          circleStrokeColor: "#fff",
          circleStrokeColorTransition: StyleTransition.build(
            delay: 0,
            duration: const Duration(milliseconds: 1000),
          ),
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

  /// Method to change radius property
  Future<void> _changeRadius(double radius) async {
    // For Circle Layer
    await _controller?.setStyleLayerProperty(
        layerId: "my-layer-id", property: "circle-radius", value: radius);
  }

  /// Method to change radius property
  Future<void> _changeColor(String color) async {
    // For Circle Layer
    await _controller?.setStyleLayerProperty(
        layerId: "my-layer-id", property: "circle-color", value: color);

    // For Symbol Layer
    await _controller?.setStyleLayerProperty(
        layerId: "symbol-layer-example",
        property: "icon-color",
        value: "yellow");
  }

  /// Method to change color and radius both
  Future<void> _changeColorNRadius() async {
    // For Circle Layer
    await _controller?.setStyleLayerProperties(
      layerId: "my-layer-id",
      properties: <String, dynamic>{
        "circle-color": "purple",
        "circle-radius": 20,
        "circle-stroke-width": 4.0,
        "circle-stroke-color": 'yellow',
      },
    );
  }

  /// Method to get queried features
  Future<void> _queryRenderedFeatures() async {
    final size = MediaQuery.of(context).size;

    final res = await _controller?.queryRenderedFeatures(
      geometry: RenderedQueryGeometry.fromScreenBox(
        ScreenBox(
          ScreenCoordinate(0.0, 0.0),
          ScreenCoordinate(size.width, size.height),
        ),
      ),
      queryOptions: RenderedQueryOptions(),
    );

    // final res = await _controller?.queryRenderedFeatures(
    //   geometry: RenderedQueryGeometry.fromScreenCoordinate(
    //     ScreenCoordinate(size.width, size.height),
    //   ),
    //   queryOptions: RenderedQueryOptions(
    //       layerIds: ["my-layer-id"]
    //   ),
    // );

    // final res = await _controller?.queryRenderedFeatures(
    //   geometry: RenderedQueryGeometry.fromScreenCoordinates(
    //     [ScreenCoordinate(size.width, size.height),]
    //   ),
    //   queryOptions: RenderedQueryOptions(
    //     layerIds: ["my-layer-id"]
    //   ),
    // );

    print(res?.length);
  }

  /// Method to get queried features
  Future<void> _querySourceFeatures() async {
    final size = MediaQuery.of(context).size;

    final res = await _controller?.querySourceFeatures(
        sourceId: "my-data-source",
        queryOptions: SourceQueryOptions(
          sourceLayerIds: ["sourceLayer1", "sourceLayer2"],
          filter: <String, dynamic>{
            "region": "North America",
            "name": "Amit",
          },
        ));

    print(res?.length);
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
                onPressed: () => _changeColor("blue"),
                label: const Text(
                  "Change Color",
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
                onPressed: () => _changeRadius(17),
                label: const Text(
                  "Change Radius",
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
                onPressed: _changeColorNRadius,
                label: const Text(
                  "Change Together",
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
                onPressed: _querySourceFeatures,
                label: const Text(
                  "Reset",
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
          onMapClick: (point, screenCoordinate) {
            if (kDebugMode) {
              print(
                  "[_GeoJsonSourceExample2ScreenState -> onMapClick] ---> ${point.toMap()}, ${screenCoordinate.toMap()}");
            }
          },
          onMapLongClick: (point, screenCoordinate) {
            if (kDebugMode) {
              print(
                  "[_GeoJsonSourceExample2ScreenState -> onMapLongClick] ---> ${point.toMap()}, ${screenCoordinate.toMap()}");
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
