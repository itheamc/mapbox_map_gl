class ScreenCoordinate {
  final double x;
  final double y;

  ScreenCoordinate(this.x, this.y);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "x": x,
      "y": y,
    };
  }

  factory ScreenCoordinate.from(dynamic json) {
    return ScreenCoordinate(json['x'], json['y']);
  }
}
