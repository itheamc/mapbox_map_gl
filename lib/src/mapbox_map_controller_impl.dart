import 'package:flutter/services.dart';
import 'package:mapbox_map_gl/src/layers/circle_layer.dart';
import 'package:mapbox_map_gl/src/utils/camera_position.dart';
import 'package:mapbox_map_gl/src/utils/methods.dart';

import 'mapbox_map_controller.dart';

import 'mapbox_map_gl_platform_interface.dart';

class MapboxMapControllerImpl extends MapboxMapController {
  /// MapboxMapGlPlatform Instance
  final MapboxMapGlPlatform _glPlatform;

  /// Constructor
  MapboxMapControllerImpl(this._glPlatform);

  /// Getter for Method channel
  MethodChannel get channel => _glPlatform.channel;

  @override
  Future<void> animateCameraPosition(CameraPosition cameraPosition) async {
    await channel.invokeMethod(Methods.animateCameraPosition, cameraPosition.toJson());
  }

  @override
  Future<void> toggleMode({bool dark = false}) async {
    await channel.invokeMethod(Methods.toggleMode, dark);
  }

  @override
  Future<bool> isLayerExist(String layerId, LayerType layerType) async {
    final isExist =
        await channel.invokeMethod<bool>(Methods.isLayerExist, layerId);
    return isExist ?? false;
  }

  @override
  Future<bool> isSourceExist(String sourceId) async {
    final isExist =
        await channel.invokeMethod<bool>(Methods.isSourceExist, sourceId);
    return isExist ?? false;
  }

  @override
  Future<void> addGeoJsonSource({required String sourceId, required String layerId, CircleLayer? circleLayer}) async {

    final args = <String, dynamic>{};

    args['sourceId'] = sourceId;
    args['layerId'] = layerId;
    args['circleLayer'] = circleLayer?.toJson();
    args['lineLayer'] = null;
    args['fillLayer'] = null;
    args['symbolLayer'] = null;

    await channel.invokeMethod("addGeoJsonSource", args);
  }


}
