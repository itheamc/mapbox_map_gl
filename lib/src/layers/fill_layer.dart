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
}

/// FillTranslateAnchor
/// MAP and VIEWPORT
enum FillTranslateAnchor { map, viewport }
