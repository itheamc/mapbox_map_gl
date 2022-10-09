import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_map_gl/mapbox_map_gl.dart';

class ImageSourceExampleScreen extends StatefulWidget {
  const ImageSourceExampleScreen({Key? key}) : super(key: key);

  @override
  State<ImageSourceExampleScreen> createState() =>
      _ImageSourceExampleScreenState();
}

class _ImageSourceExampleScreenState extends State<ImageSourceExampleScreen> {
  /// Map controller
  MapboxMapController? _controller;

  /// Method to handle onMapCreated callback
  void _onMapCreated(MapboxMapController controller) {
    _controller = controller;
  }

  Future<void> _addImageSource() async {
    _controller
        ?.addSource<ImageSource>(
      source: ImageSource(
        sourceId: "radar-image-source",
        url: "https://docs.mapbox.com/mapbox-gl-js/assets/radar.gif",
        coordinates: [
          [-80.425, 46.437],
          [-71.516, 46.437],
          [-71.516, 37.936],
          [-80.425, 37.936]
        ],
      ),
    )
        .then((value) {
      _addRasterLayer();
    });
  }

  Future<void> _addRasterLayer() async {
    await _controller?.addLayer<RasterLayer>(
      layer: RasterLayer(
        layerId: "raster-layer-id",
        sourceId: "radar-image-source",
        layerProperties: RasterLayerProperties(
          rasterFadeDuration: 0,
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
            onPressed: _addImageSource,
            label: const Text(
              "Add Image Source & Raster Layer",
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
            center: Point.fromLngLat(-75.789, 41.874),
            zoom: 5.0,
            animationOptions: AnimationOptions.mapAnimationOptions(
              startDelay: 300,
              duration: const Duration(milliseconds: 750),
            ),
          ),
          onMapCreated: _onMapCreated,
        ),
      ),
    );
  }
}
