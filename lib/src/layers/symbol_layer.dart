import '../helper/style_transition.dart';

/// SymbolLayer Object
class SymbolLayer {
  final String layerId;
  final String sourceId;
  final SymbolLayerOptions? options;

  /// Constructor for SymbolLayer
  SymbolLayer({
    required this.layerId,
    required this.sourceId,
    this.options,
  });

  /// Method to convert the SymbolLayer Object to the
  /// Map data to pass to the native platform through args
  Map<String, dynamic> toArgs() {
    return <String, dynamic>{
      "layerId": layerId,
      "sourceId": sourceId,
      "options": (options ?? SymbolLayerOptions.defaultOptions).toArgs(),
    };
  }
}

/// SymbolLayerOptions class
/// It contains all the properties for the circle layer
/// e.g.
/// final circleLayerOptions = SymbolLayerOptions(
///                             iconImage: 'my-image-name',
///                             iconSize: 2.0,
///                         );
class SymbolLayerOptions {
  /// If true, the icon will be visible even if it collides with other
  /// previously drawn symbols.
  /// Boolean - true or false or Expression
  /// Default is false
  final dynamic iconAllowOverlap;

  /// Part of the icon placed closest to the anchor.
  /// IconAnchor or Expression
  /// Default is IconAnchor.center
  final dynamic iconAnchor;

  /// If true, other symbols can be visible even if they collide with the icon.
  /// Boolean or Expression
  /// Default is false
  final dynamic iconIgnorePlacement;

  /// Name of image in sprite to use for drawing an image background.
  /// String or Expression
  final dynamic iconImage;

  /// If true, the icon may be flipped to prevent it
  /// from being rendered upside-down.
  /// Boolean or Expression
  /// Default is false
  final dynamic iconKeepUpright;

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

  /// If true, text will display without their corresponding icons
  /// when the icon collides with other symbols and the text does not.
  /// Boolean or Expression
  /// Default is false
  final dynamic iconOptional;

  /// Size of the additional area around the icon bounding box used
  /// for detecting symbol collisions.
  /// Double or Expression
  /// Default value is 2.0
  final dynamic iconPadding;

  /// Orientation of icon when map is pitched.
  /// IconPitchAlignment or Expression
  /// Default is IconPitchAlignment.auto
  final dynamic iconPitchAlignment;

  /// Rotates the icon clockwise.
  /// Double or Expression
  /// Default is 0.0
  final dynamic iconRotate;

  /// In combination with `symbol-placement`, determines the
  /// rotation behavior of icons.
  /// IconRotationAlignment or Expression
  /// Default value is IconRotationAlignment.auto
  final dynamic iconRotationAlignment;

  /// Scales the original size of the icon by the provided factor.
  /// The new pixel size of the image will be the original pixel
  /// size multiplied by `icon-size`. 1 is the original size;
  /// 3 triples the size of the image.
  /// Double or Expression
  /// Default is 1.0
  final dynamic iconSize;

  /// Scales the icon to fit around the associated text.
  /// IconTextFit or Expression
  /// Default is IconTextFit.none
  final dynamic iconTextFit;

  /// Size of the additional area added to dimensions determined by
  /// `icon-text-fit`, in clockwise order: top, right, bottom, left.
  /// List<Double> or Expression
  /// Default value is listOf(0.0, 0.0, 0.0, 0.0)
  final dynamic iconTextFitPadding;

  /// If true, the symbols will not cross tile edges to avoid
  /// mutual collisions. Recommended in layers that don't
  /// have enough padding in the vector tile to prevent collisions,
  /// or if it is a point symbol layer placed after a line symbol
  /// layer. When using a client that supports global collision
  /// detection, like Mapbox GL JS version 0.42.0 or greater,
  /// enabling this property is not needed to prevent clipped
  /// labels at tile boundaries.
  /// Boolean or Expression
  /// Default i false
  final dynamic symbolAvoidEdges;

  /// Label placement relative to its geometry.
  /// SymbolPlacement or Expression
  /// Default is SymbolPlacement.point
  final dynamic symbolPlacement;

  /// Sorts features in ascending order based on this value.
  /// Features with lower sort keys are drawn and placed first.
  /// When `icon-allow-overlap` or `text-allow-overlap` is `false`,
  /// features with a lower sort key will have priority during
  /// placement. When `icon-allow-overlap` or `text-allow-overlap`
  /// is set to `true`, features with a higher sort key will overlap
  /// over features with a lower sort key.
  /// Double or Expression
  final dynamic symbolSortKey;

  /// Distance between two symbol anchors.
  /// Double or Expression
  /// Default is 250.0
  final dynamic symbolSpacing;

  /// Determines whether overlapping symbols in the same layer
  /// are rendered in the order that they appear in the data
  /// source or by their y-position relative to the viewport.
  /// To control the order and prioritization of symbols otherwise,
  /// use `symbol-sort-key`.
  /// SymbolZOrder or Expression
  final dynamic symbolZOrder;

  /// If true, the text will be visible even if
  ///  it collides with other previously drawn symbols.
  ///  Boolean and Expression
  ///  Default value is false
  final dynamic textAllowOverlap;

  /// Part of the text placed closest to the anchor.
  /// TextAnchor and Expression
  /// Default value is TextAnchor.center
  final dynamic textAnchor;

  /// Value to use for a text label. If a plain `string` is provided,
  /// it will be treated as a `formatted` with default/inherited
  /// formatting options. SDF images are not supported in formatted text
  /// and will be ignored.
  /// String and Expression
  final dynamic textField;

  /// Font stack to use for displaying text.
  /// List<String> or Expression
  /// Default value is listOf("Open Sans Regular", "Arial Unicode MS Regular")
  final dynamic textFont;

  // If true, other symbols can be visible even if they collide with the text.
  /// Boolean and Expression
  /// Default is false
  final dynamic textIgnorePlacement;

  /// Text justification options.
  /// TextJustify and Expression
  /// Default is TextJustify.enter
  final dynamic textJustify;

  /// If true, the text may be flipped vertically to prevent it
  /// from being rendered upside-down.
  /// Boolean and Expression
  /// Default value is true
  final dynamic textKeepUpright;

  /// Text tracking amount.
  /// Double and Expression
  /// Default value is 0.0
  final dynamic textLetterSpacing;

  /// Text leading value for multi-line text.
  /// Double and Expression
  /// Default value is 1.2
  final dynamic textLineHeight;

  /// Maximum angle change between adjacent characters.
  /// double or Expression
  /// Default value is 45.0
  final dynamic textMaxAngle;

  /// The maximum line width for text wrapping.
  /// double or Expression
  /// Default value is 10.0
  final dynamic textMaxWidth;

  /// Offset distance of text from its anchor.
  ///
  /// Positive values indicate right and down, while negative values
  /// indicate left and up. If used with text-variable-anchor, input values
  /// will be taken as absolute values. Offsets along the x- and y-axis will
  /// be applied automatically based on the anchor position.
  /// List<double> or Expression
  /// Default is listOf(0.0, 0.0)
  final dynamic textOffset;

  /// If true, icons will display without their corresponding text when
  /// the text collides with other symbols and the icon does not.
  /// Boolean or Expression
  /// default value is false
  final dynamic textOptional;

  /// Size of the additional area around the text bounding box used for
  /// detecting symbol collisions.
  /// double or Expression
  /// Default value is 2.0
  final dynamic textPadding;

  /// Orientation of text when map is pitched.
  /// TextPitchAlignment or Expression
  /// Default is TextPitchAlignment.auto
  final dynamic textPitchAlignment;

  /// Radial offset of text, in the direction of the symbol's anchor.
  /// Useful in combination with `text-variable-anchor`, which defaults to
  /// using the two-dimensional `text-offset` if present.
  /// double or Expression
  /// Default is 0.0
  final dynamic textRadialOffset;

  /// Rotates the text clockwise.
  /// double or Expression
  /// Default value is 0.0
  final dynamic textRotate;

  /// In combination with `symbol-placement`, determines the rotation behavior
  /// of the individual glyphs forming the text.
  /// TextRotationAlignment
  /// Default is TextRotationAlignment.auto
  final dynamic textRotationAlignment;

  /// Font size.
  /// double or Expression
  /// Default value is 16.0
  final dynamic textSize;

  /// Specifies how to capitalize text, similar to the CSS
  /// `text-transform` property.
  /// TextTransform
  /// Default is TextTransform.NONE
  final dynamic textTransform;

  /// To increase the chance of placing high-priority labels on the map,
  /// you can provide an array of `text-anchor` locations: the renderer will
  /// attempt to place the label at each location, in order, before moving
  /// onto the next label. Use `text-justify: auto` to choose justification
  /// based on anchor position. To apply an offset, use the `text-radial-offset`
  /// or the two-dimensional `text-offset`.
  /// List<String> or Expression
  final dynamic textVariableAnchor;

  /// The property allows control over a symbol's orientation.
  /// Note that the property values act as a hint, so that a symbol whose
  /// language doesn’t support the provided orientation will be laid out in
  /// its natural orientation. Example: English point symbol will be rendered
  /// horizontally even if array value contains single 'vertical' enum value.
  /// For symbol with point placement, the order of elements in an array define
  /// priority order for the placement of an orientation variant. For symbol
  /// with line placement, the default text writing mode is either
  /// ['horizontal', 'vertical'] or ['vertical', 'horizontal'], the order
  /// doesn't affect the placement.
  /// List<String> or Expression
  final dynamic textWritingMode;

  /// The color of the icon. This can only be used with [SDF icons]
  /// (/help/troubleshooting/using-recolorable-images-in-mapbox-maps/).
  /// String, int or Expression
  ///
  /// Default value is '#000
  final dynamic iconColor;

  /// The color of the icon. This can only be used with [SDF icons]
  /// (/help/troubleshooting/using-recolorable-images-in-mapbox-maps/).
  /// StyleTransition
  final StyleTransition? iconColorTransition;

  /// Fade out the halo towards the outside.
  /// double or Expression
  /// Default value is 0.0
  final dynamic iconHaloBlur;

  /// Fade out the halo towards the outside.
  /// StyleTransition
  final StyleTransition? iconHaloBlurTransition;

  /// The color of the icon's halo. Icon halos can only be used with [SDF icons]
  /// (/help/troubleshooting/using-recolorable-images-in-mapbox-maps/).
  /// String, int or Expression
  final dynamic iconHaloColor;

  /// The color of the icon's halo. Icon halos can only be used with [SDF icons]
  /// (/help/troubleshooting/using-recolorable-images-in-mapbox-maps/).
  /// StyleTransition
  final StyleTransition? iconHaloColorTransition;

  /// Distance of halo to the icon outline.
  /// double and Expression
  /// Default value is 0.0
  final dynamic iconHaloWidth;

  /// Distance of halo to the icon outline.
  /// StyleTransition
  final StyleTransition? iconHaloWidthTransition;

  /// The opacity at which the icon will be drawn.
  /// double and Expression
  /// Default value is 1.0
  final dynamic iconOpacity;

  /// The opacity at which the icon will be drawn.
  /// StyleTransition
  final dynamic iconOpacityTransition;

  /// Distance that the icon's anchor is moved from its original placement.
  /// Positive values indicate right and down, while negative values indicate
  /// left and up.
  /// List<double> or Expression
  /// Default value is listOf(0.0, 0.0)
  final dynamic iconTranslate;

  /// Distance that the icon's anchor is moved from its original placement.
  /// Positive values indicate right and down, while negative values indicate
  /// left and up.
  /// StyleTransition
  final StyleTransition? iconTranslateTransition;

  /// Controls the frame of reference for `icon-translate`.
  /// IconTranslateAnchor
  /// Default is IconTranslateAnchor.map
  final dynamic iconTranslateAnchor;

  /// The color with which the text will be drawn.
  /// String, int or Expression
  /// Default is '#000'
  final dynamic textColor;

  /// The color with which the text will be drawn.
  /// StyleTransition
  final StyleTransition? textColorTransition;

  /// The halo's fadeout distance towards the outside.
  /// double or Expression
  /// Default value is  0.0
  final dynamic textHaloBlur;

  /// The halo's fadeout distance towards the outside.
  /// StyleTransition
  final StyleTransition? textHaloBlurTransition;

  /// The color of the text's halo, which helps it stand out from backgrounds.
  /// String, int or Expression
  /// Default is '#000'
  final dynamic textHaloColor;

  /// The color of the text's halo, which helps it stand out from backgrounds.
  /// StyleTransition
  final StyleTransition? textHaloColorTransition;

  /// Distance of halo to the font outline. Max text halo width is 1/4
  /// of the font-size.
  /// double or Expression
  /// Default value is 0.0
  final dynamic textHaloWidth;

  /// Distance of halo to the font outline. Max text halo width is 1/4
  /// of the font-size.
  /// StyleTransition
  final StyleTransition? textHaloWidthTransition;

  /// The opacity at which the text will be drawn.
  /// double or Expression
  /// Default value is 1.0
  final dynamic textOpacity;

  /// The opacity at which the text will be drawn.
  /// StyleTransition
  final StyleTransition? textOpacityTransition;

  /// Distance that the text's anchor is moved from its original placement.
  /// Positive values indicate right and down, while negative values indicate
  /// left and up.
  /// List<double> or Expression
  /// Default value is listOf(0.0, 0.0)
  final dynamic textTranslate;

  /// Distance that the text's anchor is moved from its original placement.
  /// Positive values indicate right and down, while negative values indicate
  /// left and up.
  /// StyleTransition
  final StyleTransition? textTranslateTransition;

  /// Controls the frame of reference for `text-translate`.
  /// TextTranslateAnchor or Expression
  /// Default value is TextTranslateAnchor.map
  final dynamic textTranslateAnchor;

  /// A source layer is an individual layer of data within a vector source.
  /// A vector source can have multiple source layers
  /// @param sourceLayer value of sourceLayer
  final String? sourceLayer;

  /// Expression to filter
  final dynamic filter;

  /// Whether this layer is displayed.
  /// Boolean - true or false
  final bool? visibility;

  /// The minimum zoom level for the layer. At zoom levels less than the
  /// min zoom, the layer will be hidden.
  /// It takes double value
  /// Range:
  /// minimum: 0
  /// maximum: 24
  final double? minZoom;

  /// The maximum zoom level for the layer. At zoom levels equal to or greater
  /// than the max zoom, the layer will be hidden.
  /// It takes double value
  /// Range:
  /// minimum: 0
  /// maximum: 24
  final double? maxZoom;

  SymbolLayerOptions({
    this.iconAllowOverlap,
    this.iconAnchor,
    this.iconIgnorePlacement,
    this.iconImage,
    this.iconKeepUpright,
    this.iconOffset,
    this.iconOptional,
    this.iconPadding,
    this.iconPitchAlignment,
    this.iconRotate,
    this.iconRotationAlignment,
    this.iconSize,
    this.iconTextFit,
    this.iconTextFitPadding,
    this.symbolAvoidEdges,
    this.symbolPlacement,
    this.symbolSortKey,
    this.symbolSpacing,
    this.symbolZOrder,
    this.textAllowOverlap,
    this.textAnchor,
    this.textField,
    this.textFont,
    this.textIgnorePlacement,
    this.textJustify,
    this.textKeepUpright,
    this.textLetterSpacing,
    this.textLineHeight,
    this.textMaxAngle,
    this.textMaxWidth,
    this.textOffset,
    this.textOptional,
    this.textPadding,
    this.textPitchAlignment,
    this.textRadialOffset,
    this.textRotate,
    this.textRotationAlignment,
    this.textSize,
    this.textTransform,
    this.textVariableAnchor,
    this.textWritingMode,
    this.iconColor,
    this.iconColorTransition,
    this.iconHaloBlur,
    this.iconHaloBlurTransition,
    this.iconHaloColor,
    this.iconHaloColorTransition,
    this.iconHaloWidth,
    this.iconHaloWidthTransition,
    this.iconOpacity,
    this.iconOpacityTransition,
    this.iconTranslate,
    this.iconTranslateTransition,
    this.iconTranslateAnchor,
    this.textColor,
    this.textColorTransition,
    this.textHaloBlur,
    this.textHaloBlurTransition,
    this.textHaloColor,
    this.textHaloColorTransition,
    this.textHaloWidth,
    this.textHaloWidthTransition,
    this.textOpacity,
    this.textOpacityTransition,
    this.textTranslate,
    this.textTranslateTransition,
    this.textTranslateAnchor,
    this.sourceLayer,
    this.filter,
    this.visibility,
    this.minZoom,
    this.maxZoom,
  });

  /// Default Symbol Layer Options
  static SymbolLayerOptions get defaultOptions {
    return SymbolLayerOptions(
        textField: ['get', 'point_count_abbreviated'],
        textSize: 12.0,
        textColor: "#fff");
  }

  /// Method to proceeds the symbol layer option for native
  Map<String, dynamic> toArgs() {
    final json = <String, dynamic>{};

    return json;
  }

  /// Method to convert SymbolPlacement as formatted string
  String _symbolPlacementAsString(SymbolPlacement placement) {
    switch (placement) {
      case SymbolPlacement.lineCenter:
        return "line-center";
      default:
        return placement.name.toLowerCase();
    }
  }

  /// Method to convert SymbolZOrder as formatted string
  String _symbolZOrderAsString(SymbolZOrder zOrder) {
    switch (zOrder) {
      case SymbolZOrder.viewportY:
        return "viewport-y";
      default:
        return zOrder.name.toLowerCase();
    }
  }

  /// Method to convert TextAnchor as formatted string
  String _textAnchorAsString(TextAnchor anchor) {
    switch (anchor) {
      case TextAnchor.topLeft:
        return "top-left";
      case TextAnchor.topRight:
        return "top-right";
      case TextAnchor.bottomLeft:
        return "bottom-left";
      case TextAnchor.bottomRight:
        return "bottom-right";
      default:
        return anchor.name.toLowerCase();
    }
  }

  /// Method to convert IconAnchor as formatted string
  String _iconAnchorAsString(IconAnchor anchor) {
    switch (anchor) {
      case IconAnchor.topLeft:
        return "top-left";
      case IconAnchor.topRight:
        return "top-right";
      case IconAnchor.bottomLeft:
        return "bottom-left";
      case IconAnchor.bottomRight:
        return "bottom-right";
      default:
        return anchor.name.toLowerCase();
    }
  }
}

enum IconAnchor {
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

enum IconPitchAlignment {
  auto,
  map,
  viewport,
}

enum IconRotationAlignment {
  auto,
  map,
  viewport,
}

enum IconTextFit {
  none,
  width,
  height,
  both,
}

enum SymbolPlacement {
  point,
  line,
  lineCenter,
}

enum SymbolZOrder {
  auto,
  viewportY,
  source,
}

enum TextAnchor {
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

enum TextJustify {
  auto,
  left,
  center,
  right,
}

enum TextPitchAlignment {
  auto,
  map,
  viewport,
}

enum TextRotationAlignment {
  auto,
  map,
  viewport,
}

enum TextTransform {
  none,
  uppercase,
  lowercase,
}

enum IconTranslateAnchor {
  map,
  viewport,
}

enum TextTranslateAnchor {
  map,
  viewport,
}
