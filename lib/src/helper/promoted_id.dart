/// PromotedId class
/// It holds a property type to promote a specific feature for feature state API.
class PromotedId {
  /// [propertyName] -feature property name.
  final String propertyName;

  /// [sourceId] - source layer id of the feature, either source GeoJsonSource or VectorSource.
  final String? sourceId;

  /// Constructor for PromotedId
  /// [propertyName] -feature property name.
  /// [sourceId] - source layer id of the feature,
  /// either source GeoJsonSource or VectorSource.
  PromotedId({
    required this.propertyName,
    this.sourceId,
  });

  /// Method to convert PromotedId to map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "propertyName": propertyName,
      "sourceId": sourceId,
    };
  }
}