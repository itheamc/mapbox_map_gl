/// ScreenCoordinate class
/// [x] point x
/// [y] point
class ScreenCoordinate {
  final double x;
  final double y;

  /// Constructor to construct Screen coordinate object
  ScreenCoordinate(this.x, this.y);

  /// Method to convert screen coordinate object to json form
  /// i.e. to Map<String, dynamic>
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "x": x,
      "y": y,
    };
  }

  /// Method to convert json data to screen coordinate object
  /// [json] Map<String, dynamic> json
  factory ScreenCoordinate.from(dynamic json) {
    return ScreenCoordinate(json['x'], json['y']);
  }
}
