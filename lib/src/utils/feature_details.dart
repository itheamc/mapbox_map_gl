import 'feature.dart';
import 'point.dart';
import 'screen_coordinate.dart';

/// FeatureDetails
/// Added by Amit Chaudhary, 2022/10/20
class FeatureDetails {
  /// Feature object consisting properties, geometry of a clicked feature
  final Feature feature;

  /// It is an object consisting
  /// latitude and
  /// longitude of the clicked feature
  final Point point;

  /// Screens x and y coordinate of clicked feature
  final ScreenCoordinate screenCoordinate;

  /// Source of the clicked feature
  final String? source;

  /// Source layer of the clicked feature
  /// e.g. default, buildings, routes, roads etc.
  final String? sourceLayer;

  /// Constructor
  FeatureDetails({
    required this.feature,
    required this.point,
    required this.screenCoordinate,
    this.source,
    this.sourceLayer,
  });

  /// Factory method to convert dynamic data to FeatureDetails obj
  factory FeatureDetails.fromArgs(dynamic args) {
    final point = Point.fromArgs(args['point']);
    final coordinate = ScreenCoordinate.fromArgs(args['screen_coordinate']);
    final feature = Feature.fromArgs(args['feature']);
    final source = args['source'];
    final sourceLayer = args['source_layer'];

    return FeatureDetails(
      feature: feature,
      point: point,
      screenCoordinate: coordinate,
      source: source,
      sourceLayer: sourceLayer,
    );
  }
}
