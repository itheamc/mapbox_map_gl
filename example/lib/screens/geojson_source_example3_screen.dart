import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_map_gl/mapbox_map_gl.dart';

class GeoJsonSourceExample3Screen extends StatefulWidget {
  const GeoJsonSourceExample3Screen({Key? key}) : super(key: key);

  @override
  State<GeoJsonSourceExample3Screen> createState() =>
      _GeoJsonSourceExample3ScreenState();
}

class _GeoJsonSourceExample3ScreenState
    extends State<GeoJsonSourceExample3Screen> {
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
        url: """
        {
                                              "type": "FeatureCollection",
                                              "features": [
                                                {
                                                  "type": "Feature",
                                                  "id": 1,
                                                  "properties": {},
                                                  "geometry": {
                                                    "type": "Point",
                                                    "coordinates": [
                                                      82.52423286437988,
                                                      27.82700782048685
                                                    ]
                                                  }
                                                },
                                                {
                                                  "type": "Feature",
                                                  "id": 2,
                                                  "properties": {},
                                                  "geometry": {
                                                    "type": "Point",
                                                    "coordinates": [
                                                      82.51848220825195,
                                                      27.830119893844447
                                                    ]
                                                  }
                                                },
                                                {
                                                  "type": "Feature",
                                                  "id": 3,
                                                  "properties": {},
                                                  "geometry": {
                                                    "type": "Point",
                                                    "coordinates": [
                                                      82.51479148864745,
                                                      27.832776471232034
                                                    ]
                                                  }
                                                },
                                                {
                                                  "type": "Feature",
                                                  "id": 4,
                                                  "properties": {},
                                                  "geometry": {
                                                    "type": "Point",
                                                    "coordinates": [
                                                      82.53084182739258,
                                                      27.827083725776717
                                                    ]
                                                  }
                                                },
                                                {
                                                  "type": "Feature",
                                                  "id": 5,
                                                  "properties": {},
                                                  "geometry": {
                                                    "type": "Point",
                                                    "coordinates": [
                                                      82.5186538696289,
                                                      27.81888564779952
                                                    ]
                                                  }
                                                },
                                                {
                                                  "type": "Feature",
                                                  "id": 6,
                                                  "properties": {},
                                                  "geometry": {
                                                    "type": "Point",
                                                    "coordinates": [
                                                      82.54054069519043,
                                                      27.826248764669007
                                                    ]
                                                  }
                                                },
                                                {
                                                  "type": "Feature",
                                                  "id": 7,
                                                  "properties": {},
                                                  "geometry": {
                                                    "type": "Point",
                                                    "coordinates": [
                                                      82.53556251525879,
                                                      27.819341112816325
                                                    ]
                                                  }
                                                }
                                              ]
                                            }
        
        """,
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
          circleColor: [
            'case',
            [
              'boolean',
              ['feature-state', 'clicked'],
              false
            ],
            'red',
            'blue'
          ],
          circleColorTransition: StyleTransition.build(
            delay: 0,
            duration: const Duration(milliseconds: 500),
          ),
          circleRadius: [
            'case',
            [
              'boolean',
              ['feature-state', 'clicked'],
              false
            ],
            15,
            10
          ],
          circleRadiusTransition: StyleTransition.build(
            delay: 0,
            duration: const Duration(milliseconds: 500),
          ),
          circleStrokeWidth: 2,
          circleStrokeColor: "#fff",
        ),
      ),
    );
  }

  /// Method to set Feature state
  Future<void> _setFeatureState(
      String featureId, Map<String, dynamic> state) async {
    await _controller?.setFeatureState(
      sourceId: "my-data-source",
      featureId: featureId,
      state: state,
    );

    print("SET");
  }

  /// Method to remove Feature state
  Future<void> _removeFeatureState(String featureId, String stateKey) async {
    await _controller?.removeFeatureState(
      sourceId: "my-data-source",
      featureId: featureId,
      stateKey: stateKey,
    );
  }

  /// Method to get Feature state
  Future<dynamic> _getFeatureState(String featureId) async {
    final state = await _controller?.getFeatureState(
      sourceId: "my-data-source",
      featureId: featureId,
    );

    return state;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MapboxMap(
          initialCameraPosition: CameraPosition(
            center: Point.fromLatLng(27.817785, 82.518961),
            zoom: 13.0,
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
          onFeatureClick: (details) async {
            await _setFeatureState(
              details.feature.id ?? "",
              <String, dynamic>{"clicked": true},
            );

            await Future.delayed(const Duration(milliseconds: 1000));

            await _removeFeatureState(details.feature.id ?? "", "clicked");
          },
          onFeatureLongClick: (details) async {
            final state = await _getFeatureState(details.feature.id ?? "");
          },
        ),
      ),
    );
  }
}
