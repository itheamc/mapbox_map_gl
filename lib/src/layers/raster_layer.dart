import 'dart:convert';

import '../../mapbox_map_gl.dart';

/// RasterLayer
class RasterLayer {
  final String layerId;
  final String sourceId;
  final RasterLayerOptions? options;

  /// Constructor for RasterLayer
  RasterLayer({
    required this.layerId,
    required this.sourceId,
    this.options,
  });

  /// Method to convert the RasterLayer Object to the
  /// Map data to pass to the native platform through args
  Map<String, dynamic> toArgs() {
    return <String, dynamic>{
      "layerId": layerId,
      "sourceId": sourceId,
      "options": (options ?? RasterLayerOptions.defaultOptions).toArgs(),
    };
  }
}

/// RasterLayerOptions class
/// It contains all the properties for the raster layer
/// e.g.
/// final fillLayerOptions = RasterLayerOptions(
///                             rasterBrightnessMax: 0.88,
///                         );
class RasterLayerOptions {
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
  RasterLayerOptions({
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

  /// Default RasterLayerOptions
  static RasterLayerOptions get defaultOptions {
    return RasterLayerOptions(
      rasterBrightnessMax: 1.0,
      rasterBrightnessMaxTransition: StyleTransition.build(
        delay: 300,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  /// Method to proceeds the fill layer option for native
  Map<String, dynamic> toArgs() {
    final json = <String, dynamic>{};

    if (rasterBrightnessMax != null) {
      json['rasterBrightnessMax'] = rasterBrightnessMax is List
          ? jsonEncode(rasterBrightnessMax)
          : rasterBrightnessMax;
    }

    if (rasterBrightnessMaxTransition != null) {
      json['rasterBrightnessMaxTransition'] =
          rasterBrightnessMaxTransition?.toJson();
    }

    if (rasterBrightnessMin != null) {
      json['rasterBrightnessMax'] = rasterBrightnessMin is List
          ? jsonEncode(rasterBrightnessMin)
          : rasterBrightnessMin;
    }

    if (rasterBrightnessMinTransition != null) {
      json['rasterBrightnessMinTransition'] =
          rasterBrightnessMinTransition?.toJson();
    }

    if (rasterContrast != null) {
      json['rasterContrast'] =
          rasterContrast is List ? jsonEncode(rasterContrast) : rasterContrast;
    }

    if (rasterContrastTransition != null) {
      json['rasterContrastTransition'] = rasterContrastTransition?.toJson();
    }

    if (rasterFadeDuration != null) {
      json['rasterFadeDuration'] = rasterFadeDuration is List
          ? jsonEncode(rasterFadeDuration)
          : rasterFadeDuration;
    }

    if (rasterHueRotate != null) {
      json['rasterHueRotate'] = rasterHueRotate is List
          ? jsonEncode(rasterHueRotate)
          : rasterHueRotate;
    }

    if (rasterHueRotateTransition != null) {
      json['rasterHueRotateTransition'] = rasterHueRotateTransition?.toJson();
    }

    if (rasterOpacity != null) {
      json['rasterOpacity'] =
          rasterOpacity is List ? jsonEncode(rasterOpacity) : rasterOpacity;
    }

    if (rasterOpacityTransition != null) {
      json['rasterOpacityTransition'] = rasterOpacityTransition?.toJson();
    }

    if (rasterResampling != null) {
      json['rasterResampling'] = rasterResampling is RasterResampling
          ? (rasterResampling as RasterResampling).name
          : rasterResampling is List
              ? jsonEncode(rasterResampling)
              : rasterResampling;
    }

    if (rasterSaturation != null) {
      json['rasterSaturation'] = rasterSaturation is List
          ? jsonEncode(rasterSaturation)
          : rasterSaturation;
    }

    if (rasterSaturationTransition != null) {
      json['rasterSaturationTransition'] = rasterSaturationTransition?.toJson();
    }

    if (sourceLayer != null) {
      json['sourceLayer'] = sourceLayer;
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

enum RasterResampling { linear, nearest }
