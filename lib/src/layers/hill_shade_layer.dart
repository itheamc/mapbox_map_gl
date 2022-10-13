import 'dart:convert';
import '../utils/style_transition.dart';
import 'layer.dart';
import 'layer_properties.dart';

/// HillShadeLayer class
/// Created by Amit Chaudhary, 2022/10/8
class HillShadeLayer extends Layer<HillShadeLayerProperties> {
  /// Constructor for HillShadeLayer
  HillShadeLayer({
    required super.layerId,
    required super.sourceId,
    super.layerProperties,
  });

  /// Method to convert the HillShadeLayer Object to the
  /// Map data to pass to the native platform through args
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "layerId": layerId,
      "sourceId": sourceId,
      "layerProperties":
          (layerProperties ?? HillShadeLayerProperties.defaultProperties)
              .toMap(),
    };
  }
}

/// HillShadeLayerProperties class
/// It contains all the properties for the hill shade layer
/// e.g.
/// final hillShadeLayerProperties = HillShadeLayerProperties(
///                             hillShadeAccentColor: '#2de12',
///                         );
class HillShadeLayerProperties extends LayerProperties {
  /// The shading color used to accentuate rugged terrain like sharp cliffs
  /// and gorges.
  /// Accepted data type -  String, int and Expression
  /// Default value is '#00000'
  final dynamic hillShadeAccentColor;

  /// The shading color used to accentuate rugged terrain like sharp
  /// cliffs and gorges.
  /// Accepted data type -  StyleTransition
  final StyleTransition? hillShadeAccentColorTransition;

  /// Intensity of the hill shade
  /// Accepted value double and Expression
  /// default value is 0.5
  final dynamic hillShadeExaggeration;

  /// Transition for intensity of the hill shade
  /// Accepted data type -  StyleTransition
  final StyleTransition? hillShadeExaggerationTransition;

  /// The shading color of areas that faces towards the light source.
  /// Accepted data type -  String, int and Expression
  /// default value is "#fff"
  final dynamic hillShadeHighlightColor;

  /// The shading color of areas that faces towards the light source.
  /// Accepted data type -  StyleTransition
  final StyleTransition? hillShadeHighlightColorTransition;

  /// Direction of light source when map is rotated.
  /// Accepted data type -  HillShadeIlluminationAnchor and Expression
  /// default value is HillShadeIlluminationAnchor.viewport
  final dynamic hillShadeIlluminationAnchor;

  /// The direction of the light source used to generate the hill shading
  /// with 0 as the top of the viewport if `hill shade-illumination-anchor`
  /// is set to `viewport` and due north if `hill shade-illumination-anchor`
  /// is set to `map`.
  /// Accepted value double and Expression
  /// default value is 335.0
  final dynamic hillShadeIlluminationDirection;

  /// The shading color of areas that face away from the light source.
  /// Accepted data type -  String, int and Expression
  final dynamic hillShadeShadowColor;

  /// The shading color of areas that face away from the light source.
  /// StyleTransition
  final StyleTransition? hillShadeShadowColorTransition;

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
  HillShadeLayerProperties({
    this.hillShadeAccentColor,
    this.hillShadeAccentColorTransition,
    this.hillShadeExaggeration,
    this.hillShadeExaggerationTransition,
    this.hillShadeHighlightColor,
    this.hillShadeHighlightColorTransition,
    this.hillShadeIlluminationAnchor,
    this.hillShadeIlluminationDirection,
    this.hillShadeShadowColor,
    this.hillShadeShadowColorTransition,
    this.sourceLayer,
    this.visibility,
    this.minZoom,
    this.maxZoom,
  });

  /// Default HillShadeLayerProperties
  static HillShadeLayerProperties get defaultProperties {
    return HillShadeLayerProperties(
      hillShadeAccentColor: '#00000',
      hillShadeAccentColorTransition: StyleTransition.build(
        delay: 275,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  /// Method to proceeds the fill layer properties for native
  @override
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    if (hillShadeAccentColor != null) {
      args['hillShadeAccentColor'] = hillShadeAccentColor is List
          ? jsonEncode(hillShadeAccentColor)
          : hillShadeAccentColor;
    }

    if (hillShadeAccentColorTransition != null) {
      args['hillShadeAccentColorTransition'] =
          hillShadeAccentColorTransition?.toMap();
    }

    if (hillShadeExaggeration != null) {
      args['hillShadeExaggeration'] = hillShadeExaggeration is List
          ? jsonEncode(hillShadeExaggeration)
          : hillShadeExaggeration;
    }

    if (hillShadeExaggerationTransition != null) {
      args['hillShadeExaggerationTransition'] =
          hillShadeExaggerationTransition?.toMap();
    }

    if (hillShadeHighlightColor != null) {
      args['hillShadeHighlightColor'] = hillShadeHighlightColor is List
          ? jsonEncode(hillShadeHighlightColor)
          : hillShadeHighlightColor;
    }

    if (hillShadeHighlightColorTransition != null) {
      args['hillShadeHighlightColorTransition'] =
          hillShadeHighlightColorTransition?.toMap();
    }

    if (hillShadeIlluminationAnchor != null &&
        (hillShadeIlluminationAnchor is HillShadeIlluminationAnchor ||
            hillShadeIlluminationAnchor is List)) {
      args['hillShadeIlluminationAnchor'] = hillShadeIlluminationAnchor
              is HillShadeIlluminationAnchor
          ? (hillShadeIlluminationAnchor as HillShadeIlluminationAnchor).name
          : hillShadeIlluminationAnchor is List
              ? jsonEncode(hillShadeIlluminationAnchor)
              : hillShadeIlluminationAnchor;
    }

    if (hillShadeIlluminationDirection != null) {
      args['hillShadeIlluminationDirection'] =
          hillShadeIlluminationDirection is List
              ? jsonEncode(hillShadeIlluminationDirection)
              : hillShadeIlluminationDirection;
    }

    if (hillShadeShadowColor != null) {
      args['hillShadeShadowColor'] = hillShadeShadowColor is List
          ? jsonEncode(hillShadeShadowColor)
          : hillShadeShadowColor;
    }

    if (hillShadeShadowColorTransition != null) {
      args['hillShadeShadowColorTransition'] =
          hillShadeShadowColorTransition?.toMap();
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

enum HillShadeIlluminationAnchor {
  /// The hill shade illumination is relative to the north direction.
  map,

  /// The hill shade illumination is relative to the top of the viewport.
  viewport,
}
