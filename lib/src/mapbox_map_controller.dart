import 'package:mapbox_map_gl/src/layers/circle_layer.dart';
import 'package:mapbox_map_gl/src/layers/fill_layer.dart';
import 'package:mapbox_map_gl/src/layers/line_layer.dart';
import 'package:mapbox_map_gl/src/layers/symbol_layer.dart';
import 'package:mapbox_map_gl/src/utils/camera_position.dart';

abstract class MapboxMapController {
  /// Method to toggle the map mode
  /// Satellite to Street
  /// and Street to Satellite
  Future<void> toggleMode({bool dark = false});

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
  Future<bool> isLayerExist(String layerId, LayerType layerType);

  /// Method to add geo json source
  Future<void> addGeoJsonSource({
    required String sourceId,
    required String layerId,
    CircleLayer? circleLayer,
    LineLayer? lineLayer,
    SymbolLayer? symbolLayer,
    FillLayer? fillLayer,
  });
}

enum LayerType { fill, line, circle, symbol, vector, raster }
