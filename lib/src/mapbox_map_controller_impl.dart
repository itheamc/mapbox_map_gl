import 'package:flutter/services.dart';
import 'layers/circle_layer.dart';
import 'layers/fill_layer.dart';
import 'layers/line_layer.dart';
import 'layers/symbol_layer.dart';
import 'helper/camera_position.dart';
import 'helper/methods.dart';

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
    await channel.invokeMethod(
        Methods.animateCameraPosition, cameraPosition.toMap());
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
  Future<void> addGeoJsonSource({
    required String sourceId,
    required String layerId,
    CircleLayer? circleLayer,
    LineLayer? lineLayer,
    SymbolLayer? symbolLayer,
    FillLayer? fillLayer,
  }) async {
    final args = <String, dynamic>{};

    args['sourceId'] = sourceId;
    args['layerId'] = layerId;
    args['circleLayer'] = circleLayer?.toMap();
    args['lineLayer'] = lineLayer?.toMap();
    args['fillLayer'] = fillLayer?.toMap();
    args['symbolLayer'] = symbolLayer?.toArgs();

    await channel.invokeMethod("addGeoJsonSource", args);
  }
}
