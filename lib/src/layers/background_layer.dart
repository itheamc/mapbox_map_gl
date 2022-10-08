import 'dart:convert';
import '../helper/style_transition.dart';
import 'layer.dart';
import 'layer_properties.dart';

/// BackgroundLayer class
/// Created by Amit Chaudhary, 2022/10/4
class BackgroundLayer extends Layer<BackgroundLayerProperties> {
  /// Constructor for BackgroundLayer
  BackgroundLayer({
    required super.layerId,
    super.sourceId = "",
    super.layerProperties,
  });

  /// Method to convert the BackgroundLayer Object to the
  /// Map data to pass to the native platform through args
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "layerId": layerId,
      "layerProperties":
          (layerProperties ?? BackgroundLayerProperties.defaultProperties)
              .toMap(),
    };
  }
}

/// BackgroundLayerProperties class
/// It contains all the properties for the background layer
/// e.g.
/// final backgroundLayerProperties = BackgroundLayerProperties(
///                             backgroundColor: '#000',
///                         );
class BackgroundLayerProperties extends LayerProperties {
  /// The color with which the background will be drawn.
  /// Accepted data type:
  /// - String,
  /// - int and
  /// - Expression
  /// default value is '#000000'
  final dynamic backgroundColor;

  /// Transition for the color with which the background will be drawn.
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? backgroundColorTransition;

  /// The opacity at which the background will be drawn.
  /// Accepted data type:
  /// - double and
  /// - Expression
  /// default value is 1.0
  final dynamic backgroundOpacity;

  /// Transition for the opacity at which the background will be drawn.
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? backgroundOpacityTransition;

  /// Name of image in sprite to use for drawing an image background.
  /// For seamless patterns, image width and height must be a factor
  /// of two (2, 4, 8, ..., 512).
  /// Note that zoom-dependent expressions will be evaluated only at integer
  /// zoom levels.
  /// Accepted data type:
  /// - String and
  /// - Expression
  final dynamic backgroundPattern;

  /// Name of image in sprite to use for drawing an image background.
  /// For seamless patterns, image width and height must be a factor of
  /// two (2, 4, 8, ..., 512). Note that zoom-dependent expressions will be
  /// evaluated only at integer zoom levels.
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? backgroundPatternTransition;

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
  BackgroundLayerProperties({
    this.backgroundColor,
    this.backgroundColorTransition,
    this.backgroundOpacity,
    this.backgroundOpacityTransition,
    this.backgroundPattern,
    this.backgroundPatternTransition,
    this.visibility,
    this.minZoom,
    this.maxZoom,
  });

  /// Default BackgroundLayerProperties
  static BackgroundLayerProperties get defaultProperties {
    return BackgroundLayerProperties(
      backgroundColor: "#000000",
      backgroundColorTransition: StyleTransition.build(
        delay: 275,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  /// Method to proceeds the background layer properties for native
  @override
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    if (backgroundColor != null) {
      args['backgroundColor'] = backgroundColor is List
          ? jsonEncode(backgroundColor)
          : backgroundColor;
    }

    if (backgroundColorTransition != null) {
      args['backgroundColorTransition'] = backgroundColorTransition?.toMap();
    }

    if (backgroundOpacity != null) {
      args['backgroundOpacity'] = backgroundOpacity is List
          ? jsonEncode(backgroundOpacity)
          : backgroundOpacity;
    }

    if (backgroundOpacityTransition != null) {
      args['backgroundOpacityTransition'] =
          backgroundOpacityTransition?.toMap();
    }

    if (backgroundPattern != null) {
      args['backgroundPattern'] = backgroundPattern is List
          ? jsonEncode(backgroundPattern)
          : backgroundPattern;
    }

    if (backgroundPatternTransition != null) {
      args['backgroundPatternTransition'] =
          backgroundPatternTransition?.toMap();
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
