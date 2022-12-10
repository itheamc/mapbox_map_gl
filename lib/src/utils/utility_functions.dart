import 'enums.dart';

/// StringUtility class
/// Created by Amit Chaudhary, 2022/12/10
class StringUtility {
  static AnnotationType annotationTypeFromString(String value) {
    switch (value) {
      case "PolygonAnnotation":
        return AnnotationType.polygon;
      case "PolylineAnnotation":
        return AnnotationType.polyline;
      case "PointAnnotation":
        return AnnotationType.point;
      case "CircleAnnotation":
        return AnnotationType.circle;
      default:
        return AnnotationType.unknown;
    }
  }
}
