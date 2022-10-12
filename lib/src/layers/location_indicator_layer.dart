import 'dart:convert';

import '../helper/style_transition.dart';
import 'layer.dart';
import 'layer_properties.dart';

/// LocationIndicatorLayer class
/// Created by Amit Chaudhary, 2022/10/4
class LocationIndicatorLayer extends Layer<LocationIndicatorLayerProperties> {
  /// Constructor for LocationIndicatorLayer
  LocationIndicatorLayer({
    required super.layerId,
    super.sourceId = "",
    super.layerProperties,
  });

  /// Method to convert the LocationIndicatorLayer Object to the
  /// Map data to pass to the native platform through args
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "layerId": layerId,
      "layerProperties": (layerProperties ??
              LocationIndicatorLayerProperties.defaultProperties)
          .toMap(),
    };
  }
}

/// LocationIndicatorLayerProperties class
/// It contains all the properties for the location indicator layer
/// e.g.
/// final locationIndicatorLayerProperties = LocationIndicatorLayerProperties(
///                             rasterBrightnessMax: 0.88,
///                         );
class LocationIndicatorLayerProperties extends LayerProperties {
  /// Name of image in sprite to use as the middle of the location indicator.
  /// Accepted data type:
  /// - String,
  /// - Expression
  final dynamic bearingImage;

  /// Name of image in sprite to use as the background of the location indicator.
  /// Accepted data type:
  /// - String,
  /// - Expression
  final dynamic shadowImage;

  /// Name of image in sprite to use as the top of the location indicator.
  /// Accepted data type:
  /// - String,
  /// - Expression
  final dynamic topImage;

  /// The accuracy, in meters, of the position source used to retrieve
  /// the position of the location indicator.
  /// Accepted data type:
  /// - double,
  /// - Expression
  /// default value is 0.0
  final dynamic accuracyRadius;

  /// Transition for accuracy radius
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? accuracyRadiusTransition;

  /// The color for drawing the accuracy radius border. To adjust transparency,
  /// set the alpha component of the color accordingly.
  /// Accepted data type:
  /// - String,
  /// - int and
  /// - Expression
  /// default value is '#fff'
  final dynamic accuracyRadiusBorderColor;

  /// Transition for accuracyRadiusBorderColor
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? accuracyRadiusBorderColorTransition;

  /// The color for drawing the accuracy radius, as a circle.
  /// To adjust transparency, set the alpha component of the color accordingly.
  /// Accepted data type:
  /// - String,
  /// - int and
  /// - Expression
  /// default value is '#fff'
  final dynamic accuracyRadiusColor;

  /// Transition for accuracyRadiusColor
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? accuracyRadiusColorTransition;

  /// The bearing of the location indicator.
  /// Accepted data type:
  /// - double,
  /// - Expression
  /// default value is 0.0
  final dynamic bearing;

  /// Transition for bearing
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? bearingTransition;

  /// The size of the bearing image, as a scale factor applied to the size
  /// of the specified image.
  /// Accepted data type:
  /// - double,
  /// - Expression
  /// default value is 1.0
  final dynamic bearingImageSize;

  /// Transition for bearingImageSize
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? bearingImageSizeTransition;

  /// The color of the circle emphasizing the indicator.
  /// To adjust transparency, set the alpha component of the color accordingly.
  /// Accepted data type:
  /// - String,
  /// - int and
  /// - Expression
  /// default value is '#fff'
  final dynamic emphasisCircleColor;

  /// Transition for emphasisCircleColor
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? emphasisCircleColorTransition;

  /// The radius, in pixel, of the circle emphasizing the indicator,
  /// drawn between the accuracy radius and the indicator shadow.
  /// Accepted data type:
  /// - double,
  /// - Expression
  /// default value is 0.0
  final dynamic emphasisCircleRadius;

  /// Transition for emphasisCircleRadius
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? emphasisCircleRadiusTransition;

  /// The displacement off the center of the top image and the shadow image
  /// when the pitch of the map is greater than 0. This helps producing a
  /// three-dimensional appearence.
  /// Accepted data type:
  /// - double,
  /// - Expression
  /// default value is 0.0
  final dynamic imagePitchDisplacement;

  /// An array of [latitude, longitude, altitude] position of
  /// the location indicator.
  /// Accepted data type:
  /// - List<double>,
  /// - Expression
  /// default value is [0.0, 0.0, 0.0]
  final dynamic location;

  /// Transition for location
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? locationTransition;

  /// The amount of the perspective compensation, between 0 and 1.
  /// A value of 1 produces a location indicator of constant width
  /// across the screen. A value of 0 makes it scale naturally
  /// according to the viewing projection.
  /// Accepted data type:
  /// - double,
  /// - Expression
  /// default value is 0.85
  final dynamic perspectiveCompensation;

  /// The size of the shadow image, as a scale factor applied to
  /// the size of the specified image.
  /// Accepted data type:
  /// - double,
  /// - Expression
  /// default value is 1.0
  final dynamic shadowImageSize;

  /// Transition for shadowImageSize
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? shadowImageSizeTransition;

  /// The size of the top image, as a scale factor applied to the size
  /// of the specified image.
  /// Accepted data type:
  /// - double,
  /// - Expression
  /// default value is 1.0
  final dynamic topImageSize;

  /// Transition for topImageSize
  /// Accepted data type:
  /// - StyleTransition
  final StyleTransition? topImageSizeTransition;

  /// Whether this layer is displayed.
  /// Accepted data type - bool
  /// default value is true
  final bool? visibility;

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
  LocationIndicatorLayerProperties({
    this.bearingImage,
    this.shadowImage,
    this.topImage,
    this.accuracyRadius,
    this.accuracyRadiusTransition,
    this.accuracyRadiusBorderColor,
    this.accuracyRadiusBorderColorTransition,
    this.accuracyRadiusColor,
    this.accuracyRadiusColorTransition,
    this.bearing,
    this.bearingTransition,
    this.bearingImageSize,
    this.bearingImageSizeTransition,
    this.emphasisCircleColor,
    this.emphasisCircleColorTransition,
    this.emphasisCircleRadius,
    this.emphasisCircleRadiusTransition,
    this.imagePitchDisplacement,
    this.location,
    this.locationTransition,
    this.perspectiveCompensation,
    this.shadowImageSize,
    this.shadowImageSizeTransition,
    this.topImageSize,
    this.topImageSizeTransition,
    this.visibility,
    this.minZoom,
    this.maxZoom,
  });

  /// Default LocationIndicatorLayerProperties
  static LocationIndicatorLayerProperties get defaultProperties {
    return LocationIndicatorLayerProperties();
  }

  /// Method to proceeds the location indicator layer properties for native
  @override
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    if (bearingImage != null) {
      args['bearingImage'] =
          bearingImage is List ? jsonEncode(bearingImage) : bearingImage;
    }

    if (shadowImage != null) {
      args['shadowImage'] =
          shadowImage is List ? jsonEncode(shadowImage) : shadowImage;
    }

    if (topImage != null) {
      args['topImage'] = topImage is List ? jsonEncode(topImage) : topImage;
    }

    if (accuracyRadius != null) {
      args['accuracyRadius'] =
          accuracyRadius is List ? jsonEncode(accuracyRadius) : accuracyRadius;
    }

    if (accuracyRadiusTransition != null) {
      args['accuracyRadiusTransition'] = accuracyRadiusTransition?.toMap();
    }

    if (accuracyRadiusBorderColor != null) {
      args['accuracyRadiusBorderColor'] = accuracyRadiusBorderColor is List
          ? jsonEncode(accuracyRadiusBorderColor)
          : accuracyRadiusBorderColor;
    }

    if (accuracyRadiusBorderColorTransition != null) {
      args['accuracyRadiusBorderColorTransition'] =
          accuracyRadiusBorderColorTransition?.toMap();
    }

    if (accuracyRadiusColor != null) {
      args['accuracyRadiusColor'] = accuracyRadiusColor is List
          ? jsonEncode(accuracyRadiusColor)
          : accuracyRadiusColor;
    }

    if (accuracyRadiusColorTransition != null) {
      args['accuracyRadiusColorTransition'] =
          accuracyRadiusColorTransition?.toMap();
    }

    if (bearing != null) {
      args['bearing'] = bearing is List ? jsonEncode(bearing) : bearing;
    }

    if (bearingTransition != null) {
      args['bearingTransition'] = bearingTransition?.toMap();
    }

    if (bearingImageSize != null) {
      args['bearingImageSize'] = bearingImageSize is List
          ? jsonEncode(bearingImageSize)
          : bearingImageSize;
    }

    if (bearingImageSizeTransition != null) {
      args['bearingImageSizeTransition'] = bearingImageSizeTransition?.toMap();
    }

    if (emphasisCircleColor != null) {
      args['emphasisCircleColor'] = emphasisCircleColor is List
          ? jsonEncode(emphasisCircleColor)
          : emphasisCircleColor;
    }

    if (emphasisCircleColorTransition != null) {
      args['emphasisCircleColorTransition'] =
          emphasisCircleColorTransition?.toMap();
    }

    if (emphasisCircleRadius != null) {
      args['emphasisCircleRadius'] = emphasisCircleRadius is List
          ? jsonEncode(emphasisCircleRadius)
          : emphasisCircleRadius;
    }

    if (emphasisCircleRadiusTransition != null) {
      args['emphasisCircleRadiusTransition'] =
          emphasisCircleRadiusTransition?.toMap();
    }

    if (imagePitchDisplacement != null) {
      args['imagePitchDisplacement'] = imagePitchDisplacement is List
          ? jsonEncode(imagePitchDisplacement)
          : imagePitchDisplacement;
    }

    if (location != null) {
      args['location'] = location is List<double> ||
              location is List<int> ||
              location is List<num>
          ? location
          : jsonEncode(location);
    }

    if (locationTransition != null) {
      args['locationTransition'] = locationTransition?.toMap();
    }

    if (perspectiveCompensation != null) {
      args['perspectiveCompensation'] = perspectiveCompensation is List
          ? jsonEncode(perspectiveCompensation)
          : perspectiveCompensation;
    }

    if (shadowImageSize != null) {
      args['shadowImageSize'] = shadowImageSize is List
          ? jsonEncode(shadowImageSize)
          : shadowImageSize;
    }

    if (shadowImageSizeTransition != null) {
      args['shadowImageSizeTransition'] = shadowImageSizeTransition?.toMap();
    }

    if (topImageSize != null) {
      args['topImageSize'] =
          topImageSize is List ? jsonEncode(topImageSize) : topImageSize;
    }

    if (topImageSizeTransition != null) {
      args['topImageSizeTransition'] = topImageSizeTransition?.toMap();
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
