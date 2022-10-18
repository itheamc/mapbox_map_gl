import 'utils/listeners.dart';
import 'utils/queried_feature.dart';
import 'utils/rendered_query_options.dart';
import 'utils/rendered_query_qeometry.dart';
import 'utils/source_query_options.dart';

import 'mapbox_map.dart';
import 'style_images/style_image.dart';

import 'layers/layer.dart';
import 'sources/source.dart';
import 'utils/camera_position.dart';

/// Type definition for style toggled callback
typedef OnStyleToggled = void Function(MapStyle style);

abstract class MapboxMapController with Listeners {
  /// Method to toggle the map style between two styles
  /// [style1] - the first style (MapStyle)
  /// [style2] - the second style (MapStyle)
  /// [onStyleToggled] - callback for style toggled
  Future<void> toggleBetween(
    MapStyle style1,
    MapStyle style2, {
    OnStyleToggled? onStyleToggled,
  });

  /// Method to toggle the map style among given styles
  /// [styles] - the list of styles (List<MapStyle>)
  /// [onStyleToggled] - callback for style toggled
  Future<void> toggleAmong(
    List<MapStyle> styles, {
    OnStyleToggled? onStyleToggled,
  });

  /// Method to animate camera position
  /// [cameraPosition] New camera position to move camera
  /// e.g.
  /// final cameraPosition = CameraPosition(
  ///   center: LatLng(27.34, 85.73),
  ///   zoom: 14.0,
  ///   animationOptions: AnimationOptions.mapAnimationOptions(
  ///     startDelay: 300,
  ///     duration: const Duration(milliseconds: 1000),
  ///   ),
  /// );
  Future<void> animateCameraPosition(CameraPosition cameraPosition);

  /// Method to check if source is already existed
  Future<bool> isSourceExist(String sourceId);

  /// Method to check if layer is already existed
  Future<bool> isLayerExist(String layerId);

  /// Method to check if style image is already existed
  Future<bool> isStyleImageExist(String imageId);

  /// Method to check if style model is already existed
  Future<bool> isStyleModelExist(String modelId);

  /// Generic method to add style source
  /// You can add:
  /// - GeoJsonSource
  /// - VectorSource
  /// - RasterSource
  /// - RasterDemSource
  /// - ImageSource and
  /// - VideoSource
  Future<void> addSource<T extends Source>({required T source});

  /// Generic method to add style layer
  /// You can add:
  /// - CircleLayer
  /// - FillLayer
  /// - LineLayer
  /// - RasterLayer and
  /// - SymbolLayer
  Future<void> addLayer<T extends Layer>({required T layer});

  /// Method to remove added source
  /// [sourceId] - An id of the source that you want to remove
  Future<bool> removeSource(String sourceId);

  /// Method to remove added style layer
  /// [layerId] - An id of style layer that you want to remove
  Future<bool> removeLayer(String layerId);

  /// Method to remove list of added sources
  /// [sourcesId] - List of sources id that you want to remove
  Future<bool> removeSources(List<String> sourcesId);

  /// Method to remove list of added style layers
  /// [layersId] - List of layers id that you want to remove
  Future<bool> removeLayers(List<String> layersId);

  /// Method to add style image from assets
  /// [image] - Image
  /// i.e. - NetworkStyleImage or LocalStyleImage
  Future<bool> addStyleImage<T extends StyleImage>({required T image});

  /// Method to remove style image
  /// [imageId] - An id of style image that you want to remove
  Future<bool> removeStyleImage(String imageId);

  /// Method to add style model to be used in the style.
  /// This API can also be used for updating a model as well.
  /// If the model for a given modelId was already added, it gets replaced by
  /// the new model. The model can be used in model-id property in model layer.
  /// Params:
  /// modelId - An identifier of the model.
  /// modelUri - A URI for the model.
  Future<bool> addStyleModel(String modelId, String modelUri);

  /// Method to remove added style model
  /// [modelId] - An id of style model that you want to remove
  Future<bool> removeStyleModel(String modelId);

  /// Method to set style source property for given id
  /// [sourceId] - An id of the style source
  /// [property] - Name of the property
  /// [value] - Value for that property
  Future<bool> setStyleSourceProperty({
    required String sourceId,
    required String property,
    required dynamic value,
  });

  /// Method to set style source properties for given id
  /// [sourceId] - An id of the style source
  /// [properties] - properties with key and value
  Future<bool> setStyleSourceProperties({
    required String sourceId,
    required Map<String, dynamic> properties,
  });

  /// Method to set style layer property for given id
  /// [layerId] - An id of the style layer
  /// [property] - Name of the property
  /// [value] - Value for that property
  Future<bool> setStyleLayerProperty({
    required String layerId,
    required String property,
    required dynamic value,
  });

  /// Method to set style layer properties for given id
  /// [layerId] - An id of the style layer
  /// [properties] - properties with key and value
  Future<bool> setStyleLayerProperties({
    required String layerId,
    required Map<String, dynamic> properties,
  });

  /// Method to move style layer above of given layer
  /// [layerId] - An id of the style layer to move above
  /// [belowLayerId] - id of style layer which above the given layer
  /// will be move
  Future<bool> moveStyleLayerAbove({
    required String layerId,
    required String belowLayerId,
  });

  /// Method to move style layer below of given layer
  /// [layerId] - An id of the style layer to move below
  /// [aboveLayerId] - id of style layer which below the given layer
  /// will be move
  Future<bool> moveStyleLayerBelow({
    required String layerId,
    required String aboveLayerId,
  });

  /// Method to move style layer at given position
  /// [layerId] - An id of the style layer to move at given position
  /// [at] - position to move layer
  Future<bool> moveStyleLayerAt({
    required String layerId,
    required int at,
  });

  /// Queries the map for source features.
  /// Params:
  /// [sourceId] - Style source identifier used to query for source features.
  /// [queryOptions] - Options for querying source features.
  /// Returns:
  /// An array of queried features.
  Future<List<QueriedFeature>?> querySourceFeatures({
    required String sourceId,
    required SourceQueryOptions queryOptions,
  });

  /// Queries the map for rendered features.
  /// Params:
  /// [geometry] - The screen pixel coordinates (point, line string or box)
  /// to query for rendered features.
  /// [queryOptions] - The render query options for querying rendered features.
  /// Returns:
  /// An array of queried features.
  Future<List<QueriedFeature>?> queryRenderedFeatures({
    required RenderedQueryGeometry geometry,
    required RenderedQueryOptions queryOptions,
  });

  /// Method to handle callbacks
  void callbacks(Map<String, dynamic> params);

  /// Method to dispose controller
  void dispose();
}
