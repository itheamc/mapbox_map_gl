import 'mapbox_map.dart';
import 'style_images/style_image.dart';

import 'layers/layer.dart';
import 'sources/source.dart';
import 'helper/camera_position.dart';

abstract class MapboxMapController {
  /// Method to toggle the map style between two styles
  /// [style1] - the first style (MapStyle)
  /// [style2] - the second style (MapStyle)
  Future<void> toggleBetween(MapStyle style1, MapStyle style2);

  /// Method to toggle the map style among given styles
  /// [styles] - the list of styles (List<MapStyle>)
  Future<void> toggleAmong(List<MapStyle> styles);

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
}
