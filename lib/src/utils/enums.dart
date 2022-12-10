/// Enum for map memory budget
enum MapMemoryBudgetIn {
  megaBytes,
  tiles,
}

/// Satisfies embedding platforms that requires the viewport coordinate systems
/// to be set according to its standards.
enum ViewportMode {
  /// Default viewport
  defaultMode,

  /// Viewport flipped on the y-axis.
  flippedYMode
}

/// LineCap
/// BUTT, ROUND and SQUARE
enum LineCap {
  butt,
  round,
  square,
}

/// LineJoin
/// ROUND, BEVEl and MITER
enum LineJoin {
  round,
  bevel,
  miter,
}

/// LineTranslateAnchor
/// MAP and VIEWPORT
enum LineTranslateAnchor {
  map,
  viewport,
}

/// Icon Anchor
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

/// IconPitchAlignment
enum IconPitchAlignment {
  auto,
  map,
  viewport,
}

/// IconRotationAlignment
enum IconRotationAlignment {
  auto,
  map,
  viewport,
}

/// IconTextFit
enum IconTextFit {
  none,
  width,
  height,
  both,
}

/// SymbolPlacement
enum SymbolPlacement {
  point,
  line,
  lineCenter,
}

/// SymbolZOrder
enum SymbolZOrder {
  auto,
  viewportY,
  source,
}

/// TextAnchor
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

/// TextJustify
enum TextJustify {
  auto,
  left,
  center,
  right,
}

/// TextPitchAlignment
enum TextPitchAlignment {
  auto,
  map,
  viewport,
}

/// TextRotationAlignment
enum TextRotationAlignment {
  auto,
  map,
  viewport,
}

/// TextTransform
enum TextTransform {
  none,
  uppercase,
  lowercase,
}

/// IconTranslateAnchor
enum IconTranslateAnchor {
  map,
  viewport,
}

/// TextTranslateAnchor
enum TextTranslateAnchor {
  map,
  viewport,
}

/// FillTranslateAnchor
/// MAP and VIEWPORT
enum FillTranslateAnchor {
  map,
  viewport,
}

enum SkyType {
  /// Renders the sky with a gradient that can be configured with
  /// {@link SKY_GRADIENT_RADIUS} and {@link SKY_GRADIENT}.
  gradient,

  /// Renders the sky with a simulated atmospheric scattering algorithm,
  /// the sun direction can be attached to the light position or explicitly
  /// set through {@link SKY_ATMOSPHERE_SUN}.
  atmosphere
}

/// RasterResampling
enum RasterResampling {
  linear,
  nearest,
}

/// HillShadeIlluminationAnchor
enum HillShadeIlluminationAnchor {
  /// The hill shade illumination is relative to the north direction.
  map,

  /// The hill shade illumination is relative to the top of the viewport.
  viewport,
}

/// FillExtrusionTranslateAnchor
enum FillExtrusionTranslateAnchor {
  /// The fill extrusion is translated relative to the map.
  map,

  /// The fill extrusion is translated relative to the viewport.
  viewport,
}

/// CircleTranslateAnchor
/// MAP and VIEWPORT
enum CircleTranslateAnchor {
  map,
  viewport,
}

/// CirclePitchScale
/// MAP and VIEWPORT
enum CirclePitchScale {
  map,
  viewport,
}

/// CirclePitchScale
/// MAP and VIEWPORT
enum CirclePitchAlignment {
  map,
  viewport,
}

/// Annotation Type
enum AnnotationType {
  circle,
  point,
  polygon,
  polyline,
  unknown,
}

/// DragEvent
enum DragEvent {
  started,
  dragging,
  finished,
  unknown,
}
