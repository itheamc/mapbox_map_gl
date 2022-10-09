import 'package:mapbox_map_gl/src/sources/source.dart';
import 'package:mapbox_map_gl/src/sources/source_properties.dart';

/// ImageSource Class
/// Created by Amit Chaudhary, 2022/10/6
class ImageSource extends Source<ImageSourceProperties> {
  /// Corners of image specified in longitude, latitude pairs.
  /// List<List<double>>
  final List<List<double>> coordinates;

  /// Constructor
  ImageSource({
    required super.sourceId,
    required super.url,
    required this.coordinates,
    super.sourceProperties,
  });

  /// Method to convert ImageSource object to map
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "sourceId": sourceId,
      "url": url,
      "coordinates": coordinates,
      "sourceProperties":
          (sourceProperties ?? ImageSourceProperties.defaultProperties).toMap()
    };
  }
}

/// ImageSourceProperties Class
/// Created by Amit Chaudhary, 2022/10/7
class ImageSourceProperties extends SourceProperties {
  /// When loading a map, if PrefetchZoomDelta is set to any number greater
  /// than 0, the map will first request a tile at zoom level lower than
  /// zoom - delta, but so that the zoom level is multiple of delta, in an
  /// attempt to display a full map at lower resolution as quick as possible.
  /// It will get clamped at the tile source minimum zoom.
  /// The default delta is 4.
  final int? prefetchZoomDelta;

  /// Constructor
  ImageSourceProperties({
    this.prefetchZoomDelta,
  });

  /// Getter for defaultImageSourceProperties
  static SourceProperties get defaultProperties {
    return ImageSourceProperties(
      prefetchZoomDelta: 4,
    );
  }

  /// Method to convert ImageSourceProperties Object to Map
  @override
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    if (prefetchZoomDelta != null) {
      args["prefetchZoomDelta"] = prefetchZoomDelta;
    }
    return args.isNotEmpty ? args : null;
  }
}
