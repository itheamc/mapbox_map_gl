import 'package:flutter/cupertino.dart';

mixin MapboxMapGlViewInterface {
  Widget buildMapView({
    required Map<String, dynamic> creationParams,
    void Function(int id)? onPlatformViewCreated,
    bool hyperComposition = false,
  });
}
