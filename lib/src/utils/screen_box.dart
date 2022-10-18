import 'screen_coordinate.dart';

/// ScreenBox
/// Added by Amit Chaudhary, 2022/10/18
/// Describes the coordinate box on the screen, measured in `platform pixels`
/// from top to bottom and from left to right.
class ScreenBox {
  /// The screen coordinate close to the top left corner of the screen.
  final ScreenCoordinate min;

  /// The screen coordinate close to the bottom right corner of the screen.
  final ScreenCoordinate max;

  /// Constructor
  ScreenBox(this.min, this.max);

  /// Method to convert ScreenBox object to map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "min": min.toMap(),
      "max": max.toMap(),
    };
  }

  /// Method to convert the screen box object to string
  @override
  String toString() {
    return "min(x: ${min.x}, y: ${min.y}), max(x: ${max.x}, y: ${max.y})";
  }

  @override
  int get hashCode {
    return Object.hash(min, max);
  }

  @override
  bool operator ==(Object other) {
    if (runtimeType != other.runtimeType) return false;

    return min.x == (other as ScreenBox).min.x &&
        min.y == other.min.y &&
        max.x == other.max.x &&
        max.y == other.max.y;
  }
}
