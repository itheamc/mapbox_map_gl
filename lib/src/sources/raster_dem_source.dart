import '../helper/tileset.dart';

/// RasterDemSource Class
/// Created by Amit Chaudhary, 2022/10/6
class RasterDemSource {
  /// A URL to a TileJSON resource. Supported protocols are http:,
  /// https:, and mapbox://<Tileset ID>
  final String? url;

  /// An array of one or more tile source URLs, as in the TileJSON spec.
  final List<String>? tiles;

  /// An array containing the longitude and latitude of
  /// the southwest and northeast corners of the source's
  /// bounding box in the following order: [sw.lng, sw.lat, ne.lng, ne.lat].
  /// When this property is included in a source, no tiles outside of
  /// the given bounds are requested by Mapbox GL.
  /// default is <double>[-180.0, -85.051129, 180.0, 85.051129]
  final List<double>? bounds;

  /// Minimum zoom level for which tiles are available, as in the TileJSON spec.
  /// default is 0
  final int? minZoom;

  /// Maximum zoom level for which tiles are available, as in the TileJSON spec.
  /// Data from tiles at the max-zoom are used when displaying the map at
  /// higher zoom levels.
  /// default is 22
  final int? maxZoom;

  /// The minimum visual size to display tiles for this layer.
  /// Only configurable for raster layers.
  /// Default value is 512
  final int? tileSize;

  /// The encoding used by this source.
  /// Default is Encoding.mapbox
  final Encoding? encoding;

  /// Contains an attribution to be displayed when the map is shown to a user.
  final String? attribution;

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

  /// Add a TileSet to the Source.
  final TileSet? tileSet;

  /// Constructor
  RasterDemSource({
    this.url,
    this.tiles,
    this.bounds,
    this.minZoom,
    this.maxZoom,
    this.tileSize,
    this.encoding,
    this.attribution,
    this.volatile,
    this.prefetchZoomDelta,
    this.minimumTileUpdateInterval,
    this.maxOverScaleFactorForParentTiles,
    this.tileRequestsDelay,
    this.tileNetworkRequestsDelay,
    this.tileSet,
  });

  /// Method to convert VectorSource Object to Map
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    if (url != null) {
      args["url"] = url;
    }

    if (tiles != null && tiles!.isNotEmpty) {
      args["tiles"] = tiles;
    }

    if (bounds != null && bounds!.isNotEmpty && bounds!.length == 4) {
      args["bounds"] = bounds;
    }

    if (minZoom != null) {
      args["minZoom"] = minZoom;
    }

    if (maxZoom != null) {
      args["maxZoom"] = maxZoom;
    }

    if (tileSize != null) {
      args["tileSize"] = tileSize;
    }

    if (encoding != null) {
      args["encoding"] = encoding?.name;
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

    if (tileSet != null) {
      args["tileSet"] = tileSet?.toMap();
    }

    return args.isNotEmpty ? args : null;
  }
}
