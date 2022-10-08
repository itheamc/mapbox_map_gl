import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_map_gl/src/mapbox_map.dart';
import 'layers/layer.dart';
import 'sources/image_source.dart';
import 'sources/raster_dem_source.dart';
import 'sources/raster_source.dart';
import 'sources/source.dart';
import 'sources/vector_source.dart';
import 'sources/video_source.dart';
import 'layers/circle_layer.dart';
import 'layers/fill_layer.dart';
import 'layers/line_layer.dart';
import 'layers/symbol_layer.dart';
import 'layers/raster_layer.dart';
import 'sources/geojson_source.dart';
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
  MethodChannel get _channel => _glPlatform.channel;

  /// Method to toggle the map style between two styles
  /// [style1] - the first style (MapStyle)
  /// [style2] - the second style (MapStyle)
  @override
  Future<void> toggleBetween(MapStyle style1, MapStyle style2) async {
    try {
      final args = <String, dynamic>{
        "style1": style1.name,
        "style2": style2.name,
      };

      await _channel.invokeMethod<bool>(Methods.toggleAmong, args);
    } on Exception catch (e, _) {
      if (kDebugMode) {
        print("[MapboxMapController.toggleBetween] -----> $e");
      }
    }
  }

  /// Method to toggle the map style among given styles
  /// [styles] - the list of styles (List<MapStyle>)
  @override
  Future<void> toggleAmong(List<MapStyle> styles) async {
    try {
      await _channel.invokeMethod<bool>(
          Methods.toggleAmong, styles.map((e) => e.name).toList());
    } on Exception catch (e, _) {
      if (kDebugMode) {
        print("[MapboxMapController.toggleAmong] -----> $e");
      }
    }
  }

  /// Method to animate camera position to the given coordinate
  @override
  Future<void> animateCameraPosition(CameraPosition cameraPosition) async {
    try {
      await _channel.invokeMethod(
          Methods.animateCameraPosition, cameraPosition.toMap());
    } on Exception catch (e, _) {
      if (kDebugMode) {
        print("[MapboxMapController.animateCameraPosition] -----> $e");
      }
    }
  }

  /// Method to check if style layer is already existed
  @override
  Future<bool> isLayerExist(String layerId) async {
    try {
      final isExist =
          await _channel.invokeMethod<bool>(Methods.isLayerExist, layerId);
      return isExist ?? false;
    } on Exception catch (e, _) {
      if (kDebugMode) {
        print("[MapboxMapController.isLayerExist] -----> $e");
      }
    }
    return false;
  }

  /// Method to check if source is already existed
  @override
  Future<bool> isSourceExist(String sourceId) async {
    try {
      final isExist =
          await _channel.invokeMethod<bool>(Methods.isSourceExist, sourceId);
      return isExist ?? false;
    } on Exception catch (e, _) {
      if (kDebugMode) {
        print("[MapboxMapController.isSourceExist] -----> $e");
      }
    }
    return false;
  }

  /// Generic method to add style source to the map
  @override
  Future<void> addSource<T extends Source>({required T source}) async {
    try {
      final method = source.runtimeType == GeoJsonSource
          ? Methods.addGeoJsonSource
          : source.runtimeType == VectorSource
              ? Methods.addVectorSource
              : source.runtimeType == RasterSource
                  ? Methods.addRasterSource
                  : source.runtimeType == RasterDemSource
                      ? Methods.addRasterDemSource
                      : source.runtimeType == ImageSource
                          ? Methods.addImageSource
                          : source.runtimeType == VideoSource
                              ? Methods.addVideoSource
                              : null;
      if (method == null) {
        if (kDebugMode) {
          print(
              "[MapboxMapController.addSource<T>] -----> Unspecified Source!");
        }
        return;
      }

      await _channel.invokeMethod(method, source.toMap());
    } on Exception catch (e, _) {
      if (kDebugMode) {
        print("[MapboxMapController.addSource] -----> $e");
      }
    }
  }

  /// Generic method to add style layer to the map
  @override
  Future<void> addLayer<T extends Layer>({required T layer}) async {
    try {
      final method = layer.runtimeType == CircleLayer
          ? Methods.addCircleLayer
          : layer.runtimeType == FillLayer
              ? Methods.addFillLayer
              : layer.runtimeType == LineLayer
                  ? Methods.addLineLayer
                  : layer.runtimeType == RasterLayer
                      ? Methods.addRasterLayer
                      : layer.runtimeType == SymbolLayer
                          ? Methods.addSymbolLayer
                          : null;
      if (method == null) {
        if (kDebugMode) {
          print("[MapboxMapController.addLayer<T>] -----> Unspecified Layer!");
        }
        return;
      }

      await _channel.invokeMethod(method, layer.toMap());
    } on Exception catch (e, _) {
      if (kDebugMode) {
        print("[MapboxMapController.addLayer] -----> $e");
      }
    }
  }

  /// Method to remove added style layer
  /// [layerId] - An id of style layer that you want to remove
  @override
  Future<bool> removeLayer(String layerId) async {
    try {
      return await _channel.invokeMethod<bool>(Methods.removeLayer, layerId) ??
          false;
    } on Exception catch (e, _) {
      if (kDebugMode) {
        print("[MapboxMapController.removeLayer] -----> $e");
      }
    }
    return false;
  }

  /// Method to remove list of added style layers
  /// [layersId] - List of layers id that you want to remove
  @override
  Future<bool> removeLayers(List<String> layersId) async {
    try {
      return await _channel.invokeMethod<bool>(
              Methods.removeLayers, layersId) ??
          false;
    } on Exception catch (e, _) {
      if (kDebugMode) {
        print("[MapboxMapController.removeLayers] -----> $e");
      }
    }
    return false;
  }

  /// Method to remove added source
  /// [sourceId] - An id of the source that you want to remove
  @override
  Future<bool> removeSource(String sourceId) async {
    try {
      return await _channel.invokeMethod<bool>(
              Methods.removeSource, sourceId) ??
          false;
    } on Exception catch (e, _) {
      if (kDebugMode) {
        print("[MapboxMapController.removeSource] -----> $e");
      }
    }
    return false;
  }

  /// Method to remove list of added sources
  /// [sourcesId] - List of sources id that you want to remove
  @override
  Future<bool> removeSources(List<String> sourcesId) async {
    try {
      return await _channel.invokeMethod<bool>(
              Methods.removeSources, sourcesId) ??
          false;
    } on Exception catch (e, _) {
      if (kDebugMode) {
        print("[MapboxMapController.removeSources] -----> $e");
      }
    }
    return false;
  }
}
