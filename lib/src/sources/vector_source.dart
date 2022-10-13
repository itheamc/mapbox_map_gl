import '../sources/source.dart';
import '../sources/source_properties.dart';

import '../utils/promoted_id.dart';
import '../utils/tileset.dart';

/// VectorSource Class
/// Created by Amit Chaudhary, 2022/10/6
class VectorSource extends Source<VectorSourceProperties> {
  /// An array of one or more tile source URLs, as in the TileJSON spec.
  final List<String>? tiles;

  /// Add a TileSet to the Source.
  final TileSet? tileSet;

  /// Constructor
  VectorSource({
    required super.sourceId,
    super.url,
    this.tiles,
    this.tileSet,
    super.sourceProperties,
  }) : assert(url != null || tiles != null || tileSet != null,
            "Please provide url or tiles or tile set for vector source.");

  /// Method to convert VectorSource Object to Map
  @override
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    args["sourceId"] = sourceId;

    if (url != null) {
      args["url"] = url;
    }

    if (tiles != null && tiles!.isNotEmpty) {
      args["tiles"] = tiles;
    }

    if (tileSet != null) {
      args["tileSet"] = tileSet?.toMap();
    }

    args['sourceProperties'] =
        (sourceProperties ?? VectorSourceProperties.defaultProperties).toMap();

    return args.isNotEmpty ? args : null;
  }
}

/// VectorSourceProperties Class
/// Created by Amit Chaudhary, 2022/10/7
class VectorSourceProperties extends SourceProperties {
  /// An array containing the longitude and latitude of
  /// the southwest and northeast corners of the source's
  /// bounding box in the following order: [sw.lng, sw.lat, ne.lng, ne.lat].
  /// When this property is included in a source, no tiles outside of
  /// the given bounds are requested by Mapbox GL.
  /// default is <double>[-180.0, -85.051129, 180.0, 85.051129]
  final List<double>? bounds;

  /// Influences the y direction of the tile coordinates.
  /// The global-mercator (aka Spherical Mercator) profile is assumed.
  /// default is Scheme.xyz
  final Scheme? scheme;

  /// Minimum zoom level for which tiles are available, as in the TileJSON spec.
  /// default is 0
  final int? minZoom;

  /// Maximum zoom level for which tiles are available, as in the TileJSON spec.
  /// Data from tiles at the max-zoom are used when displaying the map at
  /// higher zoom levels.
  /// default is 22
  final int? maxZoom;

  /// Contains an attribution to be displayed when the map is shown to a user.
  final String? attribution;

  /// A property to use as a feature id (for feature state). Either a property
  /// name, or an object of the form {<sourceLayer>: <propertyName>}.
  /// If specified as a string for a vector tile source, the same property
  /// is used across all its source layers.
  final PromotedId? promoteId;

  /// A setting to determine whether a source's tiles are cached locally
  /// default value is false
  final bool? volatile;

  /// When loading a map, if PrefetchZoomDelta is set to any number greater
  /// than 0, the map will first request a tile at zoom level lower than
  /// zoom - delta, but so that the zoom level is multiple of delta, in
  /// an attempt to display a full map at lower resolution as quick as
  /// possible. It will get clamped at the tile source minimum zoom.
  /// The default delta is 4.
  final int? prefetchZoomDelta;

  /// Minimum tile update interval in seconds, which is used to throttle
  /// the tile update network requests. If the given source supports loading
  /// tiles from a server, sets the minimum tile update interval. Update
  /// network requests that are more frequent than the minimum tile update
  /// interval are suppressed.
  /// default is 0.0
  final double? minimumTileUpdateInterval;

  /// When a set of tiles for a current zoom level is being rendered and some
  /// of the ideal tiles that cover the screen are not yet loaded, parent tile
  /// could be used instead. This might introduce unwanted rendering
  /// side-effects, especially for raster tiles that are over-scaled multiple
  /// times. This property sets the maximum limit for how much a parent tile
  /// can be over-scaled.
  final int? maxOverScaleFactorForParentTiles;

  /// For the tiled sources, this property sets the tile requests delay.
  /// The given delay comes in action only during an ongoing animation or
  /// gestures. It helps to avoid loading, parsing and rendering of the
  /// transient tiles and thus to improve the rendering performance,
  /// especially on low-end devices.
  /// default is 0.0
  final double? tileRequestsDelay;

  /// For the tiled sources, this property sets the tile network requests delay. The given delay comes in action only during an ongoing animation or gestures. It helps to avoid loading the transient tiles from the network and thus to avoid redundant network requests. Note that tile-network-requests-delay value is superseded with tile-requests-delay property value, if both are provided.
  /// default is 0.0
  final double? tileNetworkRequestsDelay;

  /// Constructor
  VectorSourceProperties({
    this.bounds,
    this.scheme,
    this.minZoom,
    this.maxZoom,
    this.attribution,
    this.promoteId,
    this.volatile,
    this.prefetchZoomDelta,
    this.minimumTileUpdateInterval,
    this.maxOverScaleFactorForParentTiles,
    this.tileRequestsDelay,
    this.tileNetworkRequestsDelay,
  });

  /// Getter for defaultVectorSourceProperties
  static SourceProperties get defaultProperties {
    return VectorSourceProperties(
      scheme: Scheme.xyz,
      maxZoom: 22,
      volatile: false,
    );
  }

  /// Method to convert VectorSourceProperties Object to Map
  @override
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    if (bounds != null && bounds!.isNotEmpty && bounds!.length == 4) {
      args["bounds"] = bounds;
    }

    if (minZoom != null) {
      args["minZoom"] = minZoom;
    }

    if (maxZoom != null) {
      args["maxZoom"] = maxZoom;
    }

    if (scheme != null) {
      args["scheme"] = scheme?.name;
    }

    if (attribution != null) {
      args["attribution"] = attribution;
    }

    if (volatile != null) {
      args["volatile"] = volatile;
    }

    if (prefetchZoomDelta != null) {
      args["prefetchZoomDelta"] = prefetchZoomDelta;
    }

    if (minimumTileUpdateInterval != null) {
      args["minimumTileUpdateInterval"] = minimumTileUpdateInterval;
    }

    if (maxOverScaleFactorForParentTiles != null) {
      args["maxOverScaleFactorForParentTiles"] =
          maxOverScaleFactorForParentTiles;
    }

    if (tileRequestsDelay != null) {
      args["tileRequestsDelay"] = tileRequestsDelay;
    }

    if (tileNetworkRequestsDelay != null) {
      args["tileNetworkRequestsDelay"] = tileNetworkRequestsDelay;
    }

    return args.isNotEmpty ? args : null;
  }
}
