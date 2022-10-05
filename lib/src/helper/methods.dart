
/// A class to contains all the methods that are responsible for communicating
/// with native platform
class Methods {
  /// Methods triggered from the native side
  static const onMapCreated = "onMapCreated";
  static const onStyleLoaded = "onStyleLoaded";
  static const onMapLoadError = "onMapLoadError";
  static const onMapClick = "onMapClick";
  static const onMapLongClick = "onMapLongClick";

  static const onFeatureClick = "onFeatureClick";
  static const onFeatureLongClick = "onFeatureLongClick";

  /// Methods triggered from the flutter side
  static const isSourceExist = "isSourceExist";
  static const isLayerExist = "isLayerExist";
  static const toggleMode = "toggleMode";
  static const animateCameraPosition = "animateCameraPosition";
}
