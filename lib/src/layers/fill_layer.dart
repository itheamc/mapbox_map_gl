import 'dart:convert';
import '../utils/enums.dart';
import 'layer.dart';
import 'layer_properties.dart';

import '../utils/style_transition.dart';

/// FillLayer class
/// Created by Amit Chaudhary, 2022/10/3
class FillLayer extends Layer<FillLayerProperties> {
  /// Constructor for FillLayer
  FillLayer({
    required super.layerId,
    required super.sourceId,
    super.layerProperties,
  });

  /// Method to convert the FillLayer Object to the
  /// Map data to pass to the native platform through args
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "layerId": layerId,
      "sourceId": sourceId,
      "layerProperties":
          (layerProperties ?? FillLayerProperties.defaultProperties).toMap(),
    };
  }
}

/// FillLayerProperties class
/// It contains all the properties for the fill layer
/// e.g.
/// final fillLayerProperties = FillLayerProperties(
///                             fillColor: 'red',
///                         );
class FillLayerProperties extends LayerProperties {
  /// The color of the filled part of this layer. This color can be specified
  /// as rgba with an alpha component and the color's opacity will not affect
  /// the opacity of the 1px stroke, if it is used.
  /// Accepted data type:
  /// - String,
  /// - Int and
  /// - Expression
  /// default value is '#000000'
  final dynamic fillColor;

  /// StyleTransition for fill color
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? fillColorTransition;

  /// Whether or not the fill should be antialiasing.
  /// Accepted data type:
  /// - Boolean and
  /// - Expression
  /// default value is true
  final dynamic fillAntialias;

  /// The opacity of the entire fill layer.
  /// In contrast to the fill-color, this value will also affect the
  /// 1px stroke around the fill, if the stroke is used.
  /// Accepted data type:
  /// - Double and
  /// - Expression
  /// default value is 1.0
  final dynamic fillOpacity;

  /// StyleTransition for fill opacity
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? fillOpacityTransition;

  /// The outline color of the fill. Matches the value of fill-color if unspecified.
  /// Accepted data type:
  /// - String,
  /// - Int and
  /// - Expression
  final dynamic fillOutlineColor;

  /// StyleTransition for fillOutlineColor
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? fillOutlineColorTransition;

  /// Name of image in sprite to use for drawing image fills.
  /// For seamless patterns, image width and height must be a factor of
  /// two (2, 4, 8, ..., 512). Note that zoom-dependent expressions will
  /// be evaluated only at integer zoom levels.
  /// Accepted data type:
  /// - String and
  /// - Expression
  final dynamic fillPattern;

  /// StyleTransition for fill pattern
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? fillPatternTransition;

  /// Sorts features in ascending order based on this value. Features with
  /// a higher sort key will appear above features with a lower sort key.
  /// Accepted data type:
  /// - Double and
  /// - Expression
  final dynamic fillSortKey;

  /// The geometry's offset. Values are x, y where negatives indicate
  /// left and up, respectively.
  /// Accepted data type:
  /// - List<Double> and
  /// - Expression
  final dynamic fillTranslate;

  /// StyleTransition for fill translate
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? fillTranslateTransition;

  /// Controls the frame of reference for fill-translate.
  /// Accepted data type:
  /// - FillTranslateAnchor
  /// - Expression
  /// default value is FillTranslateAnchor.map
  final dynamic fillTranslateAnchor;

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

  FillLayerProperties({
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

  /// Default fill layer properties
  static FillLayerProperties get defaultProperties {
    return FillLayerProperties(
      fillColor: 'blue',
      fillColorTransition: StyleTransition.build(
        delay: 300,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  /// Method to proceeds the fill layer properties for native
  @override
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
      args['fillTranslate'] = fillTranslate is List<double> ||
              fillTranslate is List<int> ||
              fillTranslate is List<num>
          ? fillTranslate
          : jsonEncode(fillTranslate);
    }

    if (fillTranslateTransition != null) {
      args['fillTranslateTransition.'] = fillTranslateTransition?.toMap();
    }

    if (fillTranslateAnchor != null &&
        (fillTranslateAnchor is FillTranslateAnchor ||
            fillTranslateAnchor is List)) {
      args['fillTranslateAnchor'] = fillTranslateAnchor is FillTranslateAnchor
          ? (fillTranslateAnchor as FillTranslateAnchor).name
          : fillTranslateAnchor is List
              ? jsonEncode(fillTranslateAnchor)
              : fillTranslateAnchor;
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
