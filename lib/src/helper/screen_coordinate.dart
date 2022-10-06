/// ScreenCoordinate class
/// [x] point x
/// [y] point
class ScreenCoordinate {
  final double x;
  final double y;

  /// Constructor to construct Screen coordinate object
  ScreenCoordinate(this.x, this.y);

  /// Method to convert screen coordinate object to map
  /// i.e. to Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "x": x,
      "y": y,
    };
  }

  /// Method to convert args get from native platform
  /// to screen coordinate object
  /// [args] Map<String, dynamic> args
  factory ScreenCoordinate.fromArgs(dynamic args) {
    return ScreenCoordinate(args['x'], args['y']);
  }
}
