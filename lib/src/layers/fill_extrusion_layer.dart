import 'dart:convert';
import '../helper/style_transition.dart';
import 'layer.dart';
import 'layer_properties.dart';

/// FillExtrusionLayer class
/// Created by Amit Chaudhary, 2022/10/8
class FillExtrusionLayer extends Layer<FillExtrusionLayerProperties> {
  /// Constructor for FillExtrusionLayer
  FillExtrusionLayer({
    required super.layerId,
    required super.sourceId,
    super.layerProperties,
  });

  /// Method to convert the FillExtrusionLayer Object to the
  /// Map data to pass to the native platform through args
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "layerId": layerId,
      "sourceId": sourceId,
      "layerProperties":
          (layerProperties ?? FillExtrusionLayerProperties.defaultProperties)
              .toMap(),
    };
  }
}

/// FillExtrusionLayerProperties class
/// It contains all the properties for the fill extrusion layer
/// e.g.
/// final fillExtrusionLayerProperties = FillExtrusionLayerProperties(
///                             fillExtrusionColor: '#000000',
///                         );
class FillExtrusionLayerProperties extends LayerProperties {
  /// Controls the intensity of ambient occlusion (AO) shading.
  /// Current AO implementation is a low-cost best-effort approach that shades
  /// area near ground and concave angles between walls. Default value 0.0
  /// disables ambient occlusion and values around 0.3 provide the most
  /// plausible results for buildings.
  /// Accepted data type:
  /// - double and
  /// - Expression
  /// default value is 0.0
  final dynamic fillExtrusionAmbientOcclusionIntensity;

  /// Transition for intensity of ambient occlusion (AO) shading.
  /// Current AO implementation is a low-cost best-effort approach that
  /// shades area near ground and concave angles between walls.
  /// Default value 0.0 disables ambient occlusion and values around 0.3
  /// provide the most plausible results for buildings.
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? fillExtrusionAmbientOcclusionIntensityTransition;

  /// The radius of ambient occlusion (AO) shading, in meters.
  /// Current AO implementation is a low-cost best-effort approach that
  /// shades area near ground and concave angles between walls where the
  /// radius defines only vertical impact. Default value 3.0 corresponds
  /// to height of one floor and brings the most plausible
  /// results for buildings.
  /// Accepted data type:
  /// - double and
  /// - Expression
  /// default value is 3.0
  final dynamic fillExtrusionAmbientOcclusionRadius;

  /// Transition for the radius of ambient occlusion (AO) shading, in meters.
  /// Current AO implementation is a low-cost best-effort approach that shades
  /// area near ground and concave angles between walls where the radius
  /// defines only vertical impact. Default value 3.0 corresponds to height
  /// of one floor and brings the most plausible results for buildings.
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? fillExtrusionAmbientOcclusionRadiusTransition;

  /// The height with which to extrude the base of this layer.
  /// Must be less than or equal to `fill-extrusion-height`.
  /// Accepted data type:
  /// - double and
  /// - Expression
  /// default value is 0.0
  final dynamic fillExtrusionBase;

  /// Transition for the height with which to extrude the base of this layer.
  /// Must be less than or equal to `fill-extrusion-height`.
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? fillExtrusionBaseTransition;

  /// The base color of the extruded fill.
  /// The extrusion's surfaces will be shaded differently based on this color
  /// in combination with the root `light` settings. If this color is specified
  /// as `rgba` with an alpha component, the alpha component will be ignored;
  /// use `fill-extrusion-opacity` to set layer opacity.
  /// Accepted data type:
  /// - String
  /// - int and
  /// - Expression
  /// default value is '#000000'
  final dynamic fillExtrusionColor;

  /// Transition for the base color of the extruded fill.
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? fillExtrusionColorTransition;

  /// The height with which to extrude this layer.
  /// Accepted data type:
  /// - double and
  /// - Expression
  /// default value is 0.0
  final dynamic fillExtrusionHeight;

  /// Transition for the height with which to extrude this layer.
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? fillExtrusionHeightTransition;

  /// The opacity of the entire fill extrusion layer. This is rendered on
  /// a per-layer, not per-feature, basis, and data-driven styling
  /// is not available.
  /// Accepted data type:
  /// - double and
  /// - Expression
  /// default value is 1.0
  final dynamic fillExtrusionOpacity;

  /// Transition for the opacity of the entire fill extrusion layer.
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? fillExtrusionOpacityTransition;

  /// Name of image in sprite to use for drawing images on extruded fills.
  /// For seamless patterns, image width and height must be a factor of two
  /// (2, 4, 8, ..., 512). Note that zoom-dependent expressions will be
  /// evaluated only at integer zoom levels.
  /// Accepted data type:
  /// - String and
  /// - Expression
  final dynamic fillExtrusionPattern;

  /// Transition for fillExtrusionPattern
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? fillExtrusionPatternTransition;

  /// The geometry's offset. Values are [x, y] where negatives indicate
  /// left and up (on the flat plane), respectively.
  /// Accepted data type:
  /// - List<double> and
  /// - Expression
  /// default value is [0.0, 0.0]
  final dynamic fillExtrusionTranslate;

  /// Transition for fillExtrusionTranslate
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? fillExtrusionTranslateTransition;

  /// Controls the frame of reference for `fill-extrusion-translate`.
  /// Accepted data type:
  /// - FillExtrusionTranslateAnchor and
  /// Expression
  /// default value is FillExtrusionTranslateAnchor.map
  final dynamic fillExtrusionTranslateAnchor;

  /// Whether to apply a vertical gradient to the sides of a
  /// fill-extrusion layer. If true, sides will be shaded slightly
  /// darker farther down.
  /// Accepted data type:
  /// - bool and
  /// Expression
  /// default value is true
  final dynamic fillExtrusionVerticalGradient;

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
  FillExtrusionLayerProperties({
    this.fillExtrusionAmbientOcclusionIntensity,
    this.fillExtrusionAmbientOcclusionIntensityTransition,
    this.fillExtrusionAmbientOcclusionRadius,
    this.fillExtrusionAmbientOcclusionRadiusTransition,
    this.fillExtrusionBase,
    this.fillExtrusionBaseTransition,
    this.fillExtrusionColor,
    this.fillExtrusionColorTransition,
    this.fillExtrusionHeight,
    this.fillExtrusionHeightTransition,
    this.fillExtrusionOpacity,
    this.fillExtrusionOpacityTransition,
    this.fillExtrusionPattern,
    this.fillExtrusionPatternTransition,
    this.fillExtrusionTranslate,
    this.fillExtrusionTranslateTransition,
    this.fillExtrusionTranslateAnchor,
    this.fillExtrusionVerticalGradient,
    this.filter,
    this.sourceLayer,
    this.visibility,
    this.minZoom,
    this.maxZoom,
  });

  /// Default FillExtrusionLayerProperties
  static FillExtrusionLayerProperties get defaultProperties {
    return FillExtrusionLayerProperties(
        // heatmapIntensity: 1.0,
        // heatmapIntensityTransition: StyleTransition.build(
        //   delay: 275,
        //   duration: const Duration(milliseconds: 500),
        // ),
        );
  }

  /// Method to proceeds the fill extrusion layer properties for native
  @override
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    if (fillExtrusionAmbientOcclusionIntensity != null) {
      args['fillExtrusionAmbientOcclusionIntensity'] =
          fillExtrusionAmbientOcclusionIntensity is List
              ? jsonEncode(fillExtrusionAmbientOcclusionIntensity)
              : fillExtrusionAmbientOcclusionIntensity;
    }

    if (fillExtrusionAmbientOcclusionIntensityTransition != null) {
      args['fillExtrusionAmbientOcclusionIntensityTransition'] =
          fillExtrusionAmbientOcclusionIntensityTransition?.toMap();
    }

    if (fillExtrusionAmbientOcclusionRadius != null) {
      args['fillExtrusionAmbientOcclusionRadius'] =
          fillExtrusionAmbientOcclusionRadius is List
              ? jsonEncode(fillExtrusionAmbientOcclusionRadius)
              : fillExtrusionAmbientOcclusionRadius;
    }

    if (fillExtrusionAmbientOcclusionRadiusTransition != null) {
      args['fillExtrusionAmbientOcclusionRadiusTransition'] =
          fillExtrusionAmbientOcclusionRadiusTransition?.toMap();
    }

    if (fillExtrusionBase != null) {
      args['fillExtrusionBase'] = fillExtrusionBase is List
          ? jsonEncode(fillExtrusionBase)
          : fillExtrusionBase;
    }

    if (fillExtrusionBaseTransition != null) {
      args['fillExtrusionBaseTransition'] =
          fillExtrusionBaseTransition?.toMap();
    }

    if (fillExtrusionColor != null) {
      args['fillExtrusionColor'] = fillExtrusionColor is List
          ? jsonEncode(fillExtrusionColor)
          : fillExtrusionColor;
    }

    if (fillExtrusionColorTransition != null) {
      args['fillExtrusionColorTransition'] =
          fillExtrusionColorTransition?.toMap();
    }

    if (fillExtrusionHeight != null) {
      args['fillExtrusionHeight'] = fillExtrusionHeight is List
          ? jsonEncode(fillExtrusionHeight)
          : fillExtrusionHeight;
    }

    if (fillExtrusionHeightTransition != null) {
      args['fillExtrusionHeightTransition'] =
          fillExtrusionHeightTransition?.toMap();
    }

    if (fillExtrusionOpacity != null) {
      args['fillExtrusionOpacity'] = fillExtrusionOpacity is List
          ? jsonEncode(fillExtrusionOpacity)
          : fillExtrusionOpacity;
    }

    if (fillExtrusionOpacityTransition != null) {
      args['fillExtrusionOpacityTransition'] =
          fillExtrusionOpacityTransition?.toMap();
    }

    if (fillExtrusionPattern != null) {
      args['fillExtrusionPattern'] = fillExtrusionPattern is List
          ? jsonEncode(fillExtrusionPattern)
          : fillExtrusionPattern;
    }

    if (fillExtrusionPatternTransition != null) {
      args['fillExtrusionPatternTransition'] =
          fillExtrusionPatternTransition?.toMap();
    }

    if (fillExtrusionTranslate != null && fillExtrusionTranslate is List) {
      args['fillExtrusionTranslate'] = fillExtrusionTranslate is List<double> ||
              fillExtrusionTranslate is List<int> ||
              fillExtrusionTranslate is List<num>
          ? fillExtrusionTranslate
          : jsonEncode(fillExtrusionTranslate);
    }

    if (fillExtrusionTranslateTransition != null) {
      args['fillExtrusionTranslateTransition'] =
          fillExtrusionTranslateTransition?.toMap();
    }

    if (fillExtrusionTranslateAnchor != null &&
        (fillExtrusionTranslateAnchor is FillExtrusionTranslateAnchor ||
            fillExtrusionTranslateAnchor is List)) {
      args['fillExtrusionTranslateAnchor'] = fillExtrusionTranslateAnchor
              is FillExtrusionTranslateAnchor
          ? (fillExtrusionTranslateAnchor as FillExtrusionTranslateAnchor).name
          : fillExtrusionTranslateAnchor is List
              ? jsonEncode(fillExtrusionTranslateAnchor)
              : fillExtrusionTranslateAnchor;
    }

    if (fillExtrusionVerticalGradient != null) {
      args['fillExtrusionVerticalGradient'] =
          fillExtrusionVerticalGradient is List
              ? jsonEncode(fillExtrusionVerticalGradient)
              : fillExtrusionVerticalGradient;
    }

    if (filter != null && filter is List) {
      args['filter'] = jsonEncode(filter);
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

enum FillExtrusionTranslateAnchor {
  /// The fill extrusion is translated relative to the map.
  map,

  /// The fill extrusion is translated relative to the viewport.
  viewport,
}
