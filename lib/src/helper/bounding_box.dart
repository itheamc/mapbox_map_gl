import 'point.dart';

/// A class for bounding box (bbox)
class BoundingBox {
  /// [southwest] – represents the bottom left corner of the bounding box
  /// when the camera is pointing due north
  final Point southwest;

  /// [northeast] – represents the top right corner of the bounding box
  /// when the camera is pointing due north
  final Point northeast;

  /// Internal constructor
  BoundingBox._(this.southwest, this.northeast);

  /// Method to create bounding box from the points
  /// [northeast] – represents the top right corner of the bounding box
  /// when the camera is pointing due north
  /// [northeast] – represents the top right corner of the bounding box
  /// when the camera is pointing due north
  static BoundingBox fromPoints(Point southwest, Point northeast) {
    return BoundingBox._(southwest, northeast);
  }

  /// Static method to create BoundingBox from the latLongs
  /// [west] – the left side of the bounding box when
  /// the map is facing due north
  /// [south] – the bottom side of the bounding box when
  /// the map is facing due north
  /// [east] – the right side of the bounding box when
  /// the map is facing due north
  /// [north] – the top side of the bounding box when
  /// the map is facing due north
  static BoundingBox fromLatLongs(
      double west, double south, double east, double north) {
    return BoundingBox._(
        Point.fromLatLng(south, west), Point.fromLatLng(east, north));
  }

  /// Static method to create BoundingBox from the lngLats
  /// [west] – the left side of the bounding box when
  /// the map is facing due north
  /// [south] – the bottom side of the bounding box when
  /// the map is facing due north
  /// [east] – the right side of the bounding box when
  /// the map is facing due north
  /// [north] – the top side of the bounding box when
  /// the map is facing due north
  static BoundingBox fromLngLats(
      double west, double south, double east, double north) {
    return BoundingBox._(
        Point.fromLngLat(west, south), Point.fromLngLat(north, east));
  }

  /// Method to convert Point object to the Map for Args
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "southwest": southwest.toMap(),
      "northeast": northeast.toMap()
    };
  }
}
