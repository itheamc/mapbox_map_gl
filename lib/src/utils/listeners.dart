import 'point.dart';
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

/// Type definition for OnCircleAnnotationDrag listener
/// int -> id
/// AnnotationType -> type
/// Point -> point
/// Map<String, dynamic>? -> data
/// DragEvent -> event
typedef OnCircleAnnotationDragListener = void Function(
  int id,
  AnnotationType type,
  Point point,
  Map<String, dynamic>? data,
  DragEvent event,
);

/// Type definition for OnPointAnnotationDrag listener
/// int -> id
/// AnnotationType -> type
/// Point -> point
/// Map<String, dynamic>? -> data
/// DragEvent -> event
typedef OnPointAnnotationDragListener = void Function(
  int id,
  AnnotationType type,
  Point point,
  Map<String, dynamic>? data,
  DragEvent event,
);

/// Type definition for OnPolylineAnnotationDrag listener
/// int -> id
/// AnnotationType -> type
/// List<Point> -> points
/// Map<String, dynamic>? -> data
/// DragEvent -> event
typedef OnPolylineAnnotationDragListener = void Function(
  int id,
  AnnotationType type,
  List<Point> points,
  Map<String, dynamic>? data,
  DragEvent event,
);

/// Type definition for OnPolygonAnnotationDrag listener
/// int -> id
/// AnnotationType -> type
/// List<List<Point>> -> points
/// Map<String, dynamic>? -> data
/// DragEvent -> event
typedef OnPolygonAnnotationDragListener = void Function(
  int id,
  AnnotationType type,
  List<List<Point>> points,
  Map<String, dynamic>? data,
  DragEvent event,
);

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

  /// Method to set onAnnotationClick listener
  void setOnAnnotationClickListener(
      OnAnnotationClickListener onAnnotationClickListener);

  /// Method to set onAnnotationLongClick listener
  void setOnAnnotationLongClickListener(
      OnAnnotationLongClickListener onAnnotationLongClickListener);

  /// Method to set onCircleAnnotationDrag listener
  void setOnCircleAnnotationDragListener(
      OnCircleAnnotationDragListener onCircleAnnotationDragListener);

  /// Method to set onPointAnnotationDrag listener
  void setOnPointAnnotationDragListener(
      OnPointAnnotationDragListener onPointAnnotationDragListener);

  /// Method to set onPolylineAnnotationDrag listener
  void setOnPolylineAnnotationDragListener(
      OnPolylineAnnotationDragListener onPolylineAnnotationDragListener);

  /// Method to set onPolygonAnnotationDrag listener
  void setOnPolygonAnnotationDragListener(
      OnPolygonAnnotationDragListener onPolygonAnnotationDragListener);

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
    OnCircleAnnotationDragListener? onCircleAnnotationDragListener,
    OnPointAnnotationDragListener? onPointAnnotationDragListener,
    OnPolylineAnnotationDragListener? onPolylineAnnotationDragListener,
    OnPolygonAnnotationDragListener? onPolygonAnnotationDragListener,
  });

  /// Method to remove listeners
  void removeListeners();
}
