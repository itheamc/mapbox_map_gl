import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_map_gl/mapbox_map_gl.dart';

class RasterSourceExampleScreen extends StatefulWidget {
  const RasterSourceExampleScreen({Key? key}) : super(key: key);

  @override
  State<RasterSourceExampleScreen> createState() =>
      _RasterSourceExampleScreenState();
}

class _RasterSourceExampleScreenState extends State<RasterSourceExampleScreen> {
  /// Map controller
  MapboxMapController? _controller;

  /// Method to handle onMapCreated callback
  void _onMapCreated(MapboxMapController controller) {
    _controller = controller;
  }

  Future<void> _addRasterSource() async {
    _controller
        ?.addSource<RasterSource>(
      source: RasterSource(
          sourceId: "example-raster-tiles",
          tiles: [
            "https://stamen-tiles.a.ssl.fastly.net/watercolor/{z}/{x}/{y}.jpg"
          ],
          sourceProperties: RasterSourceProperties(
              tileSize: 256, attribution: "By Stamen Design")),
    )
        .then((value) {
      _addRasterLayer();
    });
  }

  Future<void> _addRasterLayer() async {
    await _controller?.addLayer<RasterLayer>(
      layer: RasterLayer(
        layerId: "raster-layer-id",
        sourceId: "example-raster-tiles",
        layerProperties: RasterLayerProperties(
          minZoom: 0,
          maxZoom: 22,
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
            center: Point.fromLngLat(-74.5, 40.0),
            zoom: 2.0,
            animationOptions: AnimationOptions.mapAnimationOptions(
              startDelay: 300,
              duration: const Duration(milliseconds: 750),
            ),
          ),
          onMapCreated: _onMapCreated,
          onStyleLoaded: () async {
            final isAlreadyAdded =
                await _controller?.isSourceExist("example-raster-tiles") ?? false;
            if (!isAlreadyAdded) {
              _addRasterSource();
            }
          },
        ),
      ),
    );
  }
}
