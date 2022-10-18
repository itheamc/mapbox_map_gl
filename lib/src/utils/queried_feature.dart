import 'dart:convert';

import 'feature.dart';

/// QueriedFeature
/// Added by Amit Chaudhary, 2022/10/17
class QueriedFeature {
  /// Source id for a queried feature.
  final String source;

  /// Source layer id for a queried feature. May be null if source does not
  /// support layers, e.g., 'geoJson' source, or when data provided by the
  /// source is not layered.
  final String? sourceLayer;

  /// Feature returned by the query.
  final Feature feature;

  /// Feature state for a queried feature. Type of the value is an Object.
  final dynamic state;

  /// Constructor
  QueriedFeature({
    required this.source,
    this.sourceLayer,
    required this.feature,
    this.state,
  });

  /// Method to convert args from queried feature obj
  factory QueriedFeature.fromArgs(Map<String, dynamic> args) {
    return QueriedFeature(
      source: args['source'],
      sourceLayer: args['sourceLayer'],
      feature: Feature.fromArgs(args['feature']),
      state: jsonDecode(args['state']),
    );
  }
}
