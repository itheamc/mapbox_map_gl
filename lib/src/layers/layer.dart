/// Abstract Layer class
/// Created by Amit Chaudhary, 2022/10/7
abstract class Layer<T> {
  /// [layerId] - An unique identifier for the style layer
  final String layerId;

  /// LayerProperties
  /// default value is <T>LayerProperties.defaultProperties
  final T? layerProperties;

  /// Constructor
  Layer({
    required this.layerId,
    this.layerProperties,
  });

  /// Method to convert Layer object to Map
  Map<String, dynamic> toMap();
}
