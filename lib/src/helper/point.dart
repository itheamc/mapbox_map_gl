import 'bounding_box.dart';

/// A Point Class
class Point {
  static const _type = "Point";

  /// [type] Point Type i.e. 'Point'
  final String type;

  /// [coordinates] List of latitude and longitude
  final List<double> coordinates;

  /// [bbox] Bonding box
  final BoundingBox? bbox;

  /// A private constructor
  Point._(this.type, this.coordinates, [this.bbox]);

  /// Method to create point from the latitude and longitude
  /// [latitude] - a double value between -90 to 90 representing the
  /// y position of this point
  /// [longitude] - a double value between -180 to 180 representing the
  /// x position of this point
  static Point fromLatLng(double latitude, double longitude) {
    return Point._(_type, <double>[longitude, latitude]);
  }

  /// Method to create point from the latitude and longitude
  /// [latitude] - a double value between -90 to 90 representing the
  /// y position of this point
  /// [longitude] - a double value between -180 to 180 representing the
  /// x position of this point
  /// [bbox] – optionally include a bbox definition as a double array
  static Point fromLatLngNBbox(
      double latitude, double longitude, BoundingBox? bbox) {
    return Point._(_type, <double>[longitude, latitude], bbox);
  }
}
