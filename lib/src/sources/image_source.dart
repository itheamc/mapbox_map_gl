/// ImageSource Class
/// Created by Amit Chaudhary, 2022/10/6
class ImageSource {
  /// URL that points to an image.
  final String url;

  /// Corners of image specified in longitude, latitude pairs.
  /// List<List<double>>
  final List<List<double>> coordinates;

  /// When loading a map, if PrefetchZoomDelta is set to any number greater
  /// than 0, the map will first request a tile at zoom level lower than
  /// zoom - delta, but so that the zoom level is multiple of delta, in an
  /// attempt to display a full map at lower resolution as quick as possible.
  /// It will get clamped at the tile source minimum zoom.
  /// The default delta is 4.
  final int? prefetchZoomDelta;

  /// Constructor
  ImageSource({
    required this.url,
    required this.coordinates,
    this.prefetchZoomDelta,
  });

  /// Method to convert ImageSource object to map
  Map<String, dynamic> toMap() {
    final args = <String, dynamic>{};

    args["url"] = url;
    args["coordinates"] = coordinates;

    if (prefetchZoomDelta != null) {
      args["prefetchZoomDelta"] = prefetchZoomDelta;
    }

    return args;
  }
}
