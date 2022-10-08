import 'dart:convert';
import 'layer.dart';
import 'layer_properties.dart';

import '../helper/style_transition.dart';

/// LineLayer class
/// Created by Amit Chaudhary, 2022/10/3
class LineLayer extends Layer<LineLayerProperties> {
  /// Constructor for LineLayer
  LineLayer({
    required super.layerId,
    required super.sourceId,
    super.layerProperties,
  });

  /// Method to convert the LineLayer Object to the
  /// Map data to pass to the native platform through args
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "layerId": layerId,
      "sourceId": sourceId,
      "layerProperties":
          (layerProperties ?? LineLayerProperties.defaultProperties).toMap(),
    };
  }
}

/// LineLayerProperties class
/// It contains all the properties for the line layer
/// e.g.
/// final lineLayerProperties = LineLayerProperties(
///                             lineWidth: 2.0,
///                             lineColor: 'red',
///                             lineWidth: 2.0,
///                             lineWidth: 2.0,
///                         );
class LineLayerProperties extends LayerProperties {
  /// Stroke thickness.
  /// Accepted data type:
  /// - Double and
  /// - Expression
  /// default value is 1.0
  final dynamic lineWidth;

  /// StyleTransition for line width
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? lineWidthTransition;

  /// The color with which the line will be drawn.
  /// Accepted data type:
  /// - String,
  /// - int and
  /// - Expression
  /// default value is '#000000'
  final dynamic lineColor;

  /// StyleTransition for line color
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? lineColorTransition;

  /// Blur applied to the line, in pixels.
  /// Accepted data type:
  /// - double and
  /// - Expression
  /// default value is 0.0
  final dynamic lineBlur;

  /// StyleTransition for line blur
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? lineBlurTransition;

  /// Specifies the lengths of the alternating dashes and gaps that form
  /// the dash pattern. The lengths are later scaled by the line width.
  /// To convert a dash length to pixels, multiply the length by the current
  /// line width. Note that GeoJSON sources with lineMetrics: true specified
  /// won't render dashed lines to the expected scale. Also note that
  /// zoom-dependent expressions will be evaluated only at integer zoom levels.
  /// Accepted data type:
  /// - List<Double> and
  /// - Expression
  final dynamic lineDashArray;

  /// StyleTransition for dash array
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? lineDashArrayTransition;

  /// Draws a line casing outside of a line's actual path. Value indicates
  /// the width of the inner gap.
  /// Accepted data type:
  /// - double and
  /// - Expression
  /// default value is 0.0
  final dynamic lineGapWidth;

  /// StyleTransition for line gap width
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? lineGapWidthTransition;

  /// Expression
  /// e.g.
  ///   [
  ///    'interpolate',
  ///    ['linear'],
  ///    ['line-progress'],
  ///     0,
  ///    'blue',
  ///     0.1,
  ///    'green',
  ///     0.3,
  ///    'cyan',
  ///     0.5,
  ///    'lime',
  ///     0.7,
  ///    'yellow',
  ///     1,
  ///    'red'
  ///  ]
  final dynamic lineGradient;

  /// Used to automatically convert miter joins to bevel joins for sharp angles.
  /// Accepted data type:
  /// - double and
  /// - Expression
  /// default value is 2.0
  final dynamic lineMiterLimit;

  /// The line's offset. For linear features, a positive value offsets
  /// the line to the right, relative to the direction of the line, and
  /// a negative value to the left. For polygon features, a positive value
  /// results in an inset, and a negative value results in an outset.
  /// Accepted data type:
  /// - double and
  /// - Expression
  /// default value is 0.0
  final dynamic lineOffset;

  /// StyleTransition for line offset
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? lineOffsetTransition;

  /// The opacity at which the line will be drawn.
  /// Accepted data type:
  /// - double and
  /// - Expression
  /// default value is 1.0
  final dynamic lineOpacity;

  /// StyleTransition for line opacity
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? lineOpacityTransition;

  /// Name of image in sprite to use for drawing image lines.
  /// For seamless patterns, image width must be a factor of two
  /// (2, 4, 8, ..., 512). Note that zoom-dependent expressions will be
  /// evaluated only at integer zoom levels.
  /// Accepted data type:
  /// - String and
  /// - Expression
  final dynamic linePattern;

  /// StyleTransition for linePattern
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? linePatternTransition;

  /// Used to automatically convert round joins to miter joins
  /// for shallow angles.
  /// Accepted data type:
  /// - Double and
  /// - Expression
  /// default value is 1.05
  final dynamic lineRoundLimit;

  /// Sorts features in ascending order based on this value. Features with
  /// a higher sort key will appear above features with a lower sort key.
  /// Accepted data type:
  /// - Double and
  /// - Expression
  final dynamic lineSortKey;

  /// The geometry's offset. Values are x, y where negatives indicate
  /// left and up, respectively
  /// Accepted data type:
  /// - List<Double> and
  /// - Expression
  /// default value is [0.0, 0.0]
  final dynamic lineTranslate;

  /// StyleTransition for lineTranslate
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? lineTranslateTransition;

  /// Controls the frame of reference for line-translate.
  /// Accepted data type:
  /// - LineTranslateAnchor
  /// - Expression
  /// default value is LineTranslateAnchor.map
  final dynamic lineTranslateAnchor;

  /// The line part between trim-start, trim-end will be marked as transparent
  /// to make a route vanishing effect. The line trim-off offset is based
  /// on the whole line range 0.0, 1.0.
  /// Accepted data type:
  /// - List<Double> and
  /// - Expression
  /// default value is [0.0, 0.0]
  final dynamic lineTrimOffset;

  /// The display of line endings.
  /// Accepted data type:
  /// - LineCap and
  /// - Expression
  /// default value is LineCap.butt
  final dynamic lineCap;

  /// The display of lines when joining.
  /// Accepted data type:
  /// - LineJoin and
  /// - Expression
  /// default value is LineJoin.miter
  final dynamic lineJoin;

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
  LineLayerProperties({
    this.lineWidth,
    this.lineWidthTransition,
    this.lineColor,
    this.lineColorTransition,
    this.lineBlur,
    this.lineBlurTransition,
    this.lineDashArray,
    this.lineDashArrayTransition,
    this.lineGapWidth,
    this.lineGapWidthTransition,
    this.lineGradient,
    this.lineMiterLimit,
    this.lineOffset,
    this.lineOffsetTransition,
    this.lineOpacity,
    this.lineOpacityTransition,
    this.linePattern,
    this.linePatternTransition,
    this.lineRoundLimit,
    this.lineSortKey,
    this.lineTranslate,
    this.lineTranslateTransition,
    this.lineTranslateAnchor,
    this.lineTrimOffset,
    this.lineCap,
    this.lineJoin,
    this.sourceLayer,
    this.filter,
    this.maxZoom,
    this.minZoom,
    this.visibility,
  });

  /// Default line layer properties
  static LineLayerProperties get defaultProperties {
    return LineLayerProperties(
      lineWidth: 2.0,
      lineColor: 'blue',
      lineCap: LineCap.round,
      lineJoin: LineJoin.round,
    );
  }

  /// Method to proceeds the line layer properties for native
  @override
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    if (lineWidth != null) {
      args['lineWidth'] = lineWidth is List ? jsonEncode(lineWidth) : lineWidth;
    }

    if (lineWidthTransition != null) {
      args['lineWidthTransition'] = lineWidthTransition?.toMap();
    }

    if (lineColor != null) {
      args['lineColor'] = lineColor is List ? jsonEncode(lineColor) : lineColor;
    }

    if (lineColorTransition != null) {
      args['lineColorTransition'] = lineColorTransition?.toMap();
    }

    if (lineBlur != null) {
      args['lineBlur'] = lineBlur is List ? jsonEncode(lineBlur) : lineBlur;
    }

    if (lineBlurTransition != null) {
      args['lineBlurTransition'] = lineBlurTransition?.toMap();
    }

    if (lineDashArray != null) {
      args['lineDashArray'] = lineDashArray is List<double>
          ? lineDashArray
          : jsonEncode(lineDashArray);
    }

    if (lineDashArrayTransition != null) {
      args['lineDashArrayTransition'] = lineDashArrayTransition?.toMap();
    }

    if (lineGapWidth != null) {
      args['lineGapWidth'] =
          lineGapWidth is List ? jsonEncode(lineGapWidth) : lineGapWidth;
    }

    if (lineGapWidthTransition != null) {
      args['lineGapWidthTransition'] = lineGapWidthTransition?.toMap();
    }

    if (lineGradient != null && lineGradient is List) {
      args['lineGradient'] = lineGradient;
    }

    if (lineMiterLimit != null) {
      args['lineMiterLimit'] =
          lineMiterLimit is List ? jsonEncode(lineMiterLimit) : lineMiterLimit;
    }

    if (lineOffset != null) {
      args['lineOffset'] =
          lineOffset is List ? jsonEncode(lineOffset) : lineOffset;
    }

    if (lineOffsetTransition != null) {
      args['lineOffsetTransition'] = lineOffsetTransition?.toMap();
    }

    if (lineOpacity != null) {
      args['lineOpacity'] =
          lineOpacity is List ? jsonEncode(lineOpacity) : lineOpacity;
    }

    if (lineOpacityTransition != null) {
      args['lineOpacityTransition'] = lineOpacityTransition?.toMap();
    }

    if (linePattern != null) {
      args['linePattern'] =
          linePattern is List ? jsonEncode(linePattern) : linePattern;
    }

    if (linePatternTransition != null) {
      args['linePatternTransition'] = linePatternTransition?.toMap();
    }

    if (lineRoundLimit != null) {
      args['lineRoundLimit'] =
          lineRoundLimit is List ? jsonEncode(lineRoundLimit) : lineRoundLimit;
    }

    if (lineSortKey != null) {
      args['lineSortKey'] =
          lineSortKey is List ? jsonEncode(lineSortKey) : lineSortKey;
    }

    if (lineTranslate != null) {
      args['lineTranslate'] = lineTranslate is List<double>
          ? lineTranslate
          : jsonEncode(lineTranslate);
    }

    if (lineTranslateTransition != null) {
      args['lineTranslateTransition.'] = lineTranslateTransition?.toMap();
    }

    if (lineTranslateAnchor != null &&
        (lineTranslateAnchor is LineTranslateAnchor ||
            lineTranslateAnchor is List)) {
      args['lineTranslateAnchor'] = lineTranslateAnchor is LineTranslateAnchor
          ? (lineTranslateAnchor as LineTranslateAnchor).name
          : lineTranslateAnchor is List
              ? jsonEncode(lineTranslateAnchor)
              : lineTranslateAnchor;
    }

    if (lineTrimOffset != null) {
      args['lineTrimOffset'] = lineTrimOffset is List<double>
          ? lineTrimOffset
          : jsonEncode(lineTrimOffset);
    }

    if (lineCap != null && (lineCap is LineCap || lineCap is List)) {
      args['lineCap'] = lineCap is LineCap
          ? (lineCap as LineCap).name
          : lineCap is List
              ? jsonEncode(lineCap)
              : lineCap;
    }

    if (lineJoin != null && (lineJoin is LineJoin || lineJoin is List)) {
      args['lineCap'] = lineJoin is LineJoin
          ? (lineJoin as LineJoin).name
          : lineJoin is List
              ? jsonEncode(lineJoin)
              : lineJoin;
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

/// LineCap
/// BUTT, ROUND and SQUARE
enum LineCap { butt, round, square }

/// LineJoin
/// ROUND, BEVEl and MITER
enum LineJoin { round, bevel, miter }

/// LineTranslateAnchor
/// MAP and VIEWPORT
enum LineTranslateAnchor { map, viewport }
