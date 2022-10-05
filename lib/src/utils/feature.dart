class Feature {
  final String? type;

  final dynamic bBox;

  final String? id;

  final dynamic geometry;

  final dynamic properties;

  Feature._(
    this.type,
    this.bBox,
    this.id,
    this.geometry,
    this.properties,
  );

  factory Feature.from(dynamic json) {
    return Feature._(
      json['type'],
      json['bbox'],
      json['id'],
      json['geometry'],
      json['properties'],
    );
  }
}
