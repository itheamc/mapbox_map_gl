import 'package:flutter/material.dart';

import 'mapbox_map_gl_platform_interface.dart';

class MapboxMapGl {
  Widget buildView({
    required Map<String, dynamic> creationParams,
    void Function(int id)? onPlatformViewCreated,
    bool hyperComposition = false,
  }) {
    return MapboxMapGlPlatform.instance.buildView(
        creationParams: creationParams,
        onPlatformViewCreated: onPlatformViewCreated);
  }
}
