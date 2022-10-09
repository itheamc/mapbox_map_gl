/// GeoJsonSource Class
/// Created by Amit Chaudhary, 2022/10/6
class TileSet {
  /// [tileJson] - A semver.org style version number. Describes the version of
  /// the TileJSON spec that is implemented by this JSON object.
  final String tileJson;

  /// [tiles] - An array of tile endpoints. {z}, {x} and {y}, if present,
  /// are replaced with the corresponding integers.
  /// If multiple endpoints are specified, clients may use any combination
  /// of endpoints. All endpoints MUST return the same content for the same URL.
  /// The array MUST contain at least one endpoint. Example:
  /// "http:localhost:8888/admin/1.0.0/world-light,broadband/{z}/{x}/{y}.png"
  final List<String> tiles;

  /// [properties] - An properties for the tileset
  final TileSetProperties? properties;

  /// Constructor
  TileSet({
    required this.tileJson,
    required this.tiles,
    this.properties,
  }) : assert(tiles.isNotEmpty, "Tiles can't be empty!!");

  /// Method to convert TileSet object to Map
  /// It is basically for passing to the native platform
  Map<String, dynamic> toMap() {
    final args = <String, dynamic>{};

    args["tileJson"] = tileJson;
    args["tiles"] = tiles;

    if (properties != null) {
      args["properties"] = properties?.toMap();
    }

    return args;
  }
}

/// TileSetProperties class
class TileSetProperties {
  /// A name describing the tileset. The name can contain any legal character.
  /// Implementations SHOULD NOT interpret the name as HTML.
  final String? name;

  /// A text description of the tileset. The description can contain any
  /// legal character.
  /// Implementations SHOULD NOT interpret the description as HTML.
  /// "description": "A simple, light grey world."
  final String? description;

  /// A semver.org style version number. When
  /// changes across tiles are introduced, the minor version MUST change.
  /// This may lead to cut off labels. Therefore, implementors can decide to
  /// clean their cache when the minor version changes. Changes to the patch
  /// level MUST only have changes to tiles that are contained within one tile.
  /// When tiles change significantly, the major version MUST be increased.
  /// Implementations MUST NOT use tiles with different major versions.
  /// Default: "1.0.0".
  final String? version;

  ///  Contains an attribution to be displayed
  /// when the map is shown to a user. Implementations MAY decide to treat this
  /// as HTML or literal text. For security reasons, make absolutely sure that
  /// this field can't be abused as a vector for XSS or beacon tracking.
  /// "attribution": "[OSM contributors](http:openstreetmap.org)",
  /// Default: null.
  final String? attribution;

  /// Contains a mustache template to be used to
  /// format data from grids for interaction.
  /// See https:github.com/mapbox/utfgrid-spec/tree/master/1.2
  /// for the interactivity specification.
  /// "template": "{{#__teaser__}}{{NAME}}{{/__teaser__}}"
  final String? template;

  /// Contains a legend to be displayed with the map.
  /// Implementations MAY decide to treat this as HTML or literal text.
  /// For security reasons, make absolutely sure that this field can't be
  /// abused as a vector for XSS or beacon tracking.
  /// "legend": "Dangerous zones are red, safe zones are green"
  final String? legend;

  /// Default: "xyz". Either "xyz" or "tms". Influences the y
  /// direction of the tile coordinates.
  /// The global-mercator (aka Spherical Mercator) profile is assumed.
  /// default is Scheme.xyz
  final Scheme? scheme;

  /// An array of interactivity endpoints. {z}, {x}
  /// and {y}, if present, are replaced with the corresponding integers. If multiple
  /// endpoints are specified, clients may use any combination of endpoints.
  /// All endpoints MUST return the same content for the same URL.
  /// If the array doesn't contain any entries, interactivity is not supported
  /// for this tileset.     See https:github.com/mapbox/utfgrid-spec/tree/master/1.2
  /// for the interactivity specification.
  /// Example: "http:localhost:8888/admin/1.0.0/broadband/{z}/{x}/{y}.grid.json"
  final List<String>? grids;

  /// An array of data files in GeoJSON format.
  /// {z}, {x} and {y}, if present,
  /// are replaced with the corresponding integers. If multiple
  /// endpoints are specified, clients may use any combination of endpoints.
  /// All endpoints MUST return the same content for the same URL.
  /// If the array doesn't contain any entries, then no data is present in
  /// the map.
  final List<String>? data;

  /// An integer specifying the minimum zoom level.
  /// Default is 0
  final int? minZoom;

  /// An integer specifying the maximum zoom level.
  /// Default to 30
  final int? maxZoom;

  /// The maximum extent of available map tiles. Bounds MUST define an area
  /// covered by all zoom levels. The bounds are represented in WGS:84
  /// latitude and longitude values, in the order left, bottom, right, top.
  /// Values may be integers or floating point numbers.
  /// Default: [-180, -90, 180, 90]
  final List<double>? bounds;

  /// The first value is the longitude, the second is latitude (both in
  /// WGS:84 values), the third value is the zoom level as an integer.
  /// Longitude and latitude MUST be within the specified bounds.
  /// The zoom level MUST be between minzoom and maxzoom.
  /// Implementations can use this value to set the default location. If the
  /// value is null, implementations may use their own algorithm for
  /// determining a default location.
  final List<double>? center;

  /// The encoding formula for a raster-dem tileset.
  /// Supported values are "mapbox" and "terrarium".
  /// Default: Encoding.mapbox
  /// This is only for RasterDemSource
  final Encoding? encoding;

  /// Constructor
  TileSetProperties({
    this.name,
    this.description,
    this.version,
    this.attribution,
    this.template,
    this.legend,
    this.scheme,
    this.grids,
    this.data,
    this.minZoom,
    this.maxZoom,
    this.bounds,
    this.center,
    this.encoding,
  });

  /// Method to proceeds the fill layer option for native
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    if (name != null) {
      args["name"] = name;
    }

    if (description != null) {
      args["description"] = description;
    }

    if (version != null) {
      args["version"] = version;
    }

    if (attribution != null) {
      args["attribution"] = attribution;
    }

    if (template != null) {
      args["template"] = template;
    }

    if (legend != null) {
      args["legend"] = legend;
    }

    if (scheme != null) {
      args["scheme"] = scheme?.name;
    }

    if (grids != null && grids!.isNotEmpty) {
      args["grids"] = grids;
    }

    if (data != null && data!.isNotEmpty) {
      args["data"] = data;
    }

    if (minZoom != null) {
      args["minZoom"] = minZoom;
    }

    if (maxZoom != null) {
      args["maxZoom"] = maxZoom;
    }

    if (bounds != null && bounds!.isNotEmpty) {
      args["bounds"] = bounds;
    }

    if (center != null && center!.isNotEmpty) {
      args["center"] = center;
    }

    if (encoding != null) {
      args["encoding"] = encoding?.name;
    }

    return args.isNotEmpty ? args : null;
  }
}

/// Enum for Scheme
enum Scheme {
  xyz, // Slippy map tile names scheme.
  tms, // OSGeo spec scheme.
}

/// Enum for Encoding
enum Encoding { mapbox, terrarium }
