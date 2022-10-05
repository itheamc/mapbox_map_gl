import 'dart:convert';
import '../helper/style_transition.dart';

/// CircleLayer Object
class CircleLayer {
  final String layerId;
  final String sourceId;
  final CircleLayerOptions? options;

  /// Constructor for CircleLayer
  CircleLayer({
    required this.layerId,
    required this.sourceId,
    this.options,
  });

  /// Method to convert the CircleLayer Object to the
  /// Map data to pass to the native platform through args
  Map<String, dynamic> toArgs() {
    return <String, dynamic>{
      "layerId": layerId,
      "sourceId": sourceId,
      "options": (options ?? CircleLayerOptions.defaultOptions).toArgs(),
    };
  }
}

/// CircleLayerOptions class
/// It contains all the properties for the circle layer
/// e.g.
/// final circleLayerOptions = CircleLayerOptions(
///                             circleColor: 'green',
///                             circleRadius: 10.0,
///                             circleStrokeWidth: 2.0,
///                             circleStrokeColor: "#fff",
///                             circleColor: 'green',
///                         );
class CircleLayerOptions {
  /// String, Int
  /// Expression
  final dynamic circleColor;

  /// StyleTransition
  final StyleTransition? circleColorTransition;

  /// Double
  /// Expression
  final dynamic circleRadius;

  /// StyleTransition
  final StyleTransition? circleRadiusTransition;

  /// Double
  /// Expression
  final dynamic circleBlur;

  /// StyleTransition
  final StyleTransition? circleBlurTransition;

  /// Double
  /// Expression
  final dynamic circleOpacity;

  /// StyleTransition
  final StyleTransition? circleOpacityTransition;

  /// String, Int
  /// Expression
  final dynamic circleStrokeColor;

  /// StyleTransition
  final StyleTransition? circleStrokeColorTransition;

  /// Double
  /// Expression
  final dynamic circleStrokeWidth;

  /// StyleTransition
  final StyleTransition? circleStrokeWidthTransition;

  /// Double
  /// Expression
  final dynamic circleStrokeOpacity;

  /// StyleTransition
  final StyleTransition? circleStrokeOpacityTransition;

  /// CirclePitchScale
  /// Expression
  final dynamic circlePitchScale;

  /// CirclePitchAlignment
  /// Expression
  final dynamic circlePitchAlignment;

  /// Double
  /// Expression
  final dynamic circleSortKey;

  /// List<Double>
  /// Expression
  final dynamic circleTranslate;

  /// StyleTransition
  final StyleTransition? circleTranslateTransition;

  /// CircleTranslateAnchor
  /// Expression
  final dynamic circleTranslateAnchor;

  /// String
  final String? sourceLayer;
  final dynamic filter;

  /// Double
  final double? maxZoom;
  final double? minZoom;
  final bool? visibility;

  CircleLayerOptions({
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

  /// Default Circle layer options
  static CircleLayerOptions get defaultOptions {
    return CircleLayerOptions(
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

  /// Method to proceeds the circle layer option for native
  Map<String, dynamic> toArgs() {
    final json = <String, dynamic>{};

    if (circleColor != null) {
      json['circleColor'] =
          circleColor is List ? jsonEncode(circleColor) : circleColor;
    }

    if (circleColorTransition != null) {
      json['circleColorTransition'] = circleColorTransition?.toJson();
    }

    if (circleRadius != null) {
      json['circleRadius'] =
          circleRadius is List ? jsonEncode(circleRadius) : circleRadius;
    }

    if (circleRadiusTransition != null) {
      json['circleRadiusTransition'] = circleRadiusTransition?.toJson();
    }

    if (circleBlur != null) {
      json['circleBlur'] =
          circleBlur is List ? jsonEncode(circleBlur) : circleBlur;
    }

    if (circleBlurTransition != null) {
      json['circleBlurTransition'] = circleBlurTransition?.toJson();
    }

    if (circleOpacity != null) {
      json['circleOpacity'] =
          circleOpacity is List ? jsonEncode(circleOpacity) : circleOpacity;
    }

    if (circleOpacityTransition != null) {
      json['circleOpacityTransition'] = circleOpacityTransition?.toJson();
    }

    if (circleStrokeColor != null) {
      json['circleStrokeColor'] = circleStrokeColor is List
          ? jsonEncode(circleStrokeColor)
          : circleStrokeColor;
    }

    if (circleStrokeColorTransition != null) {
      json['circleStrokeColorTransition'] =
          circleStrokeColorTransition?.toJson();
    }

    if (circleStrokeWidth != null) {
      json['circleStrokeWidth'] = circleStrokeWidth is List
          ? jsonEncode(circleStrokeWidth)
          : circleStrokeWidth;
    }

    if (circleStrokeWidthTransition != null) {
      json['circleStrokeWidthTransition'] =
          circleStrokeWidthTransition?.toJson();
    }

    if (circleStrokeOpacity != null) {
      json['circleStrokeOpacity'] = circleStrokeOpacity is List
          ? jsonEncode(circleStrokeOpacity)
          : circleStrokeOpacity;
    }

    if (circleStrokeOpacityTransition != null) {
      json['circleStrokeOpacityTransition'] =
          circleStrokeOpacityTransition?.toJson();
    }

    if (circlePitchScale != null) {
      json['circlePitchScale'] = circlePitchScale is CirclePitchScale
          ? (circlePitchScale as CirclePitchScale).name
          : circlePitchScale is List
              ? jsonEncode(circlePitchScale)
              : circlePitchScale;
    }

    if (circlePitchAlignment != null) {
      json['circlePitchAlignment'] =
          circlePitchAlignment is CirclePitchAlignment
              ? (circlePitchAlignment as CirclePitchAlignment).name
              : circlePitchAlignment is List
                  ? jsonEncode(circlePitchAlignment)
                  : circlePitchAlignment;
    }

    if (circleSortKey != null) {
      json['circleSortKey'] =
          circleSortKey is List ? jsonEncode(circleSortKey) : circleSortKey;
    }

    if (circleTranslate != null) {
      json['circleTranslate'] = circleTranslate is List<double>
          ? circleTranslate
          : jsonEncode(circleTranslate);
    }

    if (circleTranslateTransition != null) {
      json['circleTranslateTransition.'] = circleTranslateTransition?.toJson();
    }

    if (circleTranslateAnchor != null) {
      json['circleTranslateAnchor'] =
          circleTranslateAnchor is CircleTranslateAnchor
              ? (circleTranslateAnchor as CircleTranslateAnchor).name
              : circleTranslateAnchor is List
                  ? jsonEncode(circleTranslateAnchor)
                  : circleTranslateAnchor;
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

/// CircleTranslateAnchor
/// MAP and VIEWPORT
enum CircleTranslateAnchor { map, viewport }

/// CirclePitchScale
/// MAP and VIEWPORT
enum CirclePitchScale { map, viewport }

/// CirclePitchScale
/// MAP and VIEWPORT
enum CirclePitchAlignment { map, viewport }
