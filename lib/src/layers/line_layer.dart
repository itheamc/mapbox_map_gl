import 'dart:convert';
import '../helper/style_transition.dart';

/// LineLayer Object
class LineLayer {
  final String layerId;
  final String sourceId;
  final LineLayerOptions? options;

  /// Constructor for LineLayer
  LineLayer({
    required this.layerId,
    required this.sourceId,
    this.options,
  });

  /// Method to convert the LineLayer Object to the
  /// Map data to pass to the native platform through args
  Map<String, dynamic> toArgs() {
    return <String, dynamic>{
      "layerId": layerId,
      "sourceId": sourceId,
      "options": (options ?? LineLayerOptions.defaultOptions).toArgs(),
    };
  }
}

/// LineLayerOptions class
/// It contains all the properties for the line layer
/// e.g.
/// final lineLayerOptions = LineLayerOptions(
///                             lineWidth: 2.0,
///                             lineColor: 'red',
///                             lineWidth: 2.0,
///                             lineWidth: 2.0,
///                         );
class LineLayerOptions {
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

  LineLayerOptions({
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

  /// Default Line Layer Options
  static LineLayerOptions get defaultOptions {
    return LineLayerOptions(
      lineWidth: 2.0,
      lineColor: 'blue',
      lineCap: LineCap.round,
      lineJoin: LineJoin.round,
    );
  }

  /// Method to proceeds the line layer option for native
  Map<String, dynamic> toArgs() {
    final json = <String, dynamic>{};

    if (lineWidth != null) {
      json['lineWidth'] = lineWidth is List ? jsonEncode(lineWidth) : lineWidth;
    }

    if (lineWidthTransition != null) {
      json['lineWidthTransition'] = lineWidthTransition?.toJson();
    }

    if (lineColor != null) {
      json['lineColor'] = lineColor is List ? jsonEncode(lineColor) : lineColor;
    }

    if (lineColorTransition != null) {
      json['lineColorTransition'] = lineColorTransition?.toJson();
    }

    if (lineBlur != null) {
      json['lineBlur'] = lineBlur is List ? jsonEncode(lineBlur) : lineBlur;
    }

    if (lineBlurTransition != null) {
      json['lineBlurTransition'] = lineBlurTransition?.toJson();
    }

    if (lineDashArray != null) {
      json['lineDashArray'] = lineDashArray is List<double>
          ? lineDashArray
          : jsonEncode(lineDashArray);
    }

    if (lineDashArrayTransition != null) {
      json['lineDashArrayTransition'] = lineDashArrayTransition?.toJson();
    }

    if (lineGapWidth != null) {
      json['lineGapWidth'] =
          lineGapWidth is List ? jsonEncode(lineGapWidth) : lineGapWidth;
    }

    if (lineGapWidthTransition != null) {
      json['lineGapWidthTransition'] = lineGapWidthTransition?.toJson();
    }

    if (lineGradient != null && lineGradient is List) {
      json['lineGradient'] = lineGradient;
    }

    if (lineMiterLimit != null) {
      json['lineMiterLimit'] =
          lineMiterLimit is List ? jsonEncode(lineMiterLimit) : lineMiterLimit;
    }

    if (lineOffset != null) {
      json['lineOffset'] =
          lineOffset is List ? jsonEncode(lineOffset) : lineOffset;
    }

    if (lineOffsetTransition != null) {
      json['lineOffsetTransition'] = lineOffsetTransition?.toJson();
    }

    if (lineOpacity != null) {
      json['lineOpacity'] =
          lineOpacity is List ? jsonEncode(lineOpacity) : lineOpacity;
    }

    if (lineOpacityTransition != null) {
      json['lineOpacityTransition'] = lineOpacityTransition?.toJson();
    }

    if (linePattern != null) {
      json['linePattern'] =
          linePattern is List ? jsonEncode(linePattern) : linePattern;
    }

    if (linePatternTransition != null) {
      json['linePatternTransition'] = linePatternTransition?.toJson();
    }

    if (lineRoundLimit != null) {
      json['lineRoundLimit'] =
          lineRoundLimit is List ? jsonEncode(lineRoundLimit) : lineRoundLimit;
    }

    if (lineSortKey != null) {
      json['lineSortKey'] =
          lineSortKey is List ? jsonEncode(lineSortKey) : lineSortKey;
    }

    if (lineTranslate != null) {
      json['lineTranslate'] = lineTranslate is List<double>
          ? lineTranslate
          : jsonEncode(lineTranslate);
    }

    if (lineTranslateTransition != null) {
      json['lineTranslateTransition.'] = lineTranslateTransition?.toJson();
    }

    if (lineTranslateAnchor != null &&
        (lineTranslateAnchor is LineTranslateAnchor ||
            lineTranslateAnchor is List)) {
      json['lineTranslateAnchor'] = lineTranslateAnchor is LineTranslateAnchor
          ? (lineTranslateAnchor as LineTranslateAnchor).name
          : lineTranslateAnchor is List
              ? jsonEncode(lineTranslateAnchor)
              : lineTranslateAnchor;
    }

    if (lineTrimOffset != null) {
      json['lineTrimOffset'] = lineTrimOffset is List<double>
          ? lineTrimOffset
          : jsonEncode(lineTrimOffset);
    }

    if (lineCap != null && (lineCap is LineCap || lineCap is List)) {
      json['lineCap'] = lineCap is LineCap
          ? (lineCap as LineCap).name
          : lineCap is List
              ? jsonEncode(lineCap)
              : lineCap;
    }

    if (lineJoin != null && (lineJoin is LineJoin || lineJoin is List)) {
      json['lineCap'] = lineJoin is LineJoin
          ? (lineJoin as LineJoin).name
          : lineJoin is List
              ? jsonEncode(lineJoin)
              : lineJoin;
    }

    if (sourceLayer != null) {
      json['sourceLayer'] = sourceLayer;
    }

    if (filter != null) {
      json['filter'] = jsonEncode(filter);
    }

    if (maxZoom != null) {
      json['maxZoom'] = maxZoom;
    }

    if (minZoom != null) {
      json['minZoom'] = minZoom;
    }

    if (visibility != null) {
      json['visibility'] = visibility;
    }

    return json;
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
