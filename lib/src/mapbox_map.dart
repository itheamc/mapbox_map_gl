import 'package:flutter/material.dart';
import 'package:mapbox_map_gl/src/camera_position.dart';

import 'mapbox_map_gl_platform_interface.dart';

class MapboxMap extends StatefulWidget {
  final CameraPosition? initialCameraPosition;

  const MapboxMap({
    Key? key,
    this.initialCameraPosition,
  }) : super(key: key);

  @override
  State<MapboxMap> createState() => _MapboxMapState();
}

class _MapboxMapState extends State<MapboxMap> {
  @override
  Widget build(BuildContext context) {
    final creationParams = <String, dynamic>{};

    creationParams['initialCameraPosition'] =
        widget.initialCameraPosition?.toJson();


    return MapboxMapGlPlatform.instance.buildMapView(
        creationParams: creationParams,
        onPlatformViewCreated: (id) {

        });
  }
}
