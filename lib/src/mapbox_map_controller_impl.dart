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

  /// Method to check if style image is already existed
  @override
  Future<bool> isStyleImageExist(String imageId) async {
    try {
      final isExist =
          await _channel.invokeMethod<bool>(Methods.isStyleImageExist, imageId);
      return isExist ?? false;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "isStyleImageExist",
        message: e,
      );
    }
    return false;
  }

  /// Method to check if style model is already existed
  @override
  Future<bool> isStyleModelExist(String modelId) async {
    try {
      final isExist =
          await _channel.invokeMethod<bool>(Methods.isStyleModelExist, modelId);
      return isExist ?? false;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "isStyleModelExist",
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

  /// Method to remove style image
  /// [imageId] - An id of the style image that you want to remove
  @override
  Future<bool> removeStyleImage(String imageId) async {
    try {
      return await _channel.invokeMethod<bool>(
              Methods.removeStyleImage, imageId) ??
          false;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "removeStyleImage",
        message: e,
      );
    }
    return false;
  }

  /// Method to add style model to be used in the style.
  /// This API can also be used for updating a model as well.
  /// If the model for a given modelId was already added, it gets replaced by
  /// the new model. The model can be used in model-id property in model layer.
  /// Params:
  /// modelId - An identifier of the model.
  /// modelUri - A URI for the model.
  @override
  Future<bool> addStyleModel(String modelId, String modelUri) async {
    try {
      final args = <String, dynamic>{
        "modelId": modelId,
        "modelUri": modelUri,
      };

      final isAdded =
          await _channel.invokeMethod<bool>(Methods.addStyleModel, args);

      return isAdded ?? false;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "addStyleModel",
        message: e,
      );
    }
    return false;
  }

  /// Method to set style source property for given id
  /// [sourceId] - An id of the style source
  /// [property] - Name of the property
  /// [value] - Value for that property
  @override
  Future<bool> setStyleSourceProperty({
    required String sourceId,
    required String property,
    required dynamic value,
  }) async {
    try {
      final args = <String, dynamic>{
        "sourceId": sourceId,
        "property": property,
        "value": value,
      };

      final result = await _channel.invokeMethod<bool>(
          Methods.setStyleSourceProperty, args);

      return result ?? false;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "setStyleSourceProperty",
        message: e,
      );
    }
    return false;
  }

  /// Method to set style source properties for given id
  /// [sourceId] - An id of the style source
  /// [properties] - properties with key and value
  @override
  Future<bool> setStyleSourceProperties({
    required String sourceId,
    required Map<String, dynamic> properties,
  }) async {
    try {
      final args = <String, dynamic>{
        "sourceId": sourceId,
        "properties": properties,
      };

      final result = await _channel.invokeMethod<bool>(
          Methods.setStyleSourceProperties, args);

      return result ?? false;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "setStyleSourceProperties",
        message: e,
      );
    }
    return false;
  }

  /// Method to set style layer property for given id
  /// [layerId] - An id of the style layer
  /// [property] - Name of the property
  /// [value] - Value for that property
  @override
  Future<bool> setStyleLayerProperty({
    required String layerId,
    required String property,
    required dynamic value,
  }) async {
    try {
      final args = <String, dynamic>{
        "layerId": layerId,
        "property": property,
        "value": value,
      };

      final result = await _channel.invokeMethod<bool>(
          Methods.setStyleLayerProperty, args);

      return result ?? false;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "setStyleLayerProperty",
        message: e,
      );
    }
    return false;
  }

  /// Method to set style layer properties for given id
  /// [layerId] - An id of the style layer
  /// [properties] - properties with key and value
  @override
  Future<bool> setStyleLayerProperties({
    required String layerId,
    required Map<String, dynamic> properties,
  }) async {
    try {
      final args = <String, dynamic>{
        "layerId": layerId,
        "properties": properties,
      };

      final result = await _channel.invokeMethod<bool>(
          Methods.setStyleLayerProperties, args);

      return result ?? false;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "setStyleLayerProperties",
        message: e,
      );
    }
    return false;
  }

  /// Method to move style layer above of given layer
  /// [layerId] - An id of the style layer to move above
  /// [belowLayerId] - id of style layer which above the given layer
  /// will be move
  @override
  Future<bool> moveStyleLayerAbove({
    required String layerId,
    required String belowLayerId,
  }) async {
    try {
      final args = <String, dynamic>{
        "layerId": layerId,
        "belowLayerId": belowLayerId,
      };

      final result =
          await _channel.invokeMethod<bool>(Methods.moveStyleLayerAbove, args);

      return result ?? false;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "moveStyleLayerAbove",
        message: e,
      );
    }
    return false;
  }

  /// Method to move style layer below of given layer
  /// [layerId] - An id of the style layer to move below
  /// [aboveLayerId] - id of style layer which below the given layer
  /// will be move
  @override
  Future<bool> moveStyleLayerBelow({
    required String layerId,
    required String aboveLayerId,
  }) async {
    try {
      final args = <String, dynamic>{
        "layerId": layerId,
        "aboveLayerId": aboveLayerId,
      };

      final result =
          await _channel.invokeMethod<bool>(Methods.moveStyleLayerBelow, args);

      return result ?? false;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "moveStyleLayerBelow",
        message: e,
      );
    }
    return false;
  }

  /// Method to move style layer at given position
  /// [layerId] - An id of the style layer to move at given position
  /// [at] - position to move layer
  @override
  Future<bool> moveStyleLayerAt({
    required String layerId,
    required int at,
  }) async {
    try {
      final args = <String, dynamic>{
        "layerId": layerId,
        "at": at,
      };

      final result =
          await _channel.invokeMethod<bool>(Methods.moveStyleLayerAt, args);

      return result ?? false;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "moveStyleLayerAt",
        message: e,
      );
    }
    return false;
  }
}
