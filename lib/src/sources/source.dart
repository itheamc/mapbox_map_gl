/// Abstract Source class
/// Created by Amit Chaudhary, 2022/10/7
abstract class Source<T> {
  /// Source Id
  /// An unique identifier for the source
  final String sourceId;

  /// A URL of a source file.
  /// A URL to a TileJSON resource. Supported protocols are http:,
  /// https:, and mapbox://<Tileset ID>
  final String? url;

  /// SourceProperties
  final T? sourceProperties;

  /// Constructor
  Source({
    required this.sourceId,
    this.url,
    this.sourceProperties,
  });

  /// Method to convert source object to Map
  Map<String, dynamic>? toMap();
}
