import 'bounding_box.dart';
import 'feature.dart';

/// FeatureCollection Class
/// Created by Amit Chaudhary, 2022/10/6
class FeatureCollection {
  static const _type = "FeatureCollection";

  /// [type] FeatureCollection Type i.e. 'FeatureCollection'
  final String type;

  /// [features] List of Feature
  final List<Feature> features;

  /// [bbox] Bonding box
  final BoundingBox? bbox;

  /// A private constructor
  FeatureCollection._(this.type, this.features, [this.bbox]);

  /// Factory method to create feature collection
  factory FeatureCollection.fromFeatures({
    required List<Feature> features,
    BoundingBox? bbox,
  }) {
    return FeatureCollection._(_type, features, bbox);
  }

  /// Method to convert FeatureCollection to map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "type": type,
      "features": features.map((e) => e.toMap()).toList(),
      "bbox": bbox?.toMap()
    };
  }
}
