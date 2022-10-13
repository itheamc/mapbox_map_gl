import 'package:flutter/services.dart';
import 'utils/log_util.dart';
import 'layers/background_layer.dart';
import 'layers/fill_extrusion_layer.dart';
import 'layers/heatmap_layer.dart';
import 'layers/hill_shade_layer.dart';
import 'layers/location_indicator_layer.dart';
import 'layers/sky_layer.dart';
import 'mapbox_map.dart';
import 'style_images/local_style_image.dart';
import 'style_images/network_style_image.dart';
import 'style_images/style_image.dart';
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
import 'utils/camera_position.dart';
import 'utils/methods.dart';

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
  /// [onStyleToggled] - callback for style toggled
  @override
  Future<void> toggleBetween(MapStyle style1, MapStyle style2,
      {OnStyleToggled? onStyleToggled}) async {
    try {
      final args = <String>[
        style1.name,
        style2.name,
      ];

      final response =
          await _channel.invokeMethod<String?>(Methods.toggleStyle, args);

      if (response != null) {
        onStyleToggled?.call(MapStyle.values.byName(response));
      }
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "toggleBetween",
        message: e,
      );
    }
  }

  /// Method to toggle the map style among given styles
  /// [styles] - the list of styles (List<MapStyle>)
  /// [onStyleToggled] - callback for style toggled
  @override
  Future<void> toggleAmong(List<MapStyle> styles,
      {OnStyleToggled? onStyleToggled}) async {
    try {
      final response = await _channel.invokeMethod<String>(
          Methods.toggleStyle, styles.map((e) => e.name).toList());

      if (response != null) {
        onStyleToggled?.call(MapStyle.values.byName(response));
      }
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "toggleAmong",
        message: e,
      );
    }
  }

  /// Method to animate camera position to the given coordinate
  @override
  Future<void> animateCameraPosition(CameraPosition cameraPosition) async {
    try {
      await _channel.invokeMethod(
          Methods.animateCameraPosition, cameraPosition.toMap());
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "animateCameraPosition",
        message: e,
      );
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
      LogUtil.log(
        className: "MapboxMapController",
        function: "isLayerExist",
        message: e,
      );
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
      LogUtil.log(
        className: "MapboxMapController",
        function: "isSourceExist",
        message: e,
      );
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
        LogUtil.log(
          className: "MapboxMapController",
          function: "addSource<T>",
          message: "Unspecified Source!",
        );
        return;
      }

      await _channel.invokeMethod(method, source.toMap());
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "addSource",
        message: e,
      );
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
                          : layer.runtimeType == HeatmapLayer
                              ? Methods.addHeatmapLayer
                              : layer.runtimeType == HillShadeLayer
                                  ? Methods.addHillShadeLayer
                                  : layer.runtimeType == FillExtrusionLayer
                                      ? Methods.addFillExtrusionLayer
                                      : layer.runtimeType == SkyLayer
                                          ? Methods.addSkyLayer
                                          : layer.runtimeType == BackgroundLayer
                                              ? Methods.addBackgroundLayer
                                              : layer.runtimeType ==
                                                      LocationIndicatorLayer
                                                  ? Methods
                                                      .addLocationIndicatorLayer
                                                  : null;
      if (method == null) {
        LogUtil.log(
          className: "MapboxMapController",
          function: "addLayer<T>",
          message: "Unspecified Layer!",
        );
        return;
      }

      await _channel.invokeMethod(method, layer.toMap());
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "addLayer",
        message: e,
      );
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
      LogUtil.log(
        className: "MapboxMapController",
        function: "removeLayer",
        message: e,
      );
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
      LogUtil.log(
        className: "MapboxMapController",
        function: "removeLayers",
        message: e,
      );
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
      LogUtil.log(
        className: "MapboxMapController",
        function: "removeSource",
        message: e,
      );
    }
    return false;
  }

  /// Method to remove list of added sources
  /// [sourcesId] - List of sources id that you want to remove
  @override
  Future<bool> removeSources(List<String> sourcesId) async {
    try {
      for (final id in sourcesId) {
        await _channel.invokeMethod<bool>(Methods.removeSource, id);
      }

      return true;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "removeSources",
        message: e,
      );
    }
    return false;
  }

  @override
  Future<bool> addStyleImage<T extends StyleImage>({required T image}) async {
    try {
      if (image is LocalStyleImage) {
        final byteArray = await image.getByteArray();

        if (byteArray != null) {
          final args = <String, dynamic>{};

          args["imageId"] = image.imageId;
          args["byteArray"] = byteArray;
          args["sdf"] = image.sdf;

          final isAdded =
              await _channel.invokeMethod<bool>(Methods.addStyleImage, args);
          return isAdded ?? false;
        }
        return false;
      }

      final byteArray = await (image as NetworkStyleImage).getByteArray();

      if (byteArray != null) {
        final args = <String, dynamic>{};

        args["imageId"] = image.imageId;
        args["byteArray"] = byteArray;
        args["sdf"] = image.sdf;

        final isAdded =
            await _channel.invokeMethod<bool>(Methods.addStyleImage, args);
        return isAdded ?? false;
      }
      return false;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "addStyleImage",
        message: e,
      );
    }
    return false;
  }
}
