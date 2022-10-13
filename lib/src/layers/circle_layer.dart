import 'dart:convert';
import 'layer.dart';
import 'layer_properties.dart';

import '../utils/style_transition.dart';

/// CircleLayer class
/// Created by Amit Chaudhary, 2022/10/3
class CircleLayer extends Layer<CircleLayerProperties> {
  /// Constructor for CircleLayer
  CircleLayer({
    required super.layerId,
    required super.sourceId,
    super.layerProperties,
  });

  /// Method to convert the CircleLayer Object to the
  /// Map data to pass to the native platform through args
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "layerId": layerId,
      "sourceId": sourceId,
      "layerProperties":
          (layerProperties ?? CircleLayerProperties.defaultProperties).toMap(),
    };
  }
}

/// CircleLayerProperties class
/// It contains all the properties for the circle layer
/// e.g.
/// final circleLayerProperties = CircleLayerProperties(
///                             circleColor: 'green',
///                             circleRadius: 10.0,
///                             circleStrokeWidth: 2.0,
///                             circleStrokeColor: "#fff",
///                             circleColor: 'green',
///                         );
class CircleLayerProperties extends LayerProperties {
  /// The fill color of the circle.
  /// Accepted data type:
  /// - String,
  /// - Int and
  /// - Expression
  /// default value is '#0000'
  final dynamic circleColor;

  /// StyleTransition for circleColor
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? circleColorTransition;

  /// Circle radius.
  /// Accepted data type:
  /// - Double and
  /// - Expression
  /// default value is 5.0
  final dynamic circleRadius;

  /// StyleTransition for circleRadius
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? circleRadiusTransition;

  /// Amount to blur the circle. 1 blurs the circle such that only the
  /// center point is full opacity.
  /// Accepted data type:
  /// - Double and
  /// - Expression
  /// default value is 0.0
  final dynamic circleBlur;

  /// StyleTransition for circleBlur
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? circleBlurTransition;

  /// The opacity at which the circle will be drawn.
  /// Accepted data type:
  /// - Double and
  /// - Expression
  /// default value is 1.0
  final dynamic circleOpacity;

  /// StyleTransition for circleOpacity
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? circleOpacityTransition;

  /// The stroke color of the circle.
  /// Accepted data type:
  /// - String
  /// - Int and
  /// - Expression
  /// default value is '#000'
  final dynamic circleStrokeColor;

  /// StyleTransition for circleStrokeColor
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? circleStrokeColorTransition;

  /// The width of the circle's stroke. Strokes are placed outside
  /// of the circle-radius.
  /// Accepted data type:
  /// - Double and
  /// - Expression
  /// default value is 0.0
  final dynamic circleStrokeWidth;

  /// StyleTransition for circleStrokeWidth
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? circleStrokeWidthTransition;

  /// The opacity of the circle's stroke
  /// Accepted data type:
  /// - Double and
  /// - Expression
  /// default value is 1.0
  final dynamic circleStrokeOpacity;

  /// StyleTransition for circleStrokeOpacity
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? circleStrokeOpacityTransition;

  /// Controls the scaling behavior of the circle when the map is pitched
  /// Accepted data type:
  /// - CirclePitchScale and
  /// - Expression
  /// default value is CirclePitchScale.map
  final dynamic circlePitchScale;

  /// Orientation of circle when map is pitched.
  /// Accepted data type:
  /// - CirclePitchAlignment and
  /// - Expression
  /// default value is CirclePitchAlignment.viewport
  final dynamic circlePitchAlignment;

  /// Sorts features in ascending order based on this value.
  /// Features with a higher sort key will appear above features
  /// with a lower sort key.
  /// Accepted data type:
  /// - Double and
  /// - Expression
  final dynamic circleSortKey;

  /// The geometry's offset. Values are x, y where negatives indicate
  /// left and up, respectively.
  /// Accepted data type:
  /// - List<Double> and
  /// - Expression
  final dynamic circleTranslate;

  /// StyleTransition for circleTranslate
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? circleTranslateTransition;

  /// Controls the frame of reference for circle-translate
  /// Accepted data type:
  /// - CircleTranslateAnchor and
  /// - Expression
  /// default value is CircleTranslateAnchor.map
  final dynamic circleTranslateAnchor;

  /// A source layer is an individual layer of data within a vector source.
  /// A vector source can have multiple source layers.
  /// Accepted data type:
  /// - String
  final String? sourceLayer;

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
  CircleLayerProperties({
    this.circleColor,
    this.circleColorTransition,
    this.circleRadius,
    this.circleRadiusTransition,
    this.circleBlur,
    this.circleBlurTransition,
    this.circleOpacity,
    this.circleOpacityTransition,
    this.circleStrokeColor,
    this.circleStrokeColorTransition,
    this.circleStrokeWidth,
    this.circleStrokeWidthTransition,
    this.circleStrokeOpacity,
    this.circleStrokeOpacityTransition,
    this.circlePitchScale,
    this.circlePitchAlignment,
    this.circleSortKey,
    this.circleTranslate,
    this.circleTranslateTransition,
    this.circleTranslateAnchor,
    this.sourceLayer,
    this.filter,
    this.maxZoom,
    this.minZoom,
    this.visibility,
  });

  /// Default Circle layer properties
  static CircleLayerProperties get defaultProperties {
    return CircleLayerProperties(
      circleColor: 'blue',
      circleColorTransition: StyleTransition.build(
        delay: 300,
        duration: const Duration(milliseconds: 500),
      ),
      circleRadius: 10.0,
      circleStrokeWidth: 2.0,
      circleStrokeColor: "#fff",
    );
  }

  /// Method to proceeds the circle layer properties for native
  @override
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    if (circleColor != null) {
      args['circleColor'] =
          circleColor is List ? jsonEncode(circleColor) : circleColor;
    }

    if (circleColorTransition != null) {
      args['circleColorTransition'] = circleColorTransition?.toMap();
    }

    if (circleRadius != null) {
      args['circleRadius'] =
          circleRadius is List ? jsonEncode(circleRadius) : circleRadius;
    }

    if (circleRadiusTransition != null) {
      args['circleRadiusTransition'] = circleRadiusTransition?.toMap();
    }

    if (circleBlur != null) {
      args['circleBlur'] =
          circleBlur is List ? jsonEncode(circleBlur) : circleBlur;
    }

    if (circleBlurTransition != null) {
      args['circleBlurTransition'] = circleBlurTransition?.toMap();
    }

    if (circleOpacity != null) {
      args['circleOpacity'] =
          circleOpacity is List ? jsonEncode(circleOpacity) : circleOpacity;
    }

    if (circleOpacityTransition != null) {
      args['circleOpacityTransition'] = circleOpacityTransition?.toMap();
    }

    if (circleStrokeColor != null) {
      args['circleStrokeColor'] = circleStrokeColor is List
          ? jsonEncode(circleStrokeColor)
          : circleStrokeColor;
    }

    if (circleStrokeColorTransition != null) {
      args['circleStrokeColorTransition'] =
          circleStrokeColorTransition?.toMap();
    }

    if (circleStrokeWidth != null) {
      args['circleStrokeWidth'] = circleStrokeWidth is List
          ? jsonEncode(circleStrokeWidth)
          : circleStrokeWidth;
    }

    if (circleStrokeWidthTransition != null) {
      args['circleStrokeWidthTransition'] =
          circleStrokeWidthTransition?.toMap();
    }

    if (circleStrokeOpacity != null) {
      args['circleStrokeOpacity'] = circleStrokeOpacity is List
          ? jsonEncode(circleStrokeOpacity)
          : circleStrokeOpacity;
    }

    if (circleStrokeOpacityTransition != null) {
      args['circleStrokeOpacityTransition'] =
          circleStrokeOpacityTransition?.toMap();
    }

    if (circlePitchScale != null &&
        (circlePitchScale is CirclePitchScale || circlePitchScale is List)) {
      args['circlePitchScale'] = circlePitchScale is CirclePitchScale
          ? (circlePitchScale as CirclePitchScale).name
          : circlePitchScale is List
              ? jsonEncode(circlePitchScale)
              : circlePitchScale;
    }

    if (circlePitchAlignment != null &&
        (circlePitchAlignment is CirclePitchAlignment ||
            circlePitchAlignment is List)) {
      args['circlePitchAlignment'] =
          circlePitchAlignment is CirclePitchAlignment
              ? (circlePitchAlignment as CirclePitchAlignment).name
              : circlePitchAlignment is List
                  ? jsonEncode(circlePitchAlignment)
                  : circlePitchAlignment;
    }

    if (circleSortKey != null) {
      args['circleSortKey'] =
          circleSortKey is List ? jsonEncode(circleSortKey) : circleSortKey;
    }

    if (circleTranslate != null && circleTranslate is List) {
      args['circleTranslate'] = circleTranslate is List<double> ||
              circleTranslate is List<int> ||
              circleTranslate is List<num>
          ? circleTranslate
          : jsonEncode(circleTranslate);
    }

    if (circleTranslateTransition != null) {
      args['circleTranslateTransition.'] = circleTranslateTransition?.toMap();
    }

    if (circleTranslateAnchor != null &&
        (circleTranslateAnchor is CircleTranslateAnchor ||
            circleTranslateAnchor is List)) {
      args['circleTranslateAnchor'] =
          circleTranslateAnchor is CircleTranslateAnchor
              ? (circleTranslateAnchor as CircleTranslateAnchor).name
              : circleTranslateAnchor is List
                  ? jsonEncode(circleTranslateAnchor)
                  : circleTranslateAnchor;
    }

    if (sourceLayer != null) {
      args['sourceLayer'] = sourceLayer;
    }

    if (filter != null && filter is List) {
      args['filter'] = jsonEncode(filter);
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

/// CircleTranslateAnchor
/// MAP and VIEWPORT
enum CircleTranslateAnchor { map, viewport }

/// CirclePitchScale
/// MAP and VIEWPORT
enum CirclePitchScale { map, viewport }

/// CirclePitchScale
/// MAP and VIEWPORT
enum CirclePitchAlignment { map, viewport }
