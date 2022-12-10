/// A class to contains all the methods that are responsible for communicating
/// with native platform
class Methods {
  /// Methods triggered from the native side
  static const onMapLoaded = "onMapLoaded";
  static const onStyleLoaded = "onStyleLoaded";
  static const onMapLoadError = "onMapLoadError";
  static const onMapClick = "onMapClick";
  static const onMapLongClick = "onMapLongClick";

  static const onFeatureClick = "onFeatureClick";
  static const onFeatureLongClick = "onFeatureLongClick";

  static const onMapIdle = "onMapIdle";
  static const onCameraChange = "onCameraChange";
  static const onSourceAdded = "onSourceAdded";
  static const onSourceDataLoaded = "onSourceDataLoaded";
  static const onSourceRemoved = "onSourceRemoved";
  static const onRenderFrameStarted = "onRenderFrameStarted";
  static const onRenderFrameFinished = "onRenderFrameFinished";

  static const onCircleAnnotationClick = "onCircleAnnotationClick";
  static const onPointAnnotationClick = "onPointAnnotationClick";
  static const onPolylineAnnotationClick = "onPolylineAnnotationClick";
  static const onPolygonAnnotationClick = "onPolygonAnnotationClick";
  static const onCircleAnnotationLongClick = "onCircleAnnotationLongClick";
  static const onPointAnnotationLongClick = "onPointAnnotationLongClick";
  static const onPolylineAnnotationLongClick = "onPolylineAnnotationLongClick";
  static const onPolygonAnnotationLongClick = "onPolygonAnnotationLongClick";

  /// Methods triggered from the flutter side
  static const animateCameraPosition = "animateCameraPosition";
  static const toggleStyle = "toggleStyle";
  static const isSourceExist = "isSourceExist";
  static const isLayerExist = "isLayerExist";
  static const isStyleImageExist = "isStyleImageExist";
  static const isStyleModelExist = "isStyleModelExist";

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
  static const addStyleModel = "addStyleModel";

  static const removeLayer = "removeLayer";
  static const removeLayers = "removeLayers";
  static const removeSource = "removeSource";
  static const addStyleImage = "addStyleImage";
  static const removeStyleImage = "removeStyleImage";
  static const removeStyleModel = "removeStyleModel";

  static const setStyleLayerProperty = "setStyleLayerProperty";
  static const setStyleLayerProperties = "setStyleLayerProperties";
  static const setStyleSourceProperty = "setStyleSourceProperty";
  static const setStyleSourceProperties = "setStyleSourceProperties";
  static const moveStyleLayerAbove = "moveStyleLayerAbove";
  static const moveStyleLayerBelow = "moveStyleLayerBelow";
  static const moveStyleLayerAt = "moveStyleLayerAt";

  static const getGeoJsonClusterChildren = "getGeoJsonClusterChildren";
  static const getGeoJsonClusterLeaves = "getGeoJsonClusterLeaves";
  static const getFeatureState = "getFeatureState";
  static const setFeatureState = "setFeatureState";
  static const removeFeatureState = "removeFeatureState";
  static const querySourceFeatures = "querySourceFeatures";
  static const queryRenderedFeatures = "queryRenderedFeatures";

  static const loadStyleJson = "loadStyleJson";
  static const reduceMemoryUse = "reduceMemoryUse";
  static const setMapMemoryBudget = "setMapMemoryBudget";
  static const triggerRepaint = "triggerRepaint";
  static const coordinateForPixel = "coordinateForPixel";
  static const coordinatesForPixels = "coordinatesForPixels";
  static const pixelForCoordinate = "pixelForCoordinate";
  static const pixelsForCoordinates = "pixelsForCoordinates";
  static const getMapSize = "getMapSize";
  static const setViewportMode = "setViewportMode";
  static const setCamera = "setCamera";
  static const loadStyleUri = "loadStyleUri";

  static const createCircleAnnotation = "createCircleAnnotation";
  static const createPointAnnotation = "createPointAnnotation";
  static const createPolygonAnnotation = "createPolygonAnnotation";
  static const createPolylineAnnotation = "createPolylineAnnotation";
  static const removeCircleAnnotation = "removeCircleAnnotation";
  static const removePointAnnotation = "removePointAnnotation";
  static const removePolygonAnnotation = "removePolygonAnnotation";
  static const removePolylineAnnotation = "removePolylineAnnotation";
  static const removeAllAnnotations = "removeAllAnnotations";
}
