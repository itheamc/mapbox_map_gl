import 'dart:convert';
import 'bounding_box.dart';

/// A Point Class
class Point {
  static const _type = "Point";

  /// [type] Point Type i.e. 'Point'
  final String type;

  /// [coordinates] List of latitude and longitude
  /// [coordinates.first] -> Longitude
  /// [coordinates.last] -> latitude
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
  /// [longitude] - a double value between -180 to 180 representing the
  /// x position of this point
  /// [latitude] - a double value between -90 to 90 representing the
  /// y position of this point
  static Point fromLngLat(double longitude, double latitude) {
    return Point._(_type, <double>[longitude, latitude]);
  }

  /// Method to create point from the latitude, longitude and bbox
  /// [latitude] - a double value between -90 to 90 representing the
  /// y position of this point
  /// [longitude] - a double value between -180 to 180 representing the
  /// x position of this point
  /// [bbox] – optionally include a bbox definition as a double array
  static Point fromLatLngBbox(
      double latitude, double longitude, BoundingBox? bbox) {
    return Point._(_type, <double>[longitude, latitude], bbox);
  }

  /// Method to create point from the longitude, latitude and bbox
  /// [longitude] - a double value between -180 to 180 representing the
  /// x position of this point
  /// [latitude] - a double value between -90 to 90 representing the
  /// y position of this point
  /// [bbox] – optionally include a bbox definition as a double array
  static Point fromLngLatBbox(
      double longitude, double latitude, BoundingBox? bbox) {
    return Point._(_type, <double>[longitude, latitude], bbox);
  }

  /// Method to convert Point object to the Map for Args
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "coordinates": coordinates,
      "bbox": bbox?.toMap(),
    };
  }

  /// Method to convert args get from native platform
  /// to Point object
  /// [args] String args
  factory Point.fromArgs(dynamic args) {
    final decodedArgs = jsonDecode(args);
    final argsType = decodedArgs["type"];
    final argsCoordinates = decodedArgs["coordinates"];

    // print("[CLICKED] ---> $argsType, ${(argsCoordinates as List<double>).runtimeType}");

    return Point._(
        argsType ?? _type,
        argsCoordinates is List
            ? argsCoordinates.map((e) => e as double).toList()
            : <double>[0.0, 0.0],
        null);
  }
}
