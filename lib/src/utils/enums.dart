/// Enum for map memory budget
enum MapMemoryBudgetIn { megaBytes, tiles }

/// Satisfies embedding platforms that requires the viewport coordinate systems
/// to be set according to its standards.
enum ViewportMode {
  /// Default viewport
  defaultMode,

  /// Viewport flipped on the y-axis.
  flippedYMode
}
