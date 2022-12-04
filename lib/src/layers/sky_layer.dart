import 'dart:convert';
import '../utils/enums.dart';
import '../utils/style_transition.dart';
import 'layer.dart';
import 'layer_properties.dart';

/// RasterLayer class
/// Created by Amit Chaudhary, 2022/10/4
class SkyLayer extends Layer<SkyLayerProperties> {
  /// Constructor for BackgroundLayer
  SkyLayer({
    required super.layerId,
    super.layerProperties,
  }) : super(sourceId: "");

  /// Method to convert the BackgroundLayer Object to the
  /// Map data to pass to the native platform through args
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "layerId": layerId,
      "layerProperties":
          (layerProperties ?? SkyLayerProperties.defaultProperties).toMap(),
    };
  }
}

/// SkyLayerProperties class
/// It contains all the properties for the sky layer
/// e.g.
/// final skyLayerProperties = SkyLayerProperties(
///                             skyAtmosphereColor: 'white',
///                         );
class SkyLayerProperties extends LayerProperties {
  /// A color used to tweak the main atmospheric scattering coefficients.
  /// Using white applies the default coefficients giving the natural blue
  /// color to the atmosphere. This color affects how heavily the corresponding
  /// wavelength is represented during scattering. The alpha channel describes
  /// the density of the atmosphere, with 1 maximum density and 0 no density.
  /// Accepted data type:
  /// - String,
  /// - int and
  /// - Expression
  /// default value is 'white'
  final dynamic skyAtmosphereColor;

  /// A color applied to the atmosphere sun halo. The alpha channel describes
  /// how strongly the sun halo is represented in an atmosphere sky layer.
  /// Accepted data type:
  /// - String,
  /// - int and
  /// - Expression
  /// default value is 'white'
  final dynamic skyAtmosphereHaloColor;

  /// Position of the sun center [a azimuthal angle, p polar angle].
  /// The azimuthal angle indicates the position of the sun relative to
  /// 0 degree north, where degrees proceed clockwise.
  /// The polar angle indicates the height of the sun, where 0 degree is
  /// directly above, at zenith, and 90 degree at the horizon. When this
  /// property is omitted, the sun center is directly inherited from
  /// the light position.
  /// Accepted data type:
  /// - List<double> and
  /// - Expression
  final dynamic skyAtmosphereSun;

  /// Intensity of the sun as a light source in the atmosphere
  /// (on a scale from 0 to a 100). Setting higher values will
  /// brighten up the sky.
  /// Accepted data type:
  /// - double and
  /// - Expression
  /// default value is 10.0
  final dynamic skyAtmosphereSunIntensity;

  /// Defines a radial color gradient with which to color the sky.
  /// The color values can be interpolated with an expression using
  /// `sky-radial-progress`. The range [0, 1] for the interpolate covers
  /// a radial distance (in degrees) of [0, `sky-gradient-radius`]
  /// centered at the position specified by `sky-gradient-center`.
  /// Accepted data type:
  /// - Expression
  /// e.g.
  ///   [
  ///    'interpolate',
  ///    ['linear'],
  ///    ['sky-radial-progress'],
  ///     0,
  ///    'blue',
  ///     0.1,
  ///    'green',
  ///     0.3,
  ///    'cyan',
  ///     0.5,
  ///    'lime',
  ///     0.7,
  ///    'yellow',
  ///     1,
  ///    'red'
  ///  ]
  final dynamic skyGradient;

  /// Position of the gradient center [a azimuthal angle, p polar angle].
  /// The azimuthal angle indicates the position of the gradient center
  /// relative to 0 degree north, where degrees proceed clockwise.
  /// The polar angle indicates the height of the gradient center,
  /// where 0 degree is directly above, at zenith, and 90 degree at the horizon.
  /// Accepted data type:
  /// - List<double> and
  /// - Expression
  /// default value is [0.0, 0.0]
  final dynamic skyGradientCenter;

  /// The angular distance (measured in degrees) from `sky-gradient-center`
  /// up to which the gradient extends. A value of 180 causes the gradient
  /// to wrap around to the opposite direction from `sky-gradient-center`.
  /// Accepted data type:
  /// - double and
  /// - Expression
  /// default value is 90.0
  final dynamic skyGradientRadius;

  /// The opacity of the entire sky layer.
  /// Accepted data type:
  /// - double and
  /// - Expression
  /// default value is 1.0
  final dynamic skyOpacity;

  /// Transition for the opacity of the entire sky layer.
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? skyOpacityTransition;

  /// The type of the sky
  /// Accepted data type:
  /// - SkyType and
  /// - Expression
  /// default value is SkyType.atmosphere
  final dynamic skyType;

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

  /// Constructor
  SkyLayerProperties({
    this.skyAtmosphereColor,
    this.skyAtmosphereHaloColor,
    this.skyAtmosphereSun,
    this.skyAtmosphereSunIntensity,
    this.skyGradient,
    this.skyGradientCenter,
    this.skyGradientRadius,
    this.skyOpacity,
    this.skyOpacityTransition,
    this.skyType,
    this.filter,
    this.visibility,
    this.minZoom,
    this.maxZoom,
  });

  /// Default SkyLayerProperties
  static SkyLayerProperties get defaultProperties {
    return SkyLayerProperties();
  }

  /// Method to proceeds the sky layer properties for native
  @override
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    if (skyAtmosphereColor != null) {
      args['skyAtmosphereColor'] = skyAtmosphereColor is List
          ? jsonEncode(skyAtmosphereColor)
          : skyAtmosphereColor;
    }

    if (skyAtmosphereHaloColor != null) {
      args['skyAtmosphereHaloColor'] = skyAtmosphereHaloColor is List
          ? jsonEncode(skyAtmosphereHaloColor)
          : skyAtmosphereHaloColor;
    }

    if (skyAtmosphereSun != null && skyAtmosphereSun is List) {
      args['skyAtmosphereSun'] = skyAtmosphereSun is List<double> ||
              skyAtmosphereSun is List<int> ||
              skyAtmosphereSun is List<num>
          ? skyAtmosphereSun
          : jsonEncode(skyAtmosphereSun);
    }

    if (skyAtmosphereSunIntensity != null) {
      args['skyAtmosphereSunIntensity'] = skyAtmosphereSunIntensity is List
          ? jsonEncode(skyAtmosphereSunIntensity)
          : skyAtmosphereSunIntensity;
    }

    if (skyGradient != null && skyGradient is List) {
      args['skyGradient'] = jsonEncode(skyGradient);
    }

    if (skyGradientCenter != null && skyGradientCenter is List) {
      args['skyGradientCenter'] = skyGradientCenter is List<double> ||
              skyGradientCenter is List<int> ||
              skyGradientCenter is List<num>
          ? skyGradientCenter
          : jsonEncode(skyGradientCenter);
    }

    if (skyGradientRadius != null) {
      args['skyGradientRadius'] = skyGradientRadius is List
          ? jsonEncode(skyGradientRadius)
          : skyGradientRadius;
    }

    if (skyOpacity != null) {
      args['skyOpacity'] =
          skyOpacity is List ? jsonEncode(skyOpacity) : skyOpacity;
    }

    if (skyOpacityTransition != null) {
      args['skyOpacityTransition'] = skyOpacityTransition?.toMap();
    }

    if (skyType != null && (skyType is SkyType || skyType is List)) {
      args['rasterResampling'] = skyType is SkyType
          ? (skyType as SkyType).name
          : skyType is List
              ? jsonEncode(skyType)
              : skyType;
    }

    if (filter != null && filter is List) {
      args['filter'] = filter;
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
