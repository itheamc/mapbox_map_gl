import 'dart:io';
import 'package:flutter/services.dart';

import '../utils/log_util.dart';
import 'annotation.dart';
import 'annotation_options.dart';
import '../utils/point.dart';

/// PointAnnotation class
/// Created by Amit Chaudhary, 2022/11/30
class PointAnnotation extends Annotation<PointAnnotationOptions> {
  /// Url of the icon that you want to display in map
  /// e.g. https://myicons.com/icon/marker.png
  /// If iconImage, iconUrl and iconPath all are provided then icon referenced
  /// from the iconImage will be displayed
  final String? iconUrl;

  /// [iconPath] - An icon name along with the path
  /// e.g. - assets/icons/point_icon.png
  /// If iconImage, iconUrl and iconPath all are provided then icon referenced
  /// from the iconImage will be displayed
  final String? iconPath;

  /// [iconImage] - Id/Name of the image added through the style image
  ///         await _controller.addStyleImage<NetworkStyleImage>(
  ///                               image: NetworkStyleImage(
  ///                                   imageId: "my_icon",
  ///                                   url: "https://example.com/icon.png",
  ///                               ),
  ///                           );
  /// e.g. - in this case [iconImage] will be my_icon
  /// If iconImage, iconUrl and iconPath all are provided then icon referenced
  /// from the iconImage will be displayed
  final String? iconImage;

  /// Constructor for PointAnnotation
  PointAnnotation({
    this.iconUrl,
    this.iconPath,
    this.iconImage,
    required super.annotationOptions,
  }) : assert(iconUrl != null || iconPath != null,
            "Please provide iconUrl or iconPath.");

  /// Method to convert the PointAnnotation Object to the
  /// Map data to pass to the native platform through args
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "annotationOptions": annotationOptions.toMap(),
    };
  }

  /// Method to get byte array
  Future<Uint8List?> getByteArray() async {
    try {
      if (iconPath == null || iconPath!.trim().isEmpty) {
        if (iconUrl == null ||
            iconUrl!.trim().isEmpty ||
            !iconUrl!.contains("http")) return null;

        final uri = Uri.tryParse(iconUrl!.trim());

        if (uri == null) return null;

        final client = HttpClient();
        final request = await client.getUrl(uri);
        final response = await request.close();

        final list = await response.first;

        return Uint8List.fromList(list);
      }

      final bytes = await rootBundle.load(iconPath!.trim());
      final list = bytes.buffer.asUint8List();
      return list;
    } on Exception catch (e, _) {
      LogUtil.log(
        className: "PointAnnotation",
        function: "getByteArray",
        message: e,
      );
    }
    return null;
  }
}

/// PointAnnotationOptions class
/// It contains all the properties for the polygon annotation
/// e.g.
/// final pointAnnotationOptions = PointAnnotationOptions(
///                             points: Point.fromLatLng(27.34, 85.43),
///                             fillColor: "#ef2d3f",
///                         );
class PointAnnotationOptions extends AnnotationOptions {
  /// Set the Point of the point annotation, which represents the location
  /// of the point annotation on the map
  /// Accepted data type:
  /// - Point
  final Point point;

  /// The color of the icon. This can only be used with [SDF icons]
  /// (/help/troubleshooting/using-recolorable-images-in-mapbox-maps/).
  /// String and
  /// int
  /// Default value is '#000
  final dynamic iconColor;

  /// Scales the original size of the icon by the provided factor.
  /// The new pixel size of the image will be the original pixel
  /// size multiplied by `icon-size`. 1 is the original size;
  /// 3 triples the size of the image.
  /// Double or Expression
  /// Default is 1.0
  final dynamic iconSize;

  /// The opacity at which the icon will be drawn.
  /// double and Expression
  /// Default value is 1.0
  final dynamic iconOpacity;

  /// Rotates the icon clockwise.
  /// Double or Expression
  /// Default is 0.0
  final dynamic iconRotate;

  /// Part of the icon placed closest to the anchor.
  /// PointIconAnchor
  /// Default is PointIconAnchor.center
  final PointIconAnchor? iconAnchor;

  /// Offset distance of icon from its anchor.
  /// Positive values indicate right and down,
  /// while negative values indicate left and up.
  /// Each component is multiplied by the value of `icon-size` to obtain
  /// the final offset in pixels.
  /// When combined with `icon-rotate` the offset will be as if the
  /// rotated direction was up.
  /// List<Double> or Expression
  /// Default value is listOf(0.0, 0.0)
  final dynamic iconOffset;

  /// The color of the icon's halo. Icon halos can only be used with [SDF icons]
  /// (/help/troubleshooting/using-recolorable-images-in-mapbox-maps/).
  /// String, int or Expression
  final dynamic iconHaloColor;

  /// Fade out the halo towards the outside.
  /// double or Expression
  /// Default value is 0.0
  final dynamic iconHaloBlur;

  /// Distance of halo to the icon outline.
  /// double and Expression
  /// Default value is 0.0
  final dynamic iconHaloWidth;

  /// Value to use for a text label. If a plain `string` is provided,
  /// it will be treated as a `formatted` with default/inherited
  /// formatting options. SDF images are not supported in formatted text
  /// and will be ignored.
  /// String and Expression
  final dynamic textField;

  /// The color with which the text will be drawn.
  /// String, int or Expression
  /// Default is '#000'
  final dynamic textColor;

  /// The opacity at which the text will be drawn.
  /// double or Expression
  /// Default value is 1.0
  final dynamic textOpacity;

  /// Font size.
  /// double or Expression
  /// Default value is 16.0
  final dynamic textSize;

  /// Rotates the text clockwise.
  /// double or Expression
  /// Default value is 0.0
  final dynamic textRotate;

  /// Text tracking amount.
  /// Double and Expression
  /// Default value is 0.0
  final dynamic textLetterSpacing;

  /// Text leading value for multi-line text.
  /// Double and Expression
  /// Default value is 1.2
  final dynamic textLineHeight;

  /// Offset distance of text from its anchor.
  ///
  /// Positive values indicate right and down, while negative values
  /// indicate left and up. If used with text-variable-anchor, input values
  /// will be taken as absolute values. Offsets along the x- and y-axis will
  /// be applied automatically based on the anchor position.
  /// List<double> or Expression
  /// Default is listOf(0.0, 0.0)
  final dynamic textOffset;

  /// The color of the text's halo, which helps it stand out from backgrounds.
  /// String, int or Expression
  /// Default is '#000'
  final dynamic textHaloColor;

  /// The halo's fadeout distance towards the outside.
  /// double or Expression
  /// Default value is  0.0
  final dynamic textHaloBlur;

  /// Distance of halo to the font outline. Max text halo width is 1/4
  /// of the font-size.
  /// double or Expression
  /// Default value is 0.0
  final dynamic textHaloWidth;

  /// The maximum line width for text wrapping.
  /// double
  /// Default value is 10.0
  final double? textMaxWidth;

  /// Set text-radial-offset to initialise the pointAnnotation with.
  /// Radial offset of text, in the direction of the symbol's anchor.
  /// Useful in combination with {@link PropertyFactory#textVariableAnchor},
  /// which defaults to using the two-dimensional
  /// {@link PropertyFactory#textOffset} if present.
  /// double
  /// Default value is 10.0
  final double? textRadialOffset;

  /// Sorts features in ascending order based on this value.
  /// Features with lower sort keys are drawn and placed first.
  /// When `icon-allow-overlap` or `text-allow-overlap` is `false`,
  /// features with a lower sort key will have priority during
  /// placement. When `icon-allow-overlap` or `text-allow-overlap`
  /// is set to `true`, features with a higher sort key will overlap
  /// over features with a lower sort key.
  /// Double
  final dynamic symbolSortKey;

  /// Part of the text placed closest to the anchor.
  /// PointTextAnchor
  /// Default value is PointTextAnchor.center
  final PointTextAnchor? textAnchor;

  /// Text justification options.
  /// PointTextJustify
  /// Default is PointTextJustify.enter
  final PointTextJustify? textJustify;

  /// Specifies how to capitalize text, similar to the CSS
  /// `text-transform` property.
  /// PointTextTransform
  /// Default is PointTextTransform.NONE
  final PointTextTransform? textTransform;

  /// Set whether this circleAnnotation should be draggable, meaning it can be
  /// dragged across the screen when touched and moved.
  /// Accepted data type - bool
  /// default value is false
  final bool draggable;

  /// Set the arbitrary json data of the annotation.
  /// Accepted data type - Map<String, dynamic>
  /// default value is <String, dynamic>{}
  final Map<String, dynamic>? data;

  /// Constructor
  PointAnnotationOptions({
    required this.point,
    this.iconColor,
    this.iconSize,
    this.iconOpacity,
    this.iconRotate,
    this.iconAnchor,
    this.iconOffset,
    this.iconHaloColor,
    this.iconHaloBlur,
    this.iconHaloWidth,
    this.textField,
    this.textColor,
    this.textOpacity,
    this.textSize,
    this.textRotate,
    this.textLetterSpacing,
    this.textLineHeight,
    this.textOffset,
    this.textHaloColor,
    this.textHaloBlur,
    this.textHaloWidth,
    this.textMaxWidth,
    this.textRadialOffset,
    this.symbolSortKey,
    this.textAnchor,
    this.textJustify,
    this.textTransform,
    this.draggable = false,
    this.data,
  });

  /// Method to proceeds the point annotation option for native
  @override
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    args['point'] = point.toMap();

    if (iconColor != null) {
      args['iconColor'] = iconColor;
    }

    if (iconSize != null) {
      args['iconSize'] = iconSize;
    }

    if (iconOpacity != null) {
      args['iconOpacity'] = iconOpacity;
    }

    if (iconRotate != null) {
      args['iconRotate'] = iconRotate;
    }

    if (iconAnchor != null) {
      args['iconAnchor'] = iconAnchor?.name;
    }

    if (iconOffset != null) {
      args['iconOffset'] = iconOffset;
    }

    if (iconHaloColor != null) {
      args['iconHaloColor'] = iconHaloColor;
    }

    if (iconHaloBlur != null) {
      args['iconHaloBlur'] = iconHaloBlur;
    }

    if (iconHaloWidth != null) {
      args['iconHaloWidth'] = iconHaloWidth;
    }

    if (textField != null) {
      args['textField'] = textField;
    }

    if (textColor != null) {
      args['textColor'] = textColor;
    }

    if (textOpacity != null) {
      args['textOpacity'] = textOpacity;
    }

    if (textSize != null) {
      args['textSize'] = textSize;
    }

    if (textRotate != null) {
      args['textRotate'] = textRotate;
    }

    if (textLetterSpacing != null) {
      args['textLetterSpacing'] = textLetterSpacing;
    }

    if (textLineHeight != null) {
      args['textLineHeight'] = textLineHeight;
    }

    if (textOffset != null) {
      args['textOffset'] = textOffset;
    }

    if (textHaloColor != null) {
      args['textHaloColor'] = textHaloColor;
    }

    if (textHaloBlur != null) {
      args['textHaloBlur'] = textHaloBlur;
    }

    if (textHaloWidth != null) {
      args['textHaloWidth'] = textHaloWidth;
    }

    if (textMaxWidth != null) {
      args['textMaxWidth'] = textMaxWidth;
    }

    if (textRadialOffset != null) {
      args['textRadialOffset'] = textRadialOffset;
    }

    if (symbolSortKey != null) {
      args['symbolSortKey'] = symbolSortKey;
    }

    if (textAnchor != null) {
      args['textAnchor'] = textAnchor?.name;
    }

    if (textJustify != null) {
      args['textJustify'] = textJustify?.name;
    }

    if (textTransform != null) {
      args['textTransform'] = textTransform?.name;
    }

    if (data != null) {
      args['data'] = data;
    }

    args['draggable'] = draggable;

    return args.isNotEmpty ? args : null;
  }
}

/// Point Icon Anchor Enum Class
enum PointIconAnchor {
  center,
  left,
  right,
  top,
  bottom,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

/// Point Text Anchor Enum Class
enum PointTextAnchor {
  center,
  left,
  right,
  top,
  bottom,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

/// Point Text Justify Enum Class
enum PointTextJustify {
  auto,
  left,
  center,
  right,
}

/// Point Text Transform Enum Class
enum PointTextTransform {
  none,
  uppercase,
  lowercase,
}
