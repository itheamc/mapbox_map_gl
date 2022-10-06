import 'dart:convert';
import '../helper/style_transition.dart';

/// FillLayer
class FillLayer {
  final String layerId;
  final String sourceId;
  final FillLayerOptions? options;

  /// Constructor for FillLayer
  FillLayer({
    required this.layerId,
    required this.sourceId,
    this.options,
  });

  /// Method to convert the FillLayer Object to the
  /// Map data to pass to the native platform through args
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "layerId": layerId,
      "sourceId": sourceId,
      "options": (options ?? FillLayerOptions.defaultOptions).toMap(),
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

  /// Default FillLayerOptions
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
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    if (fillColor != null) {
      args['fillColor'] = fillColor is List ? jsonEncode(fillColor) : fillColor;
    }

    if (fillColorTransition != null) {
      args['fillColorTransition'] = fillColorTransition?.toMap();
    }

    if (fillAntialias != null) {
      args['fillAntialias'] =
          fillAntialias is List ? jsonEncode(fillAntialias) : fillAntialias;
    }

    if (fillOpacity != null) {
      args['fillOpacity'] =
          fillOpacity is List ? jsonEncode(fillOpacity) : fillOpacity;
    }

    if (fillOpacityTransition != null) {
      args['fillOpacityTransition'] = fillOpacityTransition?.toMap();
    }

    if (fillOutlineColor != null) {
      args['fillOutlineColor'] = fillOutlineColor is List
          ? jsonEncode(fillOutlineColor)
          : fillOutlineColor;
    }

    if (fillOutlineColorTransition != null) {
      args['fillOutlineColorTransition'] = fillOutlineColorTransition?.toMap();
    }

    if (fillPattern != null) {
      args['fillPattern'] =
          fillPattern is List ? jsonEncode(fillPattern) : fillPattern;
    }

    if (fillPatternTransition != null) {
      args['fillPatternTransition'] = fillPatternTransition?.toMap();
    }

    if (fillSortKey != null) {
      args['fillSortKey'] =
          fillSortKey is List ? jsonEncode(fillSortKey) : fillSortKey;
    }

    if (fillTranslate != null) {
      args['fillTranslate'] = fillTranslate is List<double>
          ? fillTranslate
          : jsonEncode(fillTranslate);
    }

    if (fillTranslateTransition != null) {
      args['fillTranslateTransition.'] = fillTranslateTransition?.toMap();
    }

    if (fillTranslateAnchor != null) {
      args['fillTranslateAnchor'] = fillTranslateAnchor is FillTranslateAnchor
          ? (fillTranslateAnchor as FillTranslateAnchor).name
          : fillTranslateAnchor is List
              ? jsonEncode(fillTranslateAnchor)
              : fillTranslateAnchor;
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

/// FillTranslateAnchor
/// MAP and VIEWPORT
enum FillTranslateAnchor { map, viewport }
