import 'dart:ui';
import 'utils/enums.dart';
import 'utils/listeners.dart';
import 'utils/queried_feature.dart';
import 'utils/rendered_query_geometry.dart';
import 'utils/rendered_query_options.dart';
import 'utils/source_query_options.dart';
import 'utils/point.dart';
import 'utils/screen_coordinate.dart';

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
  Future<void> setFeatureState({
    required String sourceId,
    required String featureId,
    String? sourceLayerId,
    required Map<String, dynamic> state,
  });

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
  Future<void> removeFeatureState({
    required String sourceId,
    required String featureId,
    String? sourceLayerId,
    required String? stateKey,
  });

  /// Get the state map of a feature within a style source.
  /// [sourceId] - Style source identifier.
  /// [sourceLayerId] - Style source layer identifier (for multi-layer sources
  /// such as vector sources).
  /// [featureId] - Identifier of the feature whose state should be queried.
  /// It will return feature's state map or an empty map if the feature could
  /// not be found.
  Future<dynamic> getFeatureState({
    required String sourceId,
    required String featureId,
    String? sourceLayerId,
  });

  /// Will load a new map style asynchronous from the specified style json data.
  /// [styleJson] - A style json data
  Future<void> loadStyleJson(String styleJson);

  /// Will load a new map style asynchronous from the specified style style uri.
  /// [styleUri] - A style uri
  Future<void> loadStyleUri(String styleUri);

  /// Reduce memory use. Useful to call when the application
  /// gets paused or sent to background.
  Future<void> reduceMemoryUse();

  /// Triggers a repaint of the map.
  Future<void> triggerRepaint();

  /// Set the map viewport mode
  /// Params:
  /// [viewportMode] - The map viewport mode to set
  Future<void> setViewportMode(ViewportMode viewportMode);

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
  Future<void> setMapMemoryBudget(MapMemoryBudgetIn budgetIn, int value);

  /// Gets the size of the map.
  /// Returns:
  /// [Size] - The size of the map in pixels
  Future<Size?> getMapSize();

  /// Changes the map view by any combination of center, zoom, bearing,
  /// and pitch, without an animated transition. The map will retain its
  /// current values for any details not passed via the camera options argument.
  /// It is not guaranteed that the provided CameraOptions will be set, the
  /// map may apply constraints resulting in a different CameraState.
  /// Note: - animationOptions has no effect on it.
  /// Params:
  /// [cameraPosition] - New camera position
  Future<void> setCamera(CameraPosition cameraPosition);

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
  Future<Point?> coordinateForPixel(ScreenCoordinate pixel);

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
  Future<List<Point>?> coordinatesForPixels(List<ScreenCoordinate> pixels);

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
  Future<ScreenCoordinate?> pixelForCoordinate(Point coordinate);

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
  Future<List<ScreenCoordinate>?> pixelsForCoordinates(List<Point> coordinates);

  /// Method to handle callbacks
  void callbacks(Map<String, dynamic> params);

  /// Method to dispose controller
  void dispose();
}
