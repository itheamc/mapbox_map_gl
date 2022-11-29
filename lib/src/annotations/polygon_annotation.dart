import 'package:mapbox_map_gl/src/annotations/annotation.dart';
import 'package:mapbox_map_gl/src/annotations/annotation_options.dart';
import 'package:mapbox_map_gl/src/utils/point.dart';

/// PolygonAnnotation class
/// Created by Amit Chaudhary, 2022/11/29
class PolygonAnnotation extends Annotation<PolygonAnnotationOptions> {
  /// Constructor for PolygonAnnotation
  PolygonAnnotation({
    super.annotationOptions,
  });

  /// Method to convert the PolygonAnnotation Object to the
  /// Map data to pass to the native platform through args
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "annotationOptions": (annotationOptions ??
              PolygonAnnotationOptions.defaultAnnotationOptions)
          .toMap(),
    };
  }
}

/// PolygonAnnotationOptions class
/// It contains all the properties for the polygon annotation
/// e.g.
/// final polygonAnnotationOptions = PolygonAnnotationOptions(
///                             circleColor: 'green',
///                             circleRadius: 10.0,
///                             circleStrokeWidth: 2.0,
///                             circleStrokeColor: "#fff",
///                         );
class PolygonAnnotationOptions extends AnnotationOptions {
  /// Set a list of lists of Point for the fill, which represents
  /// the locations of the fill on the map
  /// Accepted data type:
  /// - List<List<Point>>
  final List<List<Point>> points;

  /// Set fill-color to initialise the polygonAnnotation with.
  /// The color of the filled part of this layer.
  /// This color can be specified as rgba with an alpha component
  /// and the color's opacity will not affect the opacity of the 1px stroke,
  /// if it is used.
  /// Accepted data type:
  /// - String and
  /// - Int
  final dynamic fillColor;

  /// The opacity of the entire fill layer.
  /// Accepted data type:
  /// - Double
  /// default value is 1.0
  final double? fillOpacity;

  /// The outline color of the fill.
  /// Accepted data type:
  /// - String and
  /// - Int
  final dynamic fillOutlineColor;

  /// Set fill-pattern to initialise the polygonAnnotation with.
  /// Name of image in sprite to use for drawing image fills.
  /// For seamless patterns, image width and height must be a
  /// factor of two (2, 4, 8, ..., 512). Note that zoom-dependent
  /// expressions will be evaluated only at integer zoom levels.
  /// Accepted data type:
  /// - String
  final String? fillPattern;

  /// Set fill-sort-key to initialise the polygonAnnotation with.
  /// Sorts features in ascending order based on this value.
  /// Features with a higher sort key will appear above features with
  /// a lower sort key.
  /// Accepted data type:
  /// - Double
  final double? fillSortKey;

  /// Set whether this circleAnnotation should be draggable, meaning it can be
  /// dragged across the screen when touched and moved.
  /// Accepted data type - bool
  /// default value is false
  final bool draggable;

  /// Set the arbitrary json data of the annotation.
  /// Accepted data type - Map<String, dynamic>
  /// default value is <String, dynamic>{}
  final Map<String, dynamic>? data;

  /// Constructor
  PolygonAnnotationOptions({
    required this.points,
    this.fillColor,
    this.fillOpacity,
    this.fillOutlineColor,
    this.fillPattern,
    this.fillSortKey,
    this.draggable = false,
    this.data,
  });

  /// Default Polygon Annotation Options
  static PolygonAnnotationOptions get defaultAnnotationOptions {
    return PolygonAnnotationOptions(
      points: [
        [Point.fromLatLng(27.34, 85.43), Point.fromLatLng(27.4, 85.5)]
      ],
      fillColor: 'blue',
      fillOutlineColor: "#fff",
    );
  }

  /// Method to proceeds the polygon annotation option for native
  @override
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    args['points'] =
        points.map((e) => e.map((e1) => e1.toMap()).toList()).toList();

    if (fillColor != null) {
      args['fillColor'] = fillColor;
    }

    if (fillOpacity != null) {
      args['fillOpacity'] = fillOpacity;
    }

    if (fillOutlineColor != null) {
      args['fillOutlineColor'] = fillOutlineColor;
    }

    if (fillSortKey != null) {
      args['fillSortKey'] = fillSortKey;
    }

    if (fillPattern != null) {
      args['fillPattern'] = fillPattern;
    }

    if (data != null) {
      args['data'] = data;
    }

    args['draggable'] = draggable;

    return args.isNotEmpty ? args : null;
  }
}
