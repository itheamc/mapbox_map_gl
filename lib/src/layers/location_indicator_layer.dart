import 'layer.dart';
import 'layer_properties.dart';

/// LocationIndicatorLayer class
/// Created by Amit Chaudhary, 2022/10/4
class LocationIndicatorLayer extends Layer<LocationIndicatorLayerProperties> {
  /// Constructor for LocationIndicatorLayer
  LocationIndicatorLayer({
    required super.layerId,
    super.sourceId = "",
    super.layerProperties,
  });

  /// Method to convert the LocationIndicatorLayer Object to the
  /// Map data to pass to the native platform through args
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "layerId": layerId,
      "layerProperties": (layerProperties ??
              LocationIndicatorLayerProperties.defaultProperties)
          .toMap(),
    };
  }
}

/// LocationIndicatorLayerProperties class
/// It contains all the properties for the location indicator layer
/// e.g.
/// final locationIndicatorLayerProperties = LocationIndicatorLayerProperties(
///                             rasterBrightnessMax: 0.88,
///                         );
class LocationIndicatorLayerProperties extends LayerProperties {
  /// Whether this layer is displayed.
  /// Accepted data type - bool
  /// default value is true
  final dynamic visibility;

  /// The minimum zoom level for the layer. At zoom levels less than
  /// the min-zoom, the layer will be hidden.
  /// Accepted data type - double
  /// Range:
  ///       minimum: 0
  ///       maximum: 24
  ///
  final dynamic minZoom;

  /// The maximum zoom level for the layer. At zoom levels equal to or
  /// greater than the max-zoom, the layer will be hidden.
  /// Accepted data type - double
  /// Range:
  ///       minimum: 0
  ///       maximum: 24
  ///
  final dynamic maxZoom;

  /// Constructor
  LocationIndicatorLayerProperties({
    this.visibility,
    this.minZoom,
    this.maxZoom,
  });

  /// Default LocationIndicatorLayerProperties
  static LocationIndicatorLayerProperties get defaultProperties {
    return LocationIndicatorLayerProperties();
  }

  /// Method to proceeds the location indicator layer properties for native
  @override
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    // if (rasterBrightnessMax != null) {
    //   args['rasterBrightnessMax'] = rasterBrightnessMax is List
    //       ? jsonEncode(rasterBrightnessMax)
    //       : rasterBrightnessMax;
    // }
    //
    // if (rasterBrightnessMaxTransition != null) {
    //   args['rasterBrightnessMaxTransition'] =
    //       rasterBrightnessMaxTransition?.toMap();
    // }

    // if (rasterResampling != null) {
    //   args['rasterResampling'] = rasterResampling is RasterResampling
    //       ? (rasterResampling as RasterResampling).name
    //       : rasterResampling is List
    //       ? jsonEncode(rasterResampling)
    //       : rasterResampling;
    // }

    if (maxZoom != null) {
      args['maxZoom'] = maxZoom;
    }

    if (minZoom != null) {
      args['minZoom'] = minZoom;
    }

    if (visibility != null) {
      args['visibility'] = visibility;
    }
    return args.isNotEmpty ? args : null;
  }
}
