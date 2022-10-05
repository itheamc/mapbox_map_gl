import 'dart:convert';

import 'package:mapbox_map_gl/src/utils/style_transition.dart';

class FillLayer {
  final String layerId;
  final String sourceId;
  final FillLayerOptions? options;

  FillLayer({
    required this.layerId,
    required this.sourceId,
    this.options,
  });

  Map<String, dynamic> toArgs() {
    return <String, dynamic>{
      "layerId": layerId,
      "sourceId": sourceId,
      "options": (options ?? FillLayerOptions.defaultOptions).toArgs(),
    };
  }
}

/// FillLayerOptions class
/// It contains all the properties for the fill layer
/// e.g.
/// final fillLayerOptions = FillLayerOptions(
///                             fillColor: 'red',
///                         );
class FillLayerOptions {
  /// String, Int
  /// Expression
  final dynamic fillColor;

  /// StyleTransition
  final StyleTransition? fillColorTransition;

  /// Boolean
  /// Expression
  final dynamic fillAntialias;

  /// Double
  /// Expression
  final dynamic fillOpacity;

  /// StyleTransition
  final StyleTransition? fillOpacityTransition;

  /// String, Int
  /// Expression
  final dynamic fillOutlineColor;

  /// StyleTransition
  final StyleTransition? fillOutlineColorTransition;

  /// String
  /// Expression
  final dynamic fillPattern;

  /// StyleTransition
  final StyleTransition? fillPatternTransition;

  /// Double
  /// Expression
  final dynamic fillSortKey;

  /// List<Double>
  /// Expression
  final dynamic fillTranslate;

  /// StyleTransition
  final StyleTransition? fillTranslateTransition;

  /// FillTranslateAnchor
  /// Expression
  final dynamic fillTranslateAnchor;

  /// String
  final String? sourceLayer;
  final dynamic filter;

  /// Double
  final double? maxZoom;
  final double? minZoom;
  final bool? visibility;

  FillLayerOptions({
    this.fillColor,
    this.fillColorTransition,
    this.fillAntialias,
    this.fillOpacity,
    this.fillOpacityTransition,
    this.fillOutlineColor,
    this.fillOutlineColorTransition,
    this.fillPattern,
    this.fillPatternTransition,
    this.fillSortKey,
    this.fillTranslate,
    this.fillTranslateTransition,
    this.fillTranslateAnchor,
    this.sourceLayer,
    this.filter,
    this.maxZoom,
    this.minZoom,
    this.visibility,
  });

  static FillLayerOptions get defaultOptions {
    return FillLayerOptions(
      fillColor: 'blue',
      fillColorTransition: StyleTransition.build(
        delay: 300,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  /// Method to proceeds the fill layer option for native
  Map<String, dynamic> toArgs() {
    final json = <String, dynamic>{};

    if (fillColor != null) {
      json['fillColor'] = fillColor is List ? jsonEncode(fillColor) : fillColor;
    }

    if (fillColorTransition != null) {
      json['fillColorTransition'] = fillColorTransition?.toJson();
    }

    if (fillAntialias != null) {
      json['fillAntialias'] =
          fillAntialias is List ? jsonEncode(fillAntialias) : fillAntialias;
    }

    if (fillOpacity != null) {
      json['fillOpacity'] =
          fillOpacity is List ? jsonEncode(fillOpacity) : fillOpacity;
    }

    if (fillOpacityTransition != null) {
      json['fillOpacityTransition'] = fillOpacityTransition?.toJson();
    }

    if (fillOutlineColor != null) {
      json['fillOutlineColor'] = fillOutlineColor is List
          ? jsonEncode(fillOutlineColor)
          : fillOutlineColor;
    }

    if (fillOutlineColorTransition != null) {
      json['fillOutlineColorTransition'] = fillOutlineColorTransition?.toJson();
    }

    if (fillPattern != null) {
      json['fillPattern'] =
          fillPattern is List ? jsonEncode(fillPattern) : fillPattern;
    }

    if (fillPatternTransition != null) {
      json['fillPatternTransition'] = fillPatternTransition?.toJson();
    }

    if (fillSortKey != null) {
      json['fillSortKey'] =
          fillSortKey is List ? jsonEncode(fillSortKey) : fillSortKey;
    }

    if (fillTranslate != null) {
      json['fillTranslate'] = fillTranslate is List<double>
          ? fillTranslate
          : jsonEncode(fillTranslate);
    }

    if (fillTranslateTransition != null) {
      json['fillTranslateTransition.'] = fillTranslateTransition?.toJson();
    }

    if (fillTranslateAnchor != null) {
      json['fillTranslateAnchor'] = fillTranslateAnchor is FillTranslateAnchor
          ? (fillTranslateAnchor as FillTranslateAnchor).name
          : fillTranslateAnchor is List
              ? jsonEncode(fillTranslateAnchor)
              : fillTranslateAnchor;
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

/// FillTranslateAnchor
/// MAP and VIEWPORT
enum FillTranslateAnchor { map, viewport }
