import 'dart:convert';
import 'package:mapbox_map_gl/src/layers/layer.dart';
import 'package:mapbox_map_gl/src/layers/layer_properties.dart';

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
  /// Double
  /// Expression
  final dynamic lineWidth;

  /// StyleTransition
  final StyleTransition? lineWidthTransition;

  /// String, Int
  /// Expression
  final dynamic lineColor;

  /// StyleTransition
  final StyleTransition? lineColorTransition;

  /// Double
  /// Expression
  final dynamic lineBlur;

  /// StyleTransition
  final StyleTransition? lineBlurTransition;

  /// List<Double>
  /// Expression
  final dynamic lineDashArray;

  /// StyleTransition
  final StyleTransition? lineDashArrayTransition;

  /// Double
  /// Expression
  final dynamic lineGapWidth;

  /// StyleTransition
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

  /// Double
  /// Expression
  final dynamic lineMiterLimit;

  /// Double
  /// Expression
  final dynamic lineOffset;

  /// StyleTransition
  final StyleTransition? lineOffsetTransition;

  /// Double
  /// Expression
  final dynamic lineOpacity;

  /// StyleTransition
  final StyleTransition? lineOpacityTransition;

  /// String
  /// Expression
  final dynamic linePattern;

  /// StyleTransition
  final StyleTransition? linePatternTransition;

  /// Double
  /// Expression
  final dynamic lineRoundLimit;

  /// Double
  /// Expression
  final dynamic lineSortKey;

  /// List<Double>
  /// Expression
  final dynamic lineTranslate;

  /// StyleTransition
  final StyleTransition? lineTranslateTransition;

  /// LineTranslateAnchor
  /// Expression
  final dynamic lineTranslateAnchor;

  /// List<Double>
  /// Expression
  final dynamic lineTrimOffset;

  /// LineCap
  /// Expression
  final dynamic lineCap;

  /// LineJoin
  /// Expression
  final dynamic lineJoin;

  /// String
  final String? sourceLayer;
  final dynamic filter;

  /// Double
  final double? maxZoom;
  final double? minZoom;
  final bool? visibility;

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

    if (filter != null) {
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
