import 'package:mapbox_map_gl/src/utils/screen_box.dart';

import 'screen_coordinate.dart';

/// RenderedQueryOptions
/// Added by Amit Chaudhary, 2022/10/18
/// Geometry for querying rendered features.
class RenderedQueryGeometry {
  /// Generic value
  /// [value] - It might me:
  /// - ScreenBox
  /// - ScreenCoordinate
  /// - and List<ScreenCoordinate>
  final dynamic value;

  /// Type of value
  final String _type;

  /// Private Constructor
  RenderedQueryGeometry._(this.value, this._type);

  /// Static method to create RenderedQueryGeometry object from ScreenBox
  static RenderedQueryGeometry fromScreenBox(ScreenBox screenBox) {
    return RenderedQueryGeometry._(screenBox, "ScreenBox");
  }

  /// Static method to create RenderedQueryGeometry object from ScreenCoordinate
  static RenderedQueryGeometry fromScreenCoordinate(
      ScreenCoordinate screenCoordinate) {
    return RenderedQueryGeometry._(screenCoordinate, "ScreenCoordinate");
  }

  /// Static method to create RenderedQueryGeometry object from list of
  /// ScreenCoordinate
  static RenderedQueryGeometry fromScreenCoordinates(
      List<ScreenCoordinate> screenCoordinates) {
    return RenderedQueryGeometry._(screenCoordinates, "ScreenCoordinates");
  }

  /// Method to convert the RenderedQueryGeometry to Map
  Map<String, dynamic> toMap() {
    final args = <String, dynamic>{};

    args['type'] = _type;

    if (value is ScreenBox) {
      args['value'] = (value as ScreenBox).toMap();
    } else if (value is ScreenCoordinate) {
      args['value'] = (value as ScreenCoordinate).toMap();
    } else {
      args['value'] =
          (value as List<ScreenCoordinate>).map((e) => e.toMap()).toList();
    }

    return args;
  }
}
