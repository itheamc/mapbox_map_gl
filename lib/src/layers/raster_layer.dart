import 'dart:convert';
import '../utils/style_transition.dart';
import 'layer.dart';
import 'layer_properties.dart';

/// RasterLayer class
/// Created by Amit Chaudhary, 2022/10/4
class RasterLayer extends Layer<RasterLayerProperties> {
  /// Constructor for RasterLayer
  RasterLayer({
    required super.layerId,
    required super.sourceId,
    super.layerProperties,
  });

  /// Method to convert the RasterLayer Object to the
  /// Map data to pass to the native platform through args
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "layerId": layerId,
      "sourceId": sourceId,
      "layerProperties":
          (layerProperties ?? RasterLayerProperties.defaultProperties).toMap(),
    };
  }
}

/// RasterLayerProperties class
/// It contains all the properties for the raster layer
/// e.g.
/// final rasterLayerProperties = RasterLayerProperties(
///                             rasterBrightnessMax: 0.88,
///                         );
class RasterLayerProperties extends LayerProperties {
  /// Increase or reduce the brightness of the image.
  /// The value is the maximum brightness.
  /// Accepted data type - double or expression
  /// default value is 1.0
  final dynamic rasterBrightnessMax;

  /// Increase or reduce the brightness of the image.
  /// The value is the maximum brightness.
  /// Accepted data type - StyleTransition
  final StyleTransition? rasterBrightnessMaxTransition;

  /// Increase or reduce the brightness of the image.
  /// The value is the minimum brightness.
  /// Accepted data type - double or expression
  /// default value is 0.0
  final dynamic rasterBrightnessMin;

  /// Increase or reduce the brightness of the image.
  /// The value is the minimum brightness.
  /// Accepted data type - StyleTransition
  final StyleTransition? rasterBrightnessMinTransition;

  /// Increase or reduce the contrast of the image.
  /// Accepted data type - double or expression
  /// default value is 0.0
  final dynamic rasterContrast;

  /// Increase or reduce the contrast of the image.
  /// Accepted data type - StyleTransition
  final StyleTransition? rasterContrastTransition;

  /// Fade duration when a new tile is added.
  /// Accepted data type - double or expression
  /// default value is 300.0
  final dynamic rasterFadeDuration;

  /// Rotates hues around the color wheel.
  /// Accepted data type - double or expression
  /// default value is 0.0
  final dynamic rasterHueRotate;

  /// Rotates hues around the color wheel.
  /// Accepted data type - StyleTransition
  final StyleTransition? rasterHueRotateTransition;

  /// The opacity at which the image will be drawn.
  /// Accepted data type - double or expression
  /// default value is 1.0
  final dynamic rasterOpacity;

  /// The opacity at which the image will be drawn.
  /// Accepted data type - StyleTransition
  final StyleTransition? rasterOpacityTransition;

  /// The resampling/interpolation method to use for overscaling,
  /// also known as texture magnification filter
  /// Accepted data type - RasterResampling ro Expression
  /// default value is RasterResampling.linear
  final dynamic rasterResampling;

  /// Increase or reduce the saturation of the image.
  /// Accepted data type - double or expression
  /// default value is 0.0
  final dynamic rasterSaturation;

  /// Increase or reduce the saturation of the image.
  /// Accepted data type - StyleTransition
  final StyleTransition? rasterSaturationTransition;

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
  RasterLayerProperties({
    this.rasterBrightnessMax,
    this.rasterBrightnessMaxTransition,
    this.rasterBrightnessMin,
    this.rasterBrightnessMinTransition,
    this.rasterContrast,
    this.rasterContrastTransition,
    this.rasterFadeDuration,
    this.rasterHueRotate,
    this.rasterHueRotateTransition,
    this.rasterOpacity,
    this.rasterOpacityTransition,
    this.rasterResampling,
    this.rasterSaturation,
    this.rasterSaturationTransition,
    this.sourceLayer,
    this.visibility,
    this.minZoom,
    this.maxZoom,
  });

  /// Default RasterLayerProperties
  static RasterLayerProperties get defaultProperties {
    return RasterLayerProperties(
      rasterBrightnessMax: 1.0,
      rasterBrightnessMaxTransition: StyleTransition.build(
        delay: 300,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  /// Method to proceeds the fill layer properties for native
  @override
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    if (rasterBrightnessMax != null) {
      args['rasterBrightnessMax'] = rasterBrightnessMax is List
          ? jsonEncode(rasterBrightnessMax)
          : rasterBrightnessMax;
    }

    if (rasterBrightnessMaxTransition != null) {
      args['rasterBrightnessMaxTransition'] =
          rasterBrightnessMaxTransition?.toMap();
    }

    if (rasterBrightnessMin != null) {
      args['rasterBrightnessMax'] = rasterBrightnessMin is List
          ? jsonEncode(rasterBrightnessMin)
          : rasterBrightnessMin;
    }

    if (rasterBrightnessMinTransition != null) {
      args['rasterBrightnessMinTransition'] =
          rasterBrightnessMinTransition?.toMap();
    }

    if (rasterContrast != null) {
      args['rasterContrast'] =
          rasterContrast is List ? jsonEncode(rasterContrast) : rasterContrast;
    }

    if (rasterContrastTransition != null) {
      args['rasterContrastTransition'] = rasterContrastTransition?.toMap();
    }

    if (rasterFadeDuration != null) {
      args['rasterFadeDuration'] = rasterFadeDuration is List
          ? jsonEncode(rasterFadeDuration)
          : rasterFadeDuration;
    }

    if (rasterHueRotate != null) {
      args['rasterHueRotate'] = rasterHueRotate is List
          ? jsonEncode(rasterHueRotate)
          : rasterHueRotate;
    }

    if (rasterHueRotateTransition != null) {
      args['rasterHueRotateTransition'] = rasterHueRotateTransition?.toMap();
    }

    if (rasterOpacity != null) {
      args['rasterOpacity'] =
          rasterOpacity is List ? jsonEncode(rasterOpacity) : rasterOpacity;
    }

    if (rasterOpacityTransition != null) {
      args['rasterOpacityTransition'] = rasterOpacityTransition?.toMap();
    }

    if (rasterResampling != null &&
        (rasterResampling is RasterResampling || rasterResampling is List)) {
      args['rasterResampling'] = rasterResampling is RasterResampling
          ? (rasterResampling as RasterResampling).name
          : rasterResampling is List
              ? jsonEncode(rasterResampling)
              : rasterResampling;
    }

    if (rasterSaturation != null) {
      args['rasterSaturation'] = rasterSaturation is List
          ? jsonEncode(rasterSaturation)
          : rasterSaturation;
    }

    if (rasterSaturationTransition != null) {
      args['rasterSaturationTransition'] = rasterSaturationTransition?.toMap();
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

enum RasterResampling { linear, nearest }
