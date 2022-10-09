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
  static const animateCameraPosition = "animateCameraPosition";
  static const toggleStyle = "toggleStyle";
  static const isSourceExist = "isSourceExist";
  static const isLayerExist = "isLayerExist";
  static const addGeoJsonSource = "addGeoJsonSource";
  static const addVectorSource = "addVectorSource";
  static const addRasterSource = "addRasterSource";
  static const addRasterDemSource = "addRasterDemSource";
  static const addImageSource = "addImageSource";
  static const addVideoSource = "addVideoSource";
  static const addCircleLayer = "addCircleLayer";
  static const addFillLayer = "addFillLayer";
  static const addLineLayer = "addLineLayer";
  static const addSymbolLayer = "addSymbolLayer";
  static const addRasterLayer = "addRasterLayer";
  static const addSkyLayer = "addSkyLayer";
  static const addLocationIndicatorLayer = "addLocationIndicatorLayer";
  static const addFillExtrusionLayer = "addFillExtrusionLayer";
  static const addHeatmapLayer = "addHeatmapLayer";
  static const addHillShadeLayer = "addHillShadeLayer";
  static const addBackgroundLayer = "addBackgroundLayer";
  static const removeLayer = "removeLayer";
  static const removeLayers = "removeLayers";
  static const removeSource = "removeSource";
  static const removeSources = "removeSources";
}
