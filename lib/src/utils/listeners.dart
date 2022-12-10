import 'enums.dart';

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

/// Type definition for onRenderFrameStarted listener
typedef OnRenderFrameStartedListener = void Function();

/// Type definition for onRenderFrameFinished listener
typedef OnRenderFrameFinishedListener = void Function();

/// Type definition for onAnnotationClick listener
/// int -> id
/// AnnotationType -> type
/// Map<String, dynamic> -> data
typedef OnAnnotationClickListener = void Function(
    int id, AnnotationType type, Map<String, dynamic>? data);

/// Type definition for onAnnotationLongClick listener
/// int -> id
/// AnnotationType -> type
/// Map<String, dynamic>? -> data
typedef OnAnnotationLongClickListener = void Function(
    int id, AnnotationType type, Map<String, dynamic>? data);

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

  /// Method to set onRenderFrameStarted listener
  void setOnRenderFrameStartedListener(
      OnRenderFrameStartedListener onRenderFrameStartedListener);

  /// Method to set onRenderFrameFinished listener
  void setOnRenderFrameFinishedListener(
      OnRenderFrameFinishedListener onRenderFrameFinishedListener);

  /// Method to set onAnnotationClickListener listener
  void setOnAnnotationClickListener(
      OnAnnotationClickListener onAnnotationClickListener);

  /// Method to set onAnnotationLongClickListener listener
  void setOnAnnotationLongClickListener(
      OnAnnotationLongClickListener onAnnotationLongClickListener);

  /// Method to add listeners
  /// [onMapIdleListener] - Listener for onMapIdle
  /// [onCameraChangeListener] - Listener for onCameraChange
  /// [onSourceAddedListener] - Listener for onSourceAdded
  /// [onSourceDataLoadedListener] - Listener for onSourceDataLoaded
  /// [onSourceRemovedListener] - Listener for onSourceRemoved
  /// [onRenderFrameStartedListener] - Listener for onRenderFrameStarted
  /// [onRenderFrameFinishedListener] - Listener for onRenderFrameFinished
  /// [onAnnotationClickListener] - Listener for onAnnotationClickListener
  /// [onAnnotationLongClickListener] - Listener for onAnnotationLongClickListener
  void addListeners({
    OnMapIdleListener? onMapIdleListener,
    OnCameraChangeListener? onCameraChangeListener,
    OnSourceAddedListener? onSourceAddedListener,
    OnSourceDataLoadedListener? onSourceDataLoadedListener,
    OnSourceRemovedListener? onSourceRemovedListener,
    OnRenderFrameStartedListener? onRenderFrameStartedListener,
    OnRenderFrameFinishedListener? onRenderFrameFinishedListener,
    OnAnnotationClickListener? onAnnotationClickListener,
    OnAnnotationLongClickListener? onAnnotationLongClickListener,
  });

  /// Method to remove listeners
  void removeListeners();
}
