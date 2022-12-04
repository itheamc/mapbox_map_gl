import '../utils/enums.dart';
import '../utils/point.dart';
import 'annotation.dart';
import 'annotation_options.dart';

/// PolylineAnnotation class
/// Created by Amit Chaudhary, 2022/11/30
class PolylineAnnotation extends Annotation<PolylineAnnotationOptions> {
  /// Constructor for PolylineAnnotation
  PolylineAnnotation({
    required super.annotationOptions,
  });

  /// Method to convert the PolylineAnnotation Object to the
  /// Map data to pass to the native platform through args
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "annotationOptions": annotationOptions.toMap(),
    };
  }
}

/// PolylineAnnotationOptions class
/// It contains all the properties for the polygon annotation
/// e.g.
/// final polylineAnnotationOptions = PolylineAnnotationOptions(
///                             points: [
///                                [
///                                Point.fromLatLng(27.34, 85.43),
///                                Point.fromLatLng(27.4, 85.5)
///                                ]
///                             ],
///                             fillColor: "#ef2d3f",
///                         );
class PolylineAnnotationOptions extends AnnotationOptions {
  /// Set a list of Point for the line, which represents the locations of
  /// the line on the map
  /// Accepted data type:
  /// - List<Point>
  final List<Point> points;

  /// Set line-color to initialise the polylineAnnotation with.
  /// The color with which the line will be drawn.
  /// Accepted data type:
  /// - String and
  /// - Int
  final dynamic lineColor;

  /// Set line-opacity to initialise the polylineAnnotation with.
  /// The opacity at which the line will be drawn.
  /// Accepted data type:
  /// - Double
  /// default value is 1.0
  final double? lineOpacity;

  /// Set line-blur to initialise the polylineAnnotation with.
  /// Blur applied to the line, in density-independent pixels.
  /// Accepted data type:
  /// - Double
  /// default value is 0.0
  final double? lineBlur;

  /// Set line-width to initialise the polylineAnnotation with.
  /// Stroke thickness.
  /// Accepted data type:
  /// - Double
  final double? lineWidth;

  /// Set line-offset to initialise the polylineAnnotation with.
  /// The line's offset. For linear features, a positive value offsets
  /// the line to the right, relative to the direction of the line, and
  /// a negative value to the left. For polygon features, a positive value
  /// results in an inset, and a negative value results in an outset.
  /// Accepted data type:
  /// - Double
  final double? lineOffset;

  /// SSet line-gap-width to initialise the polylineAnnotation with.
  /// Draws a line casing outside of a line's actual path. Value indicates
  /// the width of the inner gap.
  /// Accepted data type:
  /// - Double
  final double? lineGapWidth;

  /// The display of lines when joining.
  /// Accepted data type:
  /// - LineJoin
  /// default value is LineJoin.miter
  final LineJoin? lineJoin;

  /// Set line-pattern to initialise the polylineAnnotation with.
  /// Name of image in sprite to use for drawing image lines. For seamless
  /// patterns, image width must be a factor of two (2, 4, 8, ..., 512).
  /// Note that zoom-dependent expressions will be evaluated only at integer
  /// zoom levels.
  /// Accepted data type:
  /// - String
  final String? linePattern;

  /// Set line-sort-key to initialise the polylineAnnotation with.
  /// Sorts features in ascending order based on this value. Features
  /// with a higher sort key will appear above features with a lower sort key.
  /// Accepted data type:
  /// - Double
  final double? lineSortKey;

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
  PolylineAnnotationOptions({
    required this.points,
    this.lineColor,
    this.lineOpacity,
    this.lineBlur,
    this.lineWidth,
    this.lineOffset,
    this.lineGapWidth,
    this.lineJoin,
    this.linePattern,
    this.lineSortKey,
    this.draggable = false,
    this.data,
  });

  /// Method to proceeds the polyline annotation option for native
  @override
  Map<String, dynamic>? toMap() {
    final args = <String, dynamic>{};

    args['points'] = points.map((e) => e.toMap()).toList();

    if (lineColor != null) {
      args['lineColor'] = lineColor;
    }

    if (lineOpacity != null) {
      args['lineOpacity'] = lineOpacity;
    }

    if (lineBlur != null) {
      args['lineBlur'] = lineBlur;
    }

    if (lineWidth != null) {
      args['lineWidth'] = lineWidth;
    }

    if (lineOffset != null) {
      args['lineOffset'] = lineOffset;
    }

    if (lineGapWidth != null) {
      args['lineGapWidth'] = lineGapWidth;
    }

    if (lineJoin != null) {
      args['lineJoin'] = lineJoin?.name;
    }

    if (lineSortKey != null) {
      args['lineSortKey'] = lineSortKey;
    }

    if (linePattern != null) {
      args['linePattern'] = linePattern;
    }

    if (data != null) {
      args['data'] = data;
    }

    args['draggable'] = draggable;

    return args.isNotEmpty ? args : null;
  }
}
