import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_map_gl/mapbox_map_gl.dart';
import 'package:mapbox_map_gl/src/mapbox_map_controller_impl.dart';
import 'helper/methods.dart';
import 'mapbox_map_gl_platform_interface.dart';

/// Method to handle onMapCreated callback
/// [MapboxMapController] Instance of the MapboxMapController
typedef OnMapCreated = void Function(MapboxMapController);

/// Method to handle onStyleLoaded callback
typedef OnStyleLoaded = VoidCallback;

/// Method to handle onStyleLoadedError callback
/// [String] - Error message
typedef OnStyleLoadError = void Function(String);

/// Method to handle onMapClick callback
/// [Point] - It consists the latitude and longitude of the clicked feature
/// [ScreenCoordinate] - It consists the x and y coordinate of the clicked feature
/// in device screen
typedef OnMapClick = void Function(Point, ScreenCoordinate);

/// Method to handle onMapLongClick callback
/// [Point] - It consists the latitude and longitude of the clicked feature
/// [ScreenCoordinate] - It consists the x and y coordinate of the clicked feature
/// in device screen
typedef OnMapLongClick = void Function(Point, ScreenCoordinate);

/// Method to handle onFeatureClick callback
/// [Point] - It consists the latitude and longitude of the clicked feature
/// [ScreenCoordinate] - It consists the x and y coordinate of the clicked feature
/// in device screen
/// [Feature] - It is the feature objects that contains feature id, properties,
/// geometry etc.
/// [String] - Source of the feature
typedef OnFeatureClick = void Function(
    Point, ScreenCoordinate, Feature, String?);

/// Method to handle onFeatureLongClick callback
/// [Point] - It consists the latitude and longitude of the clicked feature
/// [ScreenCoordinate] - It consists the x and y coordinate of the clicked feature
/// in device screen
/// [Feature] - It is the feature objects that contains feature id, properties,
/// geometry etc.
/// [String] - Source of the feature
typedef OnFeatureLongClick = void Function(
    Point, ScreenCoordinate, Feature, String?);

class MapboxMap extends StatefulWidget {
  /// [initialCameraPosition] An initial camera position to animate the camera
  /// whenever map is loaded
  final CameraPosition? initialCameraPosition;

  /// [mapStyle] An initial map style whenever map loaded
  /// default value is MapStyle.light
  final MapStyle mapStyle;

  /// [onMapCreated] A callback that will be triggered whenever map is
  /// fully loaded/created
  final OnMapCreated? onMapCreated;

  /// [onStyleLoaded] A callback that will be triggered whenever style is loaded
  final OnStyleLoaded? onStyleLoaded;

  /// [onStyleLoadError] A callback that will be triggered if error occurred
  /// while loading the style
  final OnStyleLoadError? onStyleLoadError;

  /// [onMapClick] A callback that will be triggered whenever user click
  /// anywhere on the map
  final OnMapClick? onMapClick;

  /// [onMapLongClick] A callback that will be triggered whenever user long
  /// click anywhere on the map
  final OnMapLongClick? onMapLongClick;

  /// [onFeatureClick] A callback that will be triggered whenever user click
  /// on the feature i.e. circle, fill, symbol, line etc.
  final OnFeatureClick? onFeatureClick;

  /// [onFeatureLongClick] A callback that will be triggered whenever user long
  /// click on the feature i.e. circle, fill, symbol, line etc.
  final OnFeatureLongClick? onFeatureLongClick;

  /// [hyperComposition] Hybrid composition appends the native android.view.View
  /// to the view hierarchy. Therefore, keyboard handling, and accessibility
  /// work out of the box. Prior to Android 10, this mode might significantly
  /// reduce the frame throughput (FPS) of the Flutter UI.
  /// See https://docs.flutter.dev/development/platform-integration/android/platform-views#performance
  /// for more info.
  final bool hyperComposition;

  const MapboxMap({
    Key? key,
    this.initialCameraPosition,
    this.mapStyle = MapStyle.light,
    this.onMapCreated,
    this.onStyleLoaded,
    this.onStyleLoadError,
    this.onMapClick,
    this.onMapLongClick,
    this.onFeatureClick,
    this.onFeatureLongClick,
    this.hyperComposition = false,
  }) : super(key: key);

  @override
  State<MapboxMap> createState() => _MapboxMapState();
}

class _MapboxMapState extends State<MapboxMap> {
  /// MapboxMapGlPlatform Instance
  late MapboxMapGlPlatform _glPlatform;

  /// Attaching the method call handler to the Channel method
  /// to handle the method call triggered through the native channel
  @override
  void initState() {
    super.initState();

    _glPlatform = MapboxMapGlPlatform.instance;
    _glPlatform.attachedMethodCallHandler(_methodCallHandler);
  }

  /// Method to handle the method call
  /// [call] -> It is an instance of the Method call that
  /// contains method name and argument
  Future<dynamic> _methodCallHandler(MethodCall call) async {
    switch (call.method) {
      case Methods.onMapCreated:
        widget.onMapCreated?.call(MapboxMapControllerImpl(_glPlatform));
        break;
      case Methods.onStyleLoaded:
        widget.onStyleLoaded?.call();
        break;
      case Methods.onMapLoadError:
        widget.onStyleLoadError?.call(call.arguments);
        break;
      case Methods.onMapClick:
        final point = Point.fromArgs(call.arguments['point']);
        final coordinate =
            ScreenCoordinate.fromArgs(call.arguments['screen_coordinate']);
        widget.onMapClick?.call(point, coordinate);
        break;
      case Methods.onMapLongClick:
        final point = Point.fromArgs(call.arguments['point']);
        final coordinate =
            ScreenCoordinate.fromArgs(call.arguments['screen_coordinate']);
        widget.onMapLongClick?.call(point, coordinate);
        break;
      case Methods.onFeatureClick:
        final point = Point.fromArgs(call.arguments['point']);
        final coordinate =
            ScreenCoordinate.fromArgs(call.arguments['screen_coordinate']);
        final feature = Feature.fromArgs(call.arguments['feature']);
        final source = call.arguments['source'];
        widget.onFeatureClick?.call(point, coordinate, feature, source);
        break;
      case Methods.onFeatureLongClick:
        final point = Point.fromArgs(call.arguments['point']);
        final coordinate =
            ScreenCoordinate.fromArgs(call.arguments['screen_coordinate']);
        final feature = Feature.fromArgs(call.arguments['feature']);
        final source = call.arguments['source'];
        widget.onFeatureLongClick?.call(point, coordinate, feature, source);
        break;
      default:
    }
  }

  /// Build method too render the Mapbox map
  @override
  Widget build(BuildContext context) {
    /// [creationParams] Creation parameters that will be passed to native
    /// platform on initial view creation
    final creationParams = <String, dynamic>{};

    creationParams['initialCameraPosition'] =
        widget.initialCameraPosition?.toMap();
    creationParams['style'] = widget.mapStyle.name;

    return MapboxMapGlPlatform.instance.buildMapView(
      creationParams: creationParams,
      onPlatformViewCreated: (id) {},
      hyperComposition: widget.hyperComposition,
    );
  }
}

/// Enum for map style
enum MapStyle {
  /// A complete base map, perfect for incorporating your own data.
  streets,

  /// A general-purpose style tailored to outdoor activities.
  outdoors,

  /// Subtle light backdrop for data visualizations.
  light,

  /// Subtle dark backdrop for data visualizations.
  dark,

  /// A beautiful global satellite and aerial imagery layer.
  satellite,

  /// Global satellite and aerial imagery with unobtrusive labels.
  satelliteStreets,

  /// Color-coded roads based on live traffic congestion data.
  /// Traffic data is currently available in [these selected countries]
  /// (https://www.mapbox.com/help/how-directions-work/#traffic-data).
  trafficDay,

  /// Color-coded roads based on live traffic congestion data, designed to
  /// maximize legibility in low-light situations.
  /// Traffic data is currently available in [these selected countries]
  /// (https://www.mapbox.com/help/how-directions-work/#traffic-data).
  trafficNight,
}
