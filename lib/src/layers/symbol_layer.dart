class SymbolLayer {
  final String layerId;
  final String sourceId;
  final SymbolLayerOptions? options;

  SymbolLayer({
    required this.layerId,
    required this.sourceId,
    this.options,
  });
}

/// SymbolLayerOptions class
/// It contains all the properties for the circle layer
/// e.g.
/// final circleLayerOptions = SymbolLayerOptions(
///                             iconImage: 'my-image-name',
///                             iconSize: 2.0,
///                         );
class SymbolLayerOptions {
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

  // /**
  //  * Maximum angle change between adjacent characters.
  //  *
  //  * @param textMaxAngle value of textMaxAngle
  //  */
  // final dynamic textMaxAngle(textMaxAngle: Double = 45.0);
  //
  // /**
  //  * Maximum angle change between adjacent characters.
  //  *
  //  * @param textMaxAngle value of textMaxAngle as Expression
  //  */
  // final dynamic textMaxAngle(textMaxAngle: Expression);
  //
  // /**
  //  * The maximum line width for text wrapping.
  //  *
  //  * @param textMaxWidth value of textMaxWidth
  //  */
  // final dynamic textMaxWidth(textMaxWidth: Double = 10.0);
  //
  // /**
  //  * The maximum line width for text wrapping.
  //  *
  //  * @param textMaxWidth value of textMaxWidth as Expression
  //  */
  // final dynamic textMaxWidth(textMaxWidth: Expression);
  //
  // /**
  //  * Offset distance of text from its anchor. Positive values indicate right and down, while negative values indicate left and up. If used with text-variable-anchor, input values will be taken as absolute values. Offsets along the x- and y-axis will be applied automatically based on the anchor position.
  //  *
  //  * @param textOffset value of textOffset
  //  */
  // final dynamic textOffset(textOffset: List<Double> = listOf(0.0, 0.0));
  //
  // /**
  //  * Offset distance of text from its anchor. Positive values indicate right and down, while negative values indicate left and up. If used with text-variable-anchor, input values will be taken as absolute values. Offsets along the x- and y-axis will be applied automatically based on the anchor position.
  //  *
  //  * @param textOffset value of textOffset as Expression
  //  */
  // final dynamic textOffset(textOffset: Expression);
  //
  // /**
  //  * If true, icons will display without their corresponding text when the text collides with other symbols and the icon does not.
  //  *
  //  * @param textOptional value of textOptional
  //  */
  // final dynamic textOptional(textOptional: Boolean = false);
  //
  // /**
  //  * If true, icons will display without their corresponding text when the text collides with other symbols and the icon does not.
  //  *
  //  * @param textOptional value of textOptional as Expression
  //  */
  // final dynamic textOptional(textOptional: Expression);
  //
  // /**
  //  * Size of the additional area around the text bounding box used for detecting symbol collisions.
  //  *
  //  * @param textPadding value of textPadding
  //  */
  // final dynamic textPadding(textPadding: Double = 2.0);
  //
  // /**
  //  * Size of the additional area around the text bounding box used for detecting symbol collisions.
  //  *
  //  * @param textPadding value of textPadding as Expression
  //  */
  // final dynamic textPadding(textPadding: Expression);
  //
  // /**
  //  * Orientation of text when map is pitched.
  //  *
  //  * @param textPitchAlignment value of textPitchAlignment
  //  */
  // final dynamic textPitchAlignment(textPitchAlignment: TextPitchAlignment = TextPitchAlignment.AUTO);
  //
  // /**
  //  * Orientation of text when map is pitched.
  //  *
  //  * @param textPitchAlignment value of textPitchAlignment as Expression
  //  */
  // final dynamic textPitchAlignment(textPitchAlignment: Expression);
  //
  // /**
  //  * Radial offset of text, in the direction of the symbol's anchor. Useful in combination with `text-variable-anchor`, which defaults to using the two-dimensional `text-offset` if present.
  //  *
  //  * @param textRadialOffset value of textRadialOffset
  //  */
  // final dynamic textRadialOffset(textRadialOffset: Double = 0.0);
  //
  // /**
  //  * Radial offset of text, in the direction of the symbol's anchor. Useful in combination with `text-variable-anchor`, which defaults to using the two-dimensional `text-offset` if present.
  //  *
  //  * @param textRadialOffset value of textRadialOffset as Expression
  //  */
  // final dynamic textRadialOffset(textRadialOffset: Expression);
  //
  // /**
  //  * Rotates the text clockwise.
  //  *
  //  * @param textRotate value of textRotate
  //  */
  // final dynamic textRotate(textRotate: Double = 0.0);
  //
  // /**
  //  * Rotates the text clockwise.
  //  *
  //  * @param textRotate value of textRotate as Expression
  //  */
  // final dynamic textRotate(textRotate: Expression);
  //
  // /**
  //  * In combination with `symbol-placement`, determines the rotation behavior of the individual glyphs forming the text.
  //  *
  //  * @param textRotationAlignment value of textRotationAlignment
  //  */
  // final dynamic textRotationAlignment(textRotationAlignment: TextRotationAlignment = TextRotationAlignment.AUTO);
  //
  // /**
  //  * In combination with `symbol-placement`, determines the rotation behavior of the individual glyphs forming the text.
  //  *
  //  * @param textRotationAlignment value of textRotationAlignment as Expression
  //  */
  // final dynamic textRotationAlignment(textRotationAlignment: Expression);
  //
  // /**
  //  * Font size.
  //  *
  //  * @param textSize value of textSize
  //  */
  // final dynamic textSize(textSize: Double = 16.0);
  //
  // /**
  //  * Font size.
  //  *
  //  * @param textSize value of textSize as Expression
  //  */
  // final dynamic textSize(textSize: Expression);
  //
  // /**
  //  * Specifies how to capitalize text, similar to the CSS `text-transform` property.
  //  *
  //  * @param textTransform value of textTransform
  //  */
  // final dynamic textTransform(textTransform: TextTransform = TextTransform.NONE);
  //
  // /**
  //  * Specifies how to capitalize text, similar to the CSS `text-transform` property.
  //  *
  //  * @param textTransform value of textTransform as Expression
  //  */
  // final dynamic textTransform(textTransform: Expression);
  //
  // /**
  //  * To increase the chance of placing high-priority labels on the map, you can provide an array of `text-anchor` locations: the renderer will attempt to place the label at each location, in order, before moving onto the next label. Use `text-justify: auto` to choose justification based on anchor position. To apply an offset, use the `text-radial-offset` or the two-dimensional `text-offset`.
  //  *
  //  * @param textVariableAnchor value of textVariableAnchor
  //  */
  // final dynamic textVariableAnchor(textVariableAnchor: List<String>);
  //
  // /**
  //  * To increase the chance of placing high-priority labels on the map, you can provide an array of `text-anchor` locations: the renderer will attempt to place the label at each location, in order, before moving onto the next label. Use `text-justify: auto` to choose justification based on anchor position. To apply an offset, use the `text-radial-offset` or the two-dimensional `text-offset`.
  //  *
  //  * @param textVariableAnchor value of textVariableAnchor as Expression
  //  */
  // final dynamic textVariableAnchor(textVariableAnchor: Expression);
  //
  // /**
  //  * The property allows control over a symbol's orientation. Note that the property values act as a hint, so that a symbol whose language doesn’t support the provided orientation will be laid out in its natural orientation. Example: English point symbol will be rendered horizontally even if array value contains single 'vertical' enum value. For symbol with point placement, the order of elements in an array define priority order for the placement of an orientation variant. For symbol with line placement, the default text writing mode is either ['horizontal', 'vertical'] or ['vertical', 'horizontal'], the order doesn't affect the placement.
  //  *
  //  * @param textWritingMode value of textWritingMode
  //  */
  // final dynamic textWritingMode(textWritingMode: List<String>);
  //
  // /**
  //  * The property allows control over a symbol's orientation. Note that the property values act as a hint, so that a symbol whose language doesn’t support the provided orientation will be laid out in its natural orientation. Example: English point symbol will be rendered horizontally even if array value contains single 'vertical' enum value. For symbol with point placement, the order of elements in an array define priority order for the placement of an orientation variant. For symbol with line placement, the default text writing mode is either ['horizontal', 'vertical'] or ['vertical', 'horizontal'], the order doesn't affect the placement.
  //  *
  //  * @param textWritingMode value of textWritingMode as Expression
  //  */
  // final dynamic textWritingMode(textWritingMode: Expression);
  //
  // /**
  //  * The color of the icon. This can only be used with [SDF icons](/help/troubleshooting/using-recolorable-images-in-mapbox-maps/).
  //  *
  //  * @param iconColor value of iconColor
  //  */
  // final dynamic iconColor(iconColor: String = "#000000");
  //
  // /**
  //  * The color of the icon. This can only be used with [SDF icons](/help/troubleshooting/using-recolorable-images-in-mapbox-maps/).
  //  *
  //  * @param iconColor value of iconColor as Expression
  //  */
  // final dynamic iconColor(iconColor: Expression);
  //
  // /**
  //  * The color of the icon. This can only be used with [SDF icons](/help/troubleshooting/using-recolorable-images-in-mapbox-maps/).
  //  *
  //  * @param iconColor value of iconColor
  //  */
  // final dynamic iconColor(@ColorInt iconColor: Int);
  //
  // /**
  //  * The color of the icon. This can only be used with [SDF icons](/help/troubleshooting/using-recolorable-images-in-mapbox-maps/).
  //  *
  //  * Set the IconColor property transition options
  //  *
  //  * @param options transition options for String
  //  */
  // final dynamic iconColorTransition(options: StyleTransition);
  //
  // /**
  //  * The color of the icon. This can only be used with [SDF icons](/help/troubleshooting/using-recolorable-images-in-mapbox-maps/).
  //  *
  //  * DSL for [iconColorTransition].
  //  */
  // final dynamic iconColorTransition(block: StyleTransition.Builder.() -> Unit);
  //
  // /**
  //  * Fade out the halo towards the outside.
  //  *
  //  * @param iconHaloBlur value of iconHaloBlur
  //  */
  // final dynamic iconHaloBlur(iconHaloBlur: Double = 0.0);
  //
  // /**
  //  * Fade out the halo towards the outside.
  //  *
  //  * @param iconHaloBlur value of iconHaloBlur as Expression
  //  */
  // final dynamic iconHaloBlur(iconHaloBlur: Expression);
  //
  // /**
  //  * Fade out the halo towards the outside.
  //  *
  //  * Set the IconHaloBlur property transition options
  //  *
  //  * @param options transition options for Double
  //  */
  // final dynamic iconHaloBlurTransition(options: StyleTransition);
  //
  // /**
  //  * Fade out the halo towards the outside.
  //  *
  //  * DSL for [iconHaloBlurTransition].
  //  */
  // final dynamic iconHaloBlurTransition(block: StyleTransition.Builder.() -> Unit);
  //
  // /**
  //  * The color of the icon's halo. Icon halos can only be used with [SDF icons](/help/troubleshooting/using-recolorable-images-in-mapbox-maps/).
  //  *
  //  * @param iconHaloColor value of iconHaloColor
  //  */
  // final dynamic iconHaloColor(iconHaloColor: String = "rgba(0, 0, 0, 0)");
  //
  // /**
  //  * The color of the icon's halo. Icon halos can only be used with [SDF icons](/help/troubleshooting/using-recolorable-images-in-mapbox-maps/).
  //  *
  //  * @param iconHaloColor value of iconHaloColor as Expression
  //  */
  // final dynamic iconHaloColor(iconHaloColor: Expression);
  //
  // /**
  //  * The color of the icon's halo. Icon halos can only be used with [SDF icons](/help/troubleshooting/using-recolorable-images-in-mapbox-maps/).
  //  *
  //  * @param iconHaloColor value of iconHaloColor
  //  */
  // final dynamic iconHaloColor(@ColorInt iconHaloColor: Int);
  //
  // /**
  //  * The color of the icon's halo. Icon halos can only be used with [SDF icons](/help/troubleshooting/using-recolorable-images-in-mapbox-maps/).
  //  *
  //  * Set the IconHaloColor property transition options
  //  *
  //  * @param options transition options for String
  //  */
  // final dynamic iconHaloColorTransition(options: StyleTransition);
  //
  // /**
  //  * The color of the icon's halo. Icon halos can only be used with [SDF icons](/help/troubleshooting/using-recolorable-images-in-mapbox-maps/).
  //  *
  //  * DSL for [iconHaloColorTransition].
  //  */
  // final dynamic iconHaloColorTransition(block: StyleTransition.Builder.() -> Unit);
  //
  // /**
  //  * Distance of halo to the icon outline.
  //  *
  //  * @param iconHaloWidth value of iconHaloWidth
  //  */
  // final dynamic iconHaloWidth(iconHaloWidth: Double = 0.0);
  //
  // /**
  //  * Distance of halo to the icon outline.
  //  *
  //  * @param iconHaloWidth value of iconHaloWidth as Expression
  //  */
  // final dynamic iconHaloWidth(iconHaloWidth: Expression);
  //
  // /**
  //  * Distance of halo to the icon outline.
  //  *
  //  * Set the IconHaloWidth property transition options
  //  *
  //  * @param options transition options for Double
  //  */
  // final dynamic iconHaloWidthTransition(options: StyleTransition);
  //
  // /**
  //  * Distance of halo to the icon outline.
  //  *
  //  * DSL for [iconHaloWidthTransition].
  //  */
  // final dynamic iconHaloWidthTransition(block: StyleTransition.Builder.() -> Unit);
  //
  // /**
  //  * The opacity at which the icon will be drawn.
  //  *
  //  * @param iconOpacity value of iconOpacity
  //  */
  // final dynamic iconOpacity(iconOpacity: Double = 1.0);
  //
  // /**
  //  * The opacity at which the icon will be drawn.
  //  *
  //  * @param iconOpacity value of iconOpacity as Expression
  //  */
  // final dynamic iconOpacity(iconOpacity: Expression);
  //
  // /**
  //  * The opacity at which the icon will be drawn.
  //  *
  //  * Set the IconOpacity property transition options
  //  *
  //  * @param options transition options for Double
  //  */
  // final dynamic iconOpacityTransition(options: StyleTransition);
  //
  // /**
  //  * The opacity at which the icon will be drawn.
  //  *
  //  * DSL for [iconOpacityTransition].
  //  */
  // final dynamic iconOpacityTransition(block: StyleTransition.Builder.() -> Unit);
  //
  // /**
  //  * Distance that the icon's anchor is moved from its original placement. Positive values indicate right and down, while negative values indicate left and up.
  //  *
  //  * @param iconTranslate value of iconTranslate
  //  */
  // final dynamic iconTranslate(iconTranslate: List<Double> = listOf(0.0, 0.0));
  //
  // /**
  //  * Distance that the icon's anchor is moved from its original placement. Positive values indicate right and down, while negative values indicate left and up.
  //  *
  //  * @param iconTranslate value of iconTranslate as Expression
  //  */
  // final dynamic iconTranslate(iconTranslate: Expression);
  //
  // /**
  //  * Distance that the icon's anchor is moved from its original placement. Positive values indicate right and down, while negative values indicate left and up.
  //  *
  //  * Set the IconTranslate property transition options
  //  *
  //  * @param options transition options for List<Double>
  //  */
  // final dynamic iconTranslateTransition(options: StyleTransition);
  //
  // /**
  //  * Distance that the icon's anchor is moved from its original placement. Positive values indicate right and down, while negative values indicate left and up.
  //  *
  //  * DSL for [iconTranslateTransition].
  //  */
  // final dynamic iconTranslateTransition(block: StyleTransition.Builder.() -> Unit);
  //
  // /**
  //  * Controls the frame of reference for `icon-translate`.
  //  *
  //  * @param iconTranslateAnchor value of iconTranslateAnchor
  //  */
  // final dynamic iconTranslateAnchor(iconTranslateAnchor: IconTranslateAnchor = IconTranslateAnchor.MAP);
  //
  // /**
  //  * Controls the frame of reference for `icon-translate`.
  //  *
  //  * @param iconTranslateAnchor value of iconTranslateAnchor as Expression
  //  */
  // final dynamic iconTranslateAnchor(iconTranslateAnchor: Expression);
  //
  // /**
  //  * The color with which the text will be drawn.
  //  *
  //  * @param textColor value of textColor
  //  */
  // final dynamic textColor(textColor: String = "#000000");
  //
  // /**
  //  * The color with which the text will be drawn.
  //  *
  //  * @param textColor value of textColor as Expression
  //  */
  // final dynamic textColor(textColor: Expression);
  //
  // /**
  //  * The color with which the text will be drawn.
  //  *
  //  * @param textColor value of textColor
  //  */
  // final dynamic textColor(@ColorInt textColor: Int);
  //
  // /**
  //  * The color with which the text will be drawn.
  //  *
  //  * Set the TextColor property transition options
  //  *
  //  * @param options transition options for String
  //  */
  // final dynamic textColorTransition(options: StyleTransition);
  //
  // /**
  //  * The color with which the text will be drawn.
  //  *
  //  * DSL for [textColorTransition].
  //  */
  // final dynamic textColorTransition(block: StyleTransition.Builder.() -> Unit);
  //
  // /**
  //  * The halo's fadeout distance towards the outside.
  //  *
  //  * @param textHaloBlur value of textHaloBlur
  //  */
  // final dynamic textHaloBlur(textHaloBlur: Double = 0.0);
  //
  // /**
  //  * The halo's fadeout distance towards the outside.
  //  *
  //  * @param textHaloBlur value of textHaloBlur as Expression
  //  */
  // final dynamic textHaloBlur(textHaloBlur: Expression);
  //
  // /**
  //  * The halo's fadeout distance towards the outside.
  //  *
  //  * Set the TextHaloBlur property transition options
  //  *
  //  * @param options transition options for Double
  //  */
  // final dynamic textHaloBlurTransition(options: StyleTransition);
  //
  // /**
  //  * The halo's fadeout distance towards the outside.
  //  *
  //  * DSL for [textHaloBlurTransition].
  //  */
  // final dynamic textHaloBlurTransition(block: StyleTransition.Builder.() -> Unit);
  //
  // /**
  //  * The color of the text's halo, which helps it stand out from backgrounds.
  //  *
  //  * @param textHaloColor value of textHaloColor
  //  */
  // final dynamic textHaloColor(textHaloColor: String = "rgba(0, 0, 0, 0)");
  //
  // /**
  //  * The color of the text's halo, which helps it stand out from backgrounds.
  //  *
  //  * @param textHaloColor value of textHaloColor as Expression
  //  */
  // final dynamic textHaloColor(textHaloColor: Expression);
  //
  // /**
  //  * The color of the text's halo, which helps it stand out from backgrounds.
  //  *
  //  * @param textHaloColor value of textHaloColor
  //  */
  // final dynamic textHaloColor(@ColorInt textHaloColor: Int);
  //
  // /**
  //  * The color of the text's halo, which helps it stand out from backgrounds.
  //  *
  //  * Set the TextHaloColor property transition options
  //  *
  //  * @param options transition options for String
  //  */
  // final dynamic textHaloColorTransition(options: StyleTransition);
  //
  // /**
  //  * The color of the text's halo, which helps it stand out from backgrounds.
  //  *
  //  * DSL for [textHaloColorTransition].
  //  */
  // final dynamic textHaloColorTransition(block: StyleTransition.Builder.() -> Unit);
  //
  // /**
  //  * Distance of halo to the font outline. Max text halo width is 1/4 of the font-size.
  //  *
  //  * @param textHaloWidth value of textHaloWidth
  //  */
  // final dynamic textHaloWidth(textHaloWidth: Double = 0.0);
  //
  // /**
  //  * Distance of halo to the font outline. Max text halo width is 1/4 of the font-size.
  //  *
  //  * @param textHaloWidth value of textHaloWidth as Expression
  //  */
  // final dynamic textHaloWidth(textHaloWidth: Expression);
  //
  // /**
  //  * Distance of halo to the font outline. Max text halo width is 1/4 of the font-size.
  //  *
  //  * Set the TextHaloWidth property transition options
  //  *
  //  * @param options transition options for Double
  //  */
  // final dynamic textHaloWidthTransition(options: StyleTransition);
  //
  // /**
  //  * Distance of halo to the font outline. Max text halo width is 1/4 of the font-size.
  //  *
  //  * DSL for [textHaloWidthTransition].
  //  */
  // final dynamic textHaloWidthTransition(block: StyleTransition.Builder.() -> Unit);
  //
  // /**
  //  * The opacity at which the text will be drawn.
  //  *
  //  * @param textOpacity value of textOpacity
  //  */
  // final dynamic textOpacity(textOpacity: Double = 1.0);
  //
  // /**
  //  * The opacity at which the text will be drawn.
  //  *
  //  * @param textOpacity value of textOpacity as Expression
  //  */
  // final dynamic textOpacity(textOpacity: Expression);
  //
  // /**
  //  * The opacity at which the text will be drawn.
  //  *
  //  * Set the TextOpacity property transition options
  //  *
  //  * @param options transition options for Double
  //  */
  // final dynamic textOpacityTransition(options: StyleTransition);
  //
  // /**
  //  * The opacity at which the text will be drawn.
  //  *
  //  * DSL for [textOpacityTransition].
  //  */
  // final dynamic textOpacityTransition(block: StyleTransition.Builder.() -> Unit);
  //
  // /**
  //  * Distance that the text's anchor is moved from its original placement. Positive values indicate right and down, while negative values indicate left and up.
  //  *
  //  * @param textTranslate value of textTranslate
  //  */
  // final dynamic textTranslate(textTranslate: List<Double> = listOf(0.0, 0.0));
  //
  // /**
  //  * Distance that the text's anchor is moved from its original placement. Positive values indicate right and down, while negative values indicate left and up.
  //  *
  //  * @param textTranslate value of textTranslate as Expression
  //  */
  // final dynamic textTranslate(textTranslate: Expression);
  //
  // /**
  //  * Distance that the text's anchor is moved from its original placement. Positive values indicate right and down, while negative values indicate left and up.
  //  *
  //  * Set the TextTranslate property transition options
  //  *
  //  * @param options transition options for List<Double>
  //  */
  // final dynamic textTranslateTransition(options: StyleTransition);
  //
  // /**
  //  * Distance that the text's anchor is moved from its original placement. Positive values indicate right and down, while negative values indicate left and up.
  //  *
  //  * DSL for [textTranslateTransition].
  //  */
  // final dynamic textTranslateTransition(block: StyleTransition.Builder.() -> Unit);
  //
  // /**
  //  * Controls the frame of reference for `text-translate`.
  //  *
  //  * @param textTranslateAnchor value of textTranslateAnchor
  //  */
  // final dynamic textTranslateAnchor(textTranslateAnchor: TextTranslateAnchor = TextTranslateAnchor.MAP);
  //
  // /**
  //  * Controls the frame of reference for `text-translate`.
  //  *
  //  * @param textTranslateAnchor value of textTranslateAnchor as Expression
  //  */
  // final dynamic textTranslateAnchor(textTranslateAnchor: Expression);

  SymbolLayerOptions({
    this.sourceLayer,
    this.filter,
    this.visibility,
    this.minZoom,
    this.maxZoom,
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
  });

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

enum IconPitchAlignment { auto, map, viewport }

enum IconRotationAlignment { auto, map, viewport }

enum IconTextFit { none, width, height, both }

enum SymbolPlacement { point, line, lineCenter }

enum SymbolZOrder { auto, viewportY, source }

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
