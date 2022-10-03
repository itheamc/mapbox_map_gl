import 'package:mapbox_map_gl/src/animation_options.dart';
import 'package:mapbox_map_gl/src/latlng.dart';
import 'package:mapbox_map_gl/src/screen_coordinate.dart';

class CameraPosition {
  final LatLng center;
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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "center": center.toJson(),
      "zoom": zoom ?? 14.0,
      "bearing": bearing,
      "pitch": pitch,
      "anchor": anchor?.toJson(),
      "animationOptions": animationOptions?.toJson()
    };
  }
}
