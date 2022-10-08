import 'dart:convert';

import 'package:mapbox_map_gl/src/helper/feature.dart';
import 'package:mapbox_map_gl/src/helper/feature_collection.dart';
import 'package:mapbox_map_gl/src/helper/promoted_id.dart';
import 'package:mapbox_map_gl/src/sources/source.dart';
import 'package:mapbox_map_gl/src/sources/source_properties.dart';

/// GeoJsonSource Class
/// Created by Amit Chaudhary, 2022/10/6
class GeoJsonSource extends Source<GeoJsonSourceProperties> {
  /// A URL to a GeoJSON file, or inline GeoJSON.
  final String? data;

  /// Constructor
  GeoJsonSource({
    required super.sourceId,
    super.url,
    this.data,
    super.sourceProperties,
  }) : assert(data != null || url != null,
            "Please provide geoJson data or url for geoJson data");

  /// Method to convert GeoJsonSource object to map
  @override
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    args["sourceId"] = sourceId;

    if (data != null) {
      args["data"] = data;
    }

    if (url != null) {
      args["url"] = url;
    }

    args['sourceProperties'] =
        (sourceProperties ?? GeoJsonSourceProperties.defaultProperties).toMap();

    return args.isNotEmpty ? args : null;
  }
}

/// GeoJsonSourceProperties Class
/// Created by Amit Chaudhary, 2022/10/7
class GeoJsonSourceProperties extends SourceProperties {
  /// Maximum zoom level at which to create vector tiles
  /// (higher means greater detail at high zoom
  /// Default value is 18
  final int? maxZoom;

  /// Contains an attribution to be displayed when the map is shown
  /// to a user.
  final String? attribution;

  /// Size of the tile buffer on each side. A value of 0 produces no buffer.
  /// A value of 512 produces a buffer as wide as the tile itself.
  /// Larger values produce fewer rendering artifacts near tile edges
  /// and slower performance.
  /// Default value is 128
  final int? buffer;

  /// Douglas-Peucker simplification tolerance
  /// (higher means simpler geometries and faster performance).
  /// Default value is 0.375
  final double? tolerance;

  /// If the data is a collection of point features, setting this to true
  /// clusters the points by radius into groups. Cluster groups become
  /// new `Point` features in the source with additional properties:
  /// - `cluster` Is `true` if the point is a cluster
  /// - `cluster_id` A unique id for the cluster to be used in conjunction with the
  /// [cluster inspection methods](https://www.mapbox.com/mapbox-gl-js/api/#geojsonsource#getclusterexpansionzoom)
  /// - `point_count` Number of original points grouped into this cluster
  /// - `point_count_abbreviated` An abbreviated point count
  /// Default value is false
  final bool? cluster;

  /// Radius of each cluster if clustering is enabled.
  /// A value of 512 indicates a radius equal to the width of a tile.
  /// Default value is 50
  final int? clusterRadius;

  /// Max zoom on which to cluster points if clustering is enabled. Defaults
  /// to one zoom less than maxzoom (so that last zoom features are
  /// not clustered). Clusters are re-evaluated at integer zoom levels so
  /// setting clusterMaxZoom to 14 means the clusters will be displayed
  /// until z15.
  final int? clusterMaxZoom;

  /// An object defining custom properties on the generated clusters
  /// if clustering is enabled, aggregating values from clustered points.
  /// Has the form `{"property_name": [operator, map_expression]}`.
  /// `operator` is any expression function that accepts at least 2 operands
  /// (e.g. `"+"` or `"max"`) — it accumulates the property value from
  /// clusters/points the cluster contains; `map_expression` produces the
  /// value of a single point.
  /// Example: `{"sum": ["+", ["get", "scalerank"]]}`.
  /// For more advanced use cases, in place of `operator`, you can use
  /// a custom reduce expression that references a special `["accumulated"]`value,
  /// e.g.: `{"sum": [["+", ["accumulated"], ["get", "sum"]], ["get", "scalerank"]]}`
  final Map<String, dynamic>? clusterProperties;

  /// Whether to calculate line distance metrics. This is required for
  /// line layers that specify `line-gradient` values.
  /// Default value is false
  final bool? lineMetrics;

  /// Whether to generate ids for the geoJson features. When enabled,
  /// the `feature.id` property will be auto assigned based on its
  /// index in the `features` array, over-writing any previous values.
  /// Default value is false
  final bool? generateId;

  /// A property to use as a feature id (for feature state). Either a property
  /// name, or an object of the form `{<sourceLayer>: <propertyName>}`.
  final PromotedId? promoteId;

  /// When loading a map, if PrefetchZoomDelta is set to any number greater than 0, the map
  /// will first request a tile at zoom level lower than zoom - delta, but so that
  /// the zoom level is multiple of delta, in an attempt to display a full map at
  /// lower resolution as quick as possible. It will get clamped at the tile source minimum zoom.
  /// The default delta is 4.
  final int? prefetchZoomDelta;

  /// Add a Feature to the GeoJsonSource.
  final Feature? feature;

  /// Add a FeatureCollection to the GeoJsonSource.
  final FeatureCollection? featureCollection;

  /// Add a Geometry to the GeoJsonSource.
  // final Map<String, dynamic>? geometry;

  /// Constructor
  GeoJsonSourceProperties({
    this.maxZoom,
    this.attribution,
    this.buffer,
    this.tolerance,
    this.cluster,
    this.clusterRadius,
    this.clusterMaxZoom,
    this.clusterProperties,
    this.lineMetrics,
    this.generateId,
    this.promoteId,
    this.prefetchZoomDelta,
    this.feature,
    this.featureCollection,
  });

  /// Getter for defaultGeoJonSourceProperties
  static SourceProperties get defaultProperties {
    return GeoJsonSourceProperties(
      cluster: true,
      clusterMaxZoom: 14,
      clusterRadius: 50,
    );
  }

  /// Method to convert GeoJsonSourceProperties object to map
  @override
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    if (maxZoom != null) {
      args["maxZoom"] = maxZoom;
    }

    if (attribution != null) {
      args["attribution"] = attribution;
    }

    if (buffer != null) {
      args["buffer"] = buffer;
    }

    if (tolerance != null) {
      args["tolerance"] = tolerance;
    }

    if (cluster != null) {
      args["cluster"] = cluster;
    }

    if (clusterRadius != null) {
      args["clusterRadius"] = clusterRadius;
    }

    if (clusterMaxZoom != null) {
      args["clusterMaxZoom"] = clusterMaxZoom;
    }

    if (clusterProperties != null) {
      args["clusterProperties"] = clusterProperties;
    }

    if (lineMetrics != null) {
      args["lineMetrics"] = lineMetrics;
    }

    if (generateId != null) {
      args["generateId"] = generateId;
    }

    if (promoteId != null) {
      args["promoteId"] = promoteId?.toMap();
    }

    if (prefetchZoomDelta != null) {
      args["prefetchZoomDelta"] = prefetchZoomDelta;
    }

    if (feature != null) {
      args["feature"] = jsonEncode(feature?.toMap());
    }

    if (featureCollection != null) {
      args["featureCollection"] = jsonEncode(featureCollection?.toMap());
    }

    // if (geometry != null) {
    //   args["geometry"] = jsonEncode(geometry);
    // }

    return args.isNotEmpty ? args : null;
  }
}
