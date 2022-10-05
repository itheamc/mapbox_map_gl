import 'package:mapbox_map_gl/src/utils/style_transition.dart';

class LineLayer {
  final String layerId;
  final String sourceId;
  final LineLayerOptions? options;

  LineLayer({
    required this.layerId,
    required this.sourceId,
    this.options,
  });
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

  static LineLayerOptions get defaultOptions {
    return LineLayerOptions(
      lineWidth: 2.0,
      lineColor: 'blue',
      lineCap: LineCap.round,
      lineJoin: LineJoin.round,
    );
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
