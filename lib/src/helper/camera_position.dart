import 'animation_options.dart';
import 'point.dart';
import 'screen_coordinate.dart';

/// CameraPosition Class
/// It will be mainly used for animating camera to the specific coordinate
class CameraPosition {
  final Point center;
  final double? zoom;
  final double? bearing;
  final double? pitch;
  final ScreenCoordinate? anchor;
  final AnimationOptions? animationOptions;

  CameraPosition({
    required this.center,
    this.zoom,
    this.bearing,
    this.pitch,
    this.anchor,
    this.animationOptions,
  });

  /// Method to convert CameraPosition object to Map
  /// It is basically for passing to the native platform
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "center": center.toMap(),
      "zoom": zoom ?? 14.0,
      "bearing": bearing,
      "pitch": pitch,
      "anchor": anchor?.toMap(),
      "animationOptions": animationOptions?.toMap()
    };
  }
}
