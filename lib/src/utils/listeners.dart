/// Type definition for onMapIdle listener
typedef OnMapIdleListener = void Function();

/// Type definition for onCameraChange listener
typedef OnCameraChangeListener = void Function();

/// Type definition for onSourceAdded listener
/// [sourceId] - Id of the added source
typedef OnSourceAddedListener = void Function(String sourceId);

/// Type definition for onSourceDataLoaded listener
/// [args] - It contains:
/// - id
/// - type and
/// - loaded
typedef OnSourceDataLoadedListener = void Function(Map<String, dynamic> args);

/// Type definition for onSourceRemoved listener
/// [sourceId] - Id of the removed source
typedef OnSourceRemovedListener = void Function(String sourceId);

/// Listeners Mixin
/// Added By Amit Chaudhary, 2022/10/15
mixin Listeners {
  /// Method to set onMapIdle listener
  void setOnMapIdleListener(OnMapIdleListener onMapIdleListener);

  /// Method to set OnCameraChange listener
  void setOnCameraChangeListener(OnCameraChangeListener onCameraChangeListener);

  /// Method to set onSourceAdded listener
  void setOnSourceAddedListener(OnSourceAddedListener onSourceAddedListener);

  /// Method to set onSourceDataLoaded listener
  void setOnSourceDataLoadedListener(
      OnSourceDataLoadedListener onSourceDataLoadedListener);

  /// Method to set onSourceRemoved listener
  void setOnSourceRemovedListener(
      OnSourceRemovedListener onSourceRemovedListener);

  /// Method to add listeners
  /// [onMapIdleListener] - Listener for onMapIdle
  /// [onCameraChangeListener] - Listener for onCameraChange
  /// [onSourceAddedListener] - Listener for onSourceAdded
  /// [onSourceDataLoadedListener] - Listener for onSourceDataLoaded
  /// [onSourceRemovedListener] - Listener for onSourceRemoved
  void addListeners({
    OnMapIdleListener? onMapIdleListener,
    OnCameraChangeListener? onCameraChangeListener,
    OnSourceAddedListener? onSourceAddedListener,
    OnSourceDataLoadedListener? onSourceDataLoadedListener,
    OnSourceRemovedListener? onSourceRemovedListener,
  });

  /// Method to remove listeners
  void removeListeners();
}
