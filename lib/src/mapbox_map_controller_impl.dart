import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mapbox_map_gl/src/annotations/circle_annotation.dart';
import 'package:mapbox_map_gl/src/annotations/point_annotation.dart';
import 'package:mapbox_map_gl/src/annotations/polygon_annotation.dart';
import 'package:mapbox_map_gl/src/annotations/polyline_annotation.dart';
import 'annotations/annotation.dart';
import 'utils/feature.dart';
import 'utils/point.dart';
import 'utils/enums.dart';
import 'utils/queried_feature.dart';
import 'utils/rendered_query_geometry.dart';
import 'utils/rendered_query_options.dart';
import 'utils/screen_coordinate.dart';
import 'utils/source_query_options.dart';
import 'utils/listeners.dart';
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

  /// Method to handle callbacks
  @override
  void callbacks(Map<String, dynamic> params) {
    final method = params["method"] as String;
    final args = params["args"];

    switch (method) {
      case Methods.onMapIdle:
        _handlingOnMapIdleListener(args);
        break;
      case Methods.onCameraChange:
        _handlingOnCameraChangeListener(args);
        break;
      case Methods.onSourceAdded:
        _handlingOnSourceAddedListener(args);
        break;
      case Methods.onSourceDataLoaded:
        _handlingOnSourceDataLoadedListener(args);
        break;
      case Methods.onSourceRemoved:
        _handlingOnSourceRemovedListener(args);
        break;
      case Methods.onRenderFrameStarted:
        _handlingOnRenderFrameStartedListener(args);
        break;
      case Methods.onRenderFrameFinished:
        _handlingOnRenderFrameFinishedListener(args);
        break;
      default:
    }
  }

  /// List of OnMapIdleListeners
  final List<OnMapIdleListener> _onMapIdleListeners =
      List.empty(growable: true);

  /// List of OnCameraChangeListener
  final List<OnCameraChangeListener> _onCameraChangeListeners =
      List.empty(growable: true);

  /// List of OnSourceAddedListeners
  final List<OnSourceAddedListener> _onSourceAddedListeners =
      List.empty(growable: true);

  /// List of OnSourceDataLoadedListener
  final List<OnSourceDataLoadedListener> _onSourceDataLoadedListeners =
      List.empty(growable: true);

  /// List of OnSourceRemovedListener
  final List<OnSourceRemovedListener> _onSourceRemovedListeners =
      List.empty(growable: true);

  /// List of OnRenderFrameStartedListener
  final List<OnRenderFrameStartedListener> _onRenderFrameStartedListeners =
      List.empty(growable: true);

  /// List of OnRenderFrameFinishedListener
  final List<OnRenderFrameFinishedListener> _onRenderFrameFinishedListeners =
      List.empty(growable: true);

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

  /// Method to remove added style model
  /// [modelId] - An id of style model that you want to remove
  @override
  Future<bool> removeStyleModel(String modelId) async {
    try {
      return await _channel.invokeMethod<bool>(
              Methods.removeStyleModel, modelId) ??
          false;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "removeStyleModel",
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

  /// Queries the map for source features.
  /// Params:
  /// [sourceId] - Style source identifier used to query for source features.
  /// [queryOptions] - Options for querying source features.
  /// Returns:
  /// An array of queried features.
  @override
  Future<List<QueriedFeature>?> querySourceFeatures({
    required String sourceId,
    required SourceQueryOptions queryOptions,
  }) async {
    try {
      final args = <String, dynamic>{
        "sourceId": sourceId,
        "options": queryOptions.toMap(),
      };

      final result = await _channel.invokeMethod<dynamic>(
          Methods.querySourceFeatures, args);

      if (result == null || result.runtimeType != List<Object?>) return null;

      final queriedFeatures = List<QueriedFeature>.empty(growable: true);

      for (final item in result) {
        queriedFeatures.add(QueriedFeature.fromArgs(item));
      }

      return queriedFeatures;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "querySourceFeatures",
        message: e,
      );
    }
    return null;
  }

  /// Queries the map for rendered features.
  /// Params:
  /// [geometry] - The screen pixel coordinates (point, line string or box)
  /// to query for rendered features.
  /// [queryOptions] - The render query options for querying rendered features.
  /// Returns:
  /// An array of queried features.
  @override
  Future<List<QueriedFeature>?> queryRenderedFeatures({
    required RenderedQueryGeometry geometry,
    required RenderedQueryOptions queryOptions,
  }) async {
    try {
      final args = <String, dynamic>{
        "geometry": geometry.toMap(),
        "options": queryOptions.toMap(),
      };

      final result = await _channel.invokeMethod<dynamic>(
          Methods.queryRenderedFeatures, args);

      if (result == null || result.runtimeType != List<Object?>) return null;

      final queriedFeatures = List<QueriedFeature>.empty(growable: true);

      for (final item in result) {
        queriedFeatures.add(QueriedFeature.fromArgs(item));
      }

      return queriedFeatures;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "queryRenderedFeatures",
        message: e,
      );
    }
    return null;
  }

  /// Returns the children (original points or clusters) of a cluster
  /// (on the next zoom level) given its id (cluster_id value from
  /// feature properties) from a GeoJsonSource.
  /// Requires configuring the source as a cluster by calling
  /// GeoJsonSource.Builder#cluster(boolean).
  /// Params:
  /// [sourceId] - GeoJsonSource identifier.
  /// [cluster] - cluster from which to retrieve children from
  @override
  Future<List<Feature>?> getGeoJsonClusterChildren({
    required String sourceId,
    required Feature cluster,
  }) async {
    try {
      final args = <String, dynamic>{
        "sourceId": sourceId,
        "cluster": jsonEncode(cluster.toMap()),
      };

      final result = await _channel.invokeMethod<dynamic>(
          Methods.getGeoJsonClusterChildren, args);

      if (result == null || result.runtimeType != List<Object?>) return null;

      final features = List<Feature>.empty(growable: true);

      for (final item in result) {
        features.add(Feature.fromArgs(item));
      }

      return features;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "getGeoJsonClusterChildren",
        message: e,
      );
    }
    return null;
  }

  /// Returns all the leaves (original points) of a cluster
  /// (given its cluster_id) from a GeoJsonSource, with pagination support:
  /// limit is the number of leaves to return (set to Infinity for all points),
  /// and offset is the amount of points to skip (for pagination).
  ///
  /// Requires configuring the source as a cluster by calling
  /// GeoJsonSource.Builder#cluster(boolean).
  /// Params:
  /// [sourceId] - GeoJsonSource identifier.
  /// [cluster] - Cluster from which to retrieve leaves from
  /// [limit] - The number of points to return from the query,
  /// set to maximum for all points). Defaults to 10.
  /// [offset] - The amount of points to skip. Defaults to 0.
  @override
  Future<List<Feature>?> getGeoJsonClusterLeaves({
    required String sourceId,
    required Feature cluster,
    int limit = 10,
    int offset = 0,
  }) async {
    try {
      final args = <String, dynamic>{
        "sourceId": sourceId,
        "cluster": jsonEncode(cluster.toMap()),
        "limit": limit,
        "offset": offset,
      };

      final result = await _channel.invokeMethod<dynamic>(
          Methods.getGeoJsonClusterLeaves, args);

      if (result == null || result.runtimeType != List<Object?>) return null;

      final features = List<Feature>.empty(growable: true);

      for (final item in result) {
        features.add(Feature.fromArgs(item));
      }

      return features;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "getGeoJsonClusterLeaves",
        message: e,
      );
    }
    return null;
  }

  /// Update the state map of a feature within a style source.
  /// Update entries in the state map of a given feature within a style source.
  /// Only entries listed in the state map will be updated. An entry in the
  /// feature state map that is not listed in state will retain its
  /// previous value.
  /// Note that updates to feature state are asynchronous, so changes made
  /// by this method might not be immediately visible using getStateFeature().
  /// Params:
  /// [sourceId] - Style source identifier.
  /// [sourceLayerId] - Style source layer identifier (for multi-layer sources such as vector sources).
  /// [featureId] - Identifier of the feature whose state should be updated.
  /// [state] - Map of entries to update with their respective new values.
  @override
  Future<void> setFeatureState({
    required String sourceId,
    required String featureId,
    String? sourceLayerId,
    required Map<String, dynamic> state,
  }) async {
    try {
      final args = <String, dynamic>{
        "sourceId": sourceId,
        "featureId": featureId,
        "sourceLayerId": sourceLayerId,
        "state": state,
      };

      await _channel.invokeMethod<dynamic>(Methods.setFeatureState, args);
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "setFeatureState",
        message: e,
      );
    }
  }

  /// Remove entries from a feature state map.
  /// Remove a specified entry or all entries from a feature's state map,
  /// depending on the value of stateKey.
  /// Params:
  /// [sourceId] - Style source identifier.
  /// [sourceLayerId] - Style source layer identifier
  /// (for multi-layer sources such as vector sources).
  /// [featureId] - Identifier of the feature whose state should be removed.
  /// [stateKey] - Key of the entry to remove. If empty, the entire state is
  /// removed.
  @override
  Future<void> removeFeatureState({
    required String sourceId,
    required String featureId,
    String? sourceLayerId,
    required String? stateKey,
  }) async {
    try {
      final args = <String, dynamic>{
        "sourceId": sourceId,
        "featureId": featureId,
        "sourceLayerId": sourceLayerId,
        "stateKey": stateKey,
      };

      await _channel.invokeMethod<dynamic>(Methods.removeFeatureState, args);
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "removeFeatureState",
        message: e,
      );
    }
  }

  /// Get the state map of a feature within a style source.
  /// [sourceId] - Style source identifier.
  /// [sourceLayerId] - Style source layer identifier (for multi-layer sources
  /// such as vector sources).
  /// [featureId] - Identifier of the feature whose state should be queried.
  /// It will return feature's state map or an empty map if the feature could
  /// not be found.
  @override
  Future<dynamic> getFeatureState({
    required String sourceId,
    required String featureId,
    String? sourceLayerId,
  }) async {
    try {
      final args = <String, dynamic>{
        "sourceId": sourceId,
        "featureId": featureId,
        "sourceLayerId": sourceLayerId,
      };

      final result =
          await _channel.invokeMethod<dynamic>(Methods.getFeatureState, args);
      return result;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "getFeatureState",
        message: e,
      );
    }
    return null;
  }

  /// Will load a new map style asynchronous from the specified style json data.
  /// [styleJson] - A style json data
  @override
  Future<void> loadStyleJson(String styleJson) async {
    try {
      await _channel.invokeMethod<dynamic>(Methods.loadStyleJson, styleJson);
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "loadStyleJson",
        message: e,
      );
    }
  }

  /// Will load a new map style asynchronous from the specified style style uri.
  /// [styleUri] - A style uri
  @override
  Future<void> loadStyleUri(String styleUri) async {
    try {
      await _channel.invokeMethod<dynamic>(Methods.loadStyleUri, styleUri);
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "loadStyleUri",
        message: e,
      );
    }
  }

  /// Reduce memory use. Useful to call when the application
  /// gets paused or sent to background.
  @override
  Future<void> reduceMemoryUse() async {
    try {
      await _channel.invokeMethod<dynamic>(Methods.reduceMemoryUse, null);
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "reduceMemoryUse",
        message: e,
      );
    }
  }

  /// Triggers a repaint of the map.
  @override
  Future<void> triggerRepaint() async {
    try {
      await _channel.invokeMethod<dynamic>(Methods.triggerRepaint, null);
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "triggerRepaint",
        message: e,
      );
    }
  }

  /// Set the map viewport mode
  /// Params:
  /// [viewportMode] - The map viewport mode to set
  @override
  Future<void> setViewportMode(ViewportMode viewportMode) async {
    try {
      final args =
          viewportMode == ViewportMode.defaultMode ? "DEFAULT" : "FLIPPED_Y";

      await _channel.invokeMethod<dynamic>(Methods.setViewportMode, args);
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "setViewportMode",
        message: e,
      );
    }
  }

  /// The memory budget hint to be used by the map. The budget can be given
  /// in tile units or in megabytes. A Map will do the best effort to keep
  /// memory allocations for a non essential resources within the budget.
  ///
  /// The memory budget distribution and resource eviction logic is a subject
  /// to change. Current implementation sets memory budget hint per data source.
  ///
  /// If null is set, the memory budget in tile units will be dynamically
  /// calculated based on the current viewport size.
  /// Params:
  /// [budgetIn] - The memory budget hint to be used by the Map.
  /// [value] - budget value
  @override
  Future<void> setMapMemoryBudget(MapMemoryBudgetIn budgetIn, int value) async {
    try {
      final args = <String, dynamic>{
        "budget_in": budgetIn.name,
        "value": value,
      };

      await _channel.invokeMethod<dynamic>(Methods.setMapMemoryBudget, args);
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "setMapMemoryBudget",
        message: e,
      );
    }
  }

  /// Gets the size of the map.
  /// Returns:
  /// [Size] - The size of the map in pixels
  @override
  Future<Size?> getMapSize() async {
    try {
      final result =
          await _channel.invokeMethod<dynamic>(Methods.getMapSize, null);

      if (result != null &&
          result['width'] != null &&
          result['height'] != null) {
        final size =
            Size(result['width'] as double, result['height'] as double);

        return size;
      }
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "getMapSize",
        message: e,
      );
    }
    return null;
  }

  /// Changes the map view by any combination of center, zoom, bearing,
  /// and pitch, without an animated transition. The map will retain its
  /// current values for any details not passed via the camera options argument.
  /// It is not guaranteed that the provided CameraOptions will be set, the
  /// map may apply constraints resulting in a different CameraState.
  /// Note: - animationOptions has no effect on it.
  /// Params:
  /// [cameraPosition] - New camera position
  @override
  Future<void> setCamera(CameraPosition cameraPosition) async {
    try {
      await _channel.invokeMethod<dynamic>(
          Methods.setCamera, cameraPosition.toMap());
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "setCamera",
        message: e,
      );
    }
  }

  /// Calculate a geographical coordinate(i.e., longitude-latitude pair) that
  /// corresponds to a screen coordinate.
  /// The screen coordinate is in MapOptions.size platform pixels relative to
  /// the top left of the map (not of the whole screen).
  /// Map must be fully loaded for getting an altitude-compliant result
  /// if using 3D terrain.
  /// This API isn't supported by Globe projection and will return a no-op
  /// result matching the center of the screen.
  /// See com.mapbox.maps.extension.style.projection.generated.setProjection
  /// and com.mapbox.maps.extension.style.projection.generated.getProjection
  /// Params:
  /// [pixel] - A screen coordinate represented by x y coordinates.
  /// Returns:
  /// Returns a geographical coordinate [Point] corresponding to the x y
  /// coordinates on the screen.
  @override
  Future<Point?> coordinateForPixel(ScreenCoordinate pixel) async {
    try {
      final result = await _channel.invokeMethod<dynamic>(
          Methods.coordinateForPixel, pixel.toMap());

      if (result != null) {
        final point = Point.fromArgs(result);
        return point;
      }
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "coordinateForPixel",
        message: e,
      );
    }
    return null;
  }

  /// Calculate geographical coordinates(i.e., longitude-latitude pair)
  /// that corresponds to screen coordinates.
  /// The screen coordinates are in MapOptions.size platform pixels relative
  /// to the top left of the map (not of the whole screen).
  /// Map must be fully loaded for getting an altitude-compliant result
  /// if using 3D terrain.
  /// This API isn't supported by Globe projection and will return a no-op
  /// result matching the center of the screen.
  /// See com.mapbox.maps.extension.style.projection.generated.setProjection
  /// and com.mapbox.maps.extension.style.projection.generated.getProjection
  /// Params:
  /// [pixels] - A batch of screen coordinates on the screen in pixels.
  /// Returns:
  /// Returns a batch of geographical coordinates [List<Point>] corresponding
  /// to the screen coordinates on the screen.
  @override
  Future<List<Point>?> coordinatesForPixels(
      List<ScreenCoordinate> pixels) async {
    try {
      final args = pixels.map((e) => e.toMap()).toList();

      final result = await _channel.invokeMethod<dynamic>(
          Methods.coordinatesForPixels, args);

      if (result != null && result is List) {
        final points = result.map((e) => Point.fromArgs(e)).toList();
        return points;
      }
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "coordinatesForPixels",
        message: e,
      );
    }
    return null;
  }

  /// Calculate a screen coordinate that corresponds to a geographical
  /// coordinate (i.e., longitude-latitude pair).
  /// The screen coordinate is in pixels relative to the top left of the map
  /// (not of the whole screen).
  /// Map must be fully loaded for getting an altitude-compliant result
  /// if using 3D terrain.
  /// If the screen coordinate is outside of the bounds of MapView the returned
  /// screen coordinate contains -1 for both coordinates.
  ///
  /// This API isn't supported by Globe projection and will return a no-op
  /// result matching center of the screen.
  /// See com.mapbox.maps.extension.style.projection.generated.setProjection
  /// and com.mapbox.maps.extension.style.projection.generated.getProjection
  /// Params:
  /// coordinate - A geographical coordinate on the map to convert
  /// to a screen coordinate.
  /// Returns:
  /// Returns a screen coordinate on the screen in pixels.
  /// If the screen coordinate is outside of the bounds of MapView the
  /// returned screen coordinate contains -1 for both coordinates.
  @override
  Future<ScreenCoordinate?> pixelForCoordinate(Point coordinate) async {
    try {
      final result = await _channel.invokeMethod<dynamic>(
          Methods.pixelForCoordinate, coordinate.toMap());

      if (result != null) {
        final screenCoordinate = ScreenCoordinate.fromArgs(result);
        return screenCoordinate;
      }
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "pixelForCoordinate",
        message: e,
      );
    }
    return null;
  }

  /// Calculate screen coordinates that corresponds to geographical coordinates
  /// (i.e., longitude-latitude pair).
  /// The screen coordinates are in pixels relative to the top left of the map
  /// (not of the whole screen).
  ///
  /// Map must be fully loaded for getting an altitude-compliant result
  /// if using 3D terrain.
  ///
  /// This API isn't supported by Globe projection and will return a no-op
  /// result matching the center of the screen.
  /// See com.mapbox.maps.extension.style.projection.generated.setProjection
  /// and com.mapbox.maps.extension.style.projection.generated.getProjection
  /// Params:
  /// coordinates - A batch of geographical coordinates on the map to convert
  /// to screen coordinates.
  /// Returns:
  /// Returns a batch of screen coordinates on the screen in pixels.
  @override
  Future<List<ScreenCoordinate>?> pixelsForCoordinates(
      List<Point> coordinates) async {
    try {
      final args = coordinates.map((e) => e.toMap()).toList();

      final result = await _channel.invokeMethod<dynamic>(
          Methods.pixelsForCoordinates, args);

      if (result != null && result is List) {
        final screenCoordinates =
            result.map((e) => ScreenCoordinate.fromArgs(e)).toList();
        return screenCoordinates;
      }
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "pixelsForCoordinates",
        message: e,
      );
    }
    return null;
  }

  /// Generic method to add style annotations
  /// You can add:
  /// - CircleAnnotation
  /// - PointAnnotation
  /// - PolylineAnnotation
  /// - Polygon Annotation
  /// return is annotation Map<String, dynamic> that contains
  /// - id,
  /// - type,
  /// - and data
  @override
  Future<Map<String, dynamic>?> addAnnotation<T extends Annotation>(
      {required T annotation}) async {
    try {
      final method = annotation.runtimeType == CircleAnnotation
          ? Methods.createCircleAnnotation
          : annotation.runtimeType == PointAnnotation
              ? Methods.createPointAnnotation
              : annotation.runtimeType == PolygonAnnotation
                  ? Methods.createPolygonAnnotation
                  : annotation.runtimeType == PolylineAnnotation
                      ? Methods.createPolylineAnnotation
                      : null;
      if (method == null) {
        LogUtil.log(
          className: "MapboxMapController",
          function: "addAnnotation<T>",
          message: "Unspecified annotation!",
        );
        return null;
      }

      Map<String, dynamic> args = annotation.toMap();

      if (method == Methods.createPointAnnotation) {
        final byteArray = await (annotation as PointAnnotation).getByteArray();

        if (byteArray != null) {
          args = <String, dynamic>{
            ...args,
            "iconImage": byteArray,
          };
        } else {
          args = <String, dynamic>{
            ...args,
            "iconImage": annotation.iconImage ?? "",
          };
        }
      }

      final result = await _channel.invokeMethod<dynamic>(method, args);

      final formattedResult = <String, dynamic>{};

      if (result != null) {
        if (result['id'] != null) {
          formattedResult['id'] = result['id'];
        }

        if (result['type'] != null) {
          formattedResult['type'] = result['type'];
        }

        if (result['data'] != null) {
          formattedResult['data'] = jsonDecode(result['data']);
        } else {
          formattedResult['data'] = null;
        }
      }

      return formattedResult.isNotEmpty ? formattedResult : null;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "MapboxMapController",
        function: "addAnnotation<T>",
        message: e,
      );
    }
    return null;
  }

  /// Method to add onMapIdle listener
  @override
  void setOnMapIdleListener(OnMapIdleListener onMapIdleListener) {
    _onMapIdleListeners.add(onMapIdleListener);
  }

  /// Method to add OnCameraChange listener
  @override
  void setOnCameraChangeListener(
      OnCameraChangeListener onCameraChangeListener) {
    _onCameraChangeListeners.add(onCameraChangeListener);
  }

  /// Method to add onSourceAdded listener
  @override
  void setOnSourceAddedListener(OnSourceAddedListener onSourceAddedListener) {
    _onSourceAddedListeners.add(onSourceAddedListener);
  }

  /// Method to add onSourceDataLoaded listener
  @override
  void setOnSourceDataLoadedListener(
      OnSourceDataLoadedListener onSourceDataLoadedListener) {
    _onSourceDataLoadedListeners.add(onSourceDataLoadedListener);
  }

  /// Method to add onSourceRemoved listener
  @override
  void setOnSourceRemovedListener(
      OnSourceRemovedListener onSourceRemovedListener) {
    _onSourceRemovedListeners.add(onSourceRemovedListener);
  }

  /// Method to add onRenderFrameFinished listener
  @override
  void setOnRenderFrameStartedListener(
      OnRenderFrameStartedListener onRenderFrameStartedListener) {
    _onRenderFrameStartedListeners.add(onRenderFrameStartedListener);
  }

  /// Method to add onRenderFrameFinished listener
  @override
  void setOnRenderFrameFinishedListener(
      OnRenderFrameFinishedListener onRenderFrameFinishedListener) {
    _onRenderFrameFinishedListeners.add(onRenderFrameFinishedListener);
  }

  /// Method to add listeners
  /// [onMapIdleListener] - Listener for onMapIdle
  /// [onCameraChangeListener] - Listener for onCameraChange
  /// [onSourceAddedListener] - Listener for onSourceAdded
  /// [onSourceDataLoadedListener] - Listener for onSourceDataLoaded
  /// [onSourceRemovedListener] - Listener for onSourceRemoved
  @override
  void addListeners({
    OnMapIdleListener? onMapIdleListener,
    OnCameraChangeListener? onCameraChangeListener,
    OnSourceAddedListener? onSourceAddedListener,
    OnSourceDataLoadedListener? onSourceDataLoadedListener,
    OnSourceRemovedListener? onSourceRemovedListener,
    OnRenderFrameStartedListener? onRenderFrameStartedListener,
    OnRenderFrameFinishedListener? onRenderFrameFinishedListener,
  }) {
    if (onMapIdleListener != null) {
      _onMapIdleListeners.add(onMapIdleListener);
    }

    if (onCameraChangeListener != null) {
      _onCameraChangeListeners.add(onCameraChangeListener);
    }

    if (onSourceAddedListener != null) {
      _onSourceAddedListeners.add(onSourceAddedListener);
    }

    if (onSourceDataLoadedListener != null) {
      _onSourceDataLoadedListeners.add(onSourceDataLoadedListener);
    }

    if (onSourceRemovedListener != null) {
      _onSourceRemovedListeners.add(onSourceRemovedListener);
    }

    if (onRenderFrameStartedListener != null) {
      _onRenderFrameStartedListeners.add(onRenderFrameStartedListener);
    }

    if (onRenderFrameFinishedListener != null) {
      _onRenderFrameFinishedListeners.add(onRenderFrameFinishedListener);
    }
  }

  /// Method to remove all listeners
  @override
  void removeListeners() {
    _onMapIdleListeners.clear();
    _onCameraChangeListeners.clear();
    _onSourceAddedListeners.clear();
    _onSourceDataLoadedListeners.clear();
    _onSourceRemovedListeners.clear();
    _onRenderFrameStartedListeners.clear();
    _onRenderFrameFinishedListeners.clear();
  }

  /// Private method to handle OnMapIdleListener
  void _handlingOnMapIdleListener(dynamic args) {
    for (var element in _onMapIdleListeners) {
      element.call();
    }
  }

  /// Private method to handle OnCameraChangeListener
  void _handlingOnCameraChangeListener(dynamic args) {
    for (var element in _onCameraChangeListeners) {
      element.call();
    }
  }

  /// Private method to handle OnSourceAddedListener
  void _handlingOnSourceAddedListener(dynamic args) {
    for (var element in _onSourceAddedListeners) {
      element.call(args);
    }
  }

  /// Private method to handle OnSourceDataLoadedListener
  void _handlingOnSourceDataLoadedListener(dynamic args) {
    for (var element in _onSourceDataLoadedListeners) {
      element.call(args);
    }
  }

  /// Private method to handle OnSourceRemovedListener
  void _handlingOnSourceRemovedListener(dynamic args) {
    for (var element in _onSourceRemovedListeners) {
      element.call(args);
    }
  }

  /// Private method to handle OnRenderFrameStartedListener
  void _handlingOnRenderFrameStartedListener(dynamic args) {
    for (var element in _onRenderFrameStartedListeners) {
      element.call();
    }
  }

  /// Private method to handle OnRenderFrameFinishedListener
  void _handlingOnRenderFrameFinishedListener(dynamic args) {
    for (var element in _onRenderFrameFinishedListeners) {
      element.call();
    }
  }

  /// Method to dispose the controller
  @override
  void dispose() {
    removeListeners();
  }
}
