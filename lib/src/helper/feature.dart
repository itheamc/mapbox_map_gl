import 'dart:convert';

import 'package:mapbox_map_gl/src/helper/bounding_box.dart';

/// Feature Class
class Feature {
  /// [type] It represents the feature type
  final String? type;

  /// [bbox] It is the bounding box object
  final BoundingBox? bbox;

  /// [id] It represents the feature id
  final String? id;

  /// [geometry] Geometry of the feature
  final dynamic geometry;

  /// [properties] Properties of the feature
  final dynamic properties;

  /// Internal or Private Constructor
  Feature._(
    this.type,
    this.bbox,
    this.id,
    this.geometry,
    this.properties,
  );

  /// Factory method to convert args passes prom native platform
  /// to Feature object
  /// [args] arguments send from the native platform
  factory Feature.fromArgs(dynamic args) {
    final decodedArgs = jsonDecode(args);

    return Feature._(
      decodedArgs['type'],
      decodedArgs['bbox'],
      decodedArgs['id'],
      decodedArgs['geometry'],
      decodedArgs['properties'],
    );
  }

  /// Method to convert Feature object to map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": type,
      "type": type,
      "geometry": geometry,
      "properties": properties,
      "bbox": bbox?.toMap()
    };
  }
}
