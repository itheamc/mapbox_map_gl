import 'dart:convert';
import '../utils/style_transition.dart';
import 'layer.dart';
import 'layer_properties.dart';

/// HeatmapLayer class
/// Created by Amit Chaudhary, 2022/10/8
class HeatmapLayer extends Layer<HeatmapLayerProperties> {
  /// Constructor for HeatmapLayer
  HeatmapLayer({
    required super.layerId,
    required super.sourceId,
    super.layerProperties,
  });

  /// Method to convert the HeatmapLayer Object to the
  /// Map data to pass to the native platform through args
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "layerId": layerId,
      "sourceId": sourceId,
      "layerProperties":
          (layerProperties ?? HeatmapLayerProperties.defaultProperties).toMap(),
    };
  }
}

/// HeatmapLayerProperties class
/// It contains all the properties for the heatmap layer
/// e.g.
/// final heatmapLayerProperties = HeatmapLayerProperties(
///                             heatmapIntensity: 1.0,
///                         );
class HeatmapLayerProperties extends LayerProperties {
  /// Defines the color of each pixel based on its density value in a heatmap.
  /// Should be an expression that uses `["heatmap-density"]` as input.
  /// Accepted data type:
  /// - Expression
  final dynamic heatmapColor;

  /// Similar to `heatmap-weight` but controls the intensity of the heatmap
  /// globally. Primarily used for adjusting the heatmap based on zoom level.
  /// Accepted data type:
  /// - double and
  /// - Expression
  /// default value is 1.0
  final dynamic heatmapIntensity;

  /// Transition for similar to `heatmap-weight` but controls the intensity of the heatmap
  /// globally. Primarily used for adjusting the heatmap based on zoom level.
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? heatmapIntensityTransition;

  /// The global opacity at which the heatmap layer will be drawn.
  /// Accepted data type:
  /// - double and
  /// - Expression
  /// default value is 1.0
  final dynamic heatmapOpacity;

  /// Transition for the global opacity at which the heatmap layer will be drawn.
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? heatmapOpacityTransition;

  /// Radius of influence of one heatmap point in pixels.
  /// Increasing the value makes the heatmap smoother, but less detailed.
  /// `queryRenderedFeatures` on heatmap layers will return points within
  /// this radius.
  /// Accepted data type:
  /// - double and
  /// - Expression
  /// default value is 30.0
  final dynamic heatmapRadius;

  /// Transition for radius of influence of one heatmap point in pixels.
  /// Increasing the value makes the heatmap smoother, but less detailed.
  /// `queryRenderedFeatures` on heatmap layers will return points within
  /// this radius.
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? heatmapRadiusTransition;

  /// A measure of how much an individual point contributes to the heatmap.
  /// A value of 10 would be equivalent to having 10 points of weight 1 in
  /// the same spot. Especially useful when combined with clustering.
  /// Accepted data type:
  /// - double and
  /// - Expression
  /// default value is 1.0
  final dynamic heatmapWeight;

  /// A filter is a property at the layer level that determines which features
  /// should be rendered in a style layer.
  /// Filters are written as expressions, which give you fine-grained control
  /// over which features to include: the style layer only displays the
  /// features that match the filter condition that you define.
  /// Note: Zoom expressions in filters are only evaluated at integer zoom
  /// levels. The feature-state expression is not supported in filter
  /// expressions.
  /// Accepted data type - Expression
  final dynamic filter;

  /// A source layer is an individual layer of data within a vector source.
  /// Accepted data type - String
  final dynamic sourceLayer;

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
  HeatmapLayerProperties({
    this.heatmapColor,
    this.heatmapIntensity,
    this.heatmapIntensityTransition,
    this.heatmapOpacity,
    this.heatmapOpacityTransition,
    this.heatmapRadius,
    this.heatmapRadiusTransition,
    this.heatmapWeight,
    this.filter,
    this.sourceLayer,
    this.visibility,
    this.minZoom,
    this.maxZoom,
  });

  /// Default HeatmapLayerProperties
  static HeatmapLayerProperties get defaultProperties {
    return HeatmapLayerProperties(
      heatmapIntensity: 1.0,
      heatmapIntensityTransition: StyleTransition.build(
        delay: 275,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  /// Method to proceeds the heatmap layer properties for native
  @override
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    if (heatmapColor != null && heatmapColor is List) {
      args['heatmapColor'] = heatmapColor;
    }

    if (heatmapIntensity != null) {
      args['heatmapIntensity'] = heatmapIntensity is List
          ? jsonEncode(heatmapIntensity)
          : heatmapIntensity;
    }

    if (heatmapIntensityTransition != null) {
      args['heatmapIntensityTransition'] = heatmapIntensityTransition?.toMap();
    }

    if (heatmapOpacity != null) {
      args['heatmapOpacity'] =
          heatmapOpacity is List ? jsonEncode(heatmapOpacity) : heatmapOpacity;
    }

    if (heatmapOpacityTransition != null) {
      args['heatmapOpacityTransition'] = heatmapOpacityTransition?.toMap();
    }

    if (heatmapRadius != null) {
      args['heatmapRadius'] =
          heatmapRadius is List ? jsonEncode(heatmapRadius) : heatmapRadius;
    }

    if (heatmapRadiusTransition != null) {
      args['heatmapRadiusTransition'] = heatmapRadiusTransition?.toMap();
    }

    if (heatmapWeight != null) {
      args['heatmapWeight'] =
          heatmapWeight is List ? jsonEncode(heatmapWeight) : heatmapWeight;
    }

    if (sourceLayer != null) {
      args['sourceLayer'] = sourceLayer;
    }

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
