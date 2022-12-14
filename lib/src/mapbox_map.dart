import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utils/feature_details.dart';
import 'mapbox_map_controller.dart';
import 'utils/camera_position.dart';
import 'utils/feature.dart';
import 'mapbox_map_controller_impl.dart';
import 'utils/methods.dart';
import 'utils/point.dart';
import 'utils/screen_coordinate.dart';
import 'mapbox_map_gl_platform_interface.dart';

/// Typedef for handling onMapCreated callback
/// [MapboxMapController] Instance of the MapboxMapController
typedef OnMapCreated = void Function(MapboxMapController);

/// Typedef for handling onMapLoaded callback
typedef OnMapLoaded = VoidCallback;

/// Method to handle onStyleLoaded callback
typedef OnStyleLoaded = VoidCallback;

/// Typedef for handling onStyleLoadedError callback
/// [String] - Error message
typedef OnStyleLoadError = void Function(String);

/// Typedef for handling onMapClick callback
/// [Point] - It consists the latitude and longitude of the clicked feature
/// [ScreenCoordinate] - It consists the x and y coordinate of the clicked feature
/// in device screen
typedef OnMapClick = void Function(Point, ScreenCoordinate);

/// Typedef for handling onMapLongClick callback
/// [Point] - It consists the latitude and longitude of the clicked feature
/// [ScreenCoordinate] - It consists the x and y coordinate of the clicked feature
/// in device screen
typedef OnMapLongClick = void Function(Point, ScreenCoordinate);

/// Typedef for handling onFeatureClick callback
/// [details] - The details object will consist following: -
/// [Point] - It consists the latitude and longitude of the clicked feature
/// [ScreenCoordinate] - It consists the x and y coordinate of the clicked feature
/// in device screen
/// [Feature] - It is the feature objects that contains feature id, properties,
/// geometry etc.
/// [String] - Source of the feature
/// [String] - Source Layer of the feature
typedef OnFeatureClick = void Function(FeatureDetails details);

/// Typedef for handling onFeatureLongClick callback
/// [details] - The details object will consist following: -
/// [Point] - It consists the latitude and longitude of the clicked feature
/// [ScreenCoordinate] - It consists the x and y coordinate of the clicked feature
/// in device screen
/// [Feature] - It is the feature objects that contains feature id, properties,
/// geometry etc.
/// [String] - Source of the feature
/// [String] - Source Layer of the feature
typedef OnFeatureLongClick = void Function(FeatureDetails details);

class MapboxMap extends StatefulWidget {
  /// [initialCameraPosition] An initial camera position to animate the camera
  /// whenever map is loaded
  final CameraPosition? initialCameraPosition;

  /// [style] An initial map style whenever map loaded
  /// default value is MapStyle.light
  final MapStyle style;

  /// [showCurrentLocation] Boolean to decide weather to show user's current
  /// location puck or not.
  /// In order to get accurate location:-
  /// Add this dependency on your app's build.gradle
  /// implementation "com.google.android.gms:play-services-location:18.0.0"
  ///
  /// default value is false
  final bool showCurrentLocation;

  /// [onMapCreated] A callback that will be triggered whenever platform view
  /// for mapbox map is created
  final OnMapCreated? onMapCreated;

  /// [onMapLoaded] A callback that will be triggered whenever map is
  /// fully loaded/created
  final OnMapLoaded? onMapLoaded;

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
    this.style = MapStyle.light,
    this.showCurrentLocation = false,
    this.onMapCreated,
    this.onMapLoaded,
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

  /// MapboxMapController
  late MapboxMapController _mapController;

  /// Attaching the method call handler to the Channel method
  /// to handle the method call triggered through the native channel
  @override
  void initState() {
    super.initState();
    _glPlatform = MapboxMapGlPlatform.instance;
    _mapController = MapboxMapControllerImpl(_glPlatform);
    _glPlatform.attachedMethodCallHandler(_methodCallHandler);
  }

  /// Method to handle the method call
  /// [call] -> It is an instance of the Method call that
  /// contains method name and argument
  Future<dynamic> _methodCallHandler(MethodCall call) async {
    switch (call.method) {
      case Methods.onMapLoaded:
        widget.onMapLoaded?.call();
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
        final details = FeatureDetails.fromArgs(call.arguments);
        widget.onFeatureClick?.call(details);
        break;
      case Methods.onFeatureLongClick:
        final details = FeatureDetails.fromArgs(call.arguments);
        widget.onFeatureLongClick?.call(details);
        break;
      default:
        final args = <String, dynamic>{
          "method": call.method,
          "args": call.arguments
        };
        _mapController.callbacks(args);
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

    creationParams['style'] = widget.style.name;

    creationParams['enable_location'] = widget.showCurrentLocation;

    return MapboxMapGlPlatform.instance.buildMapView(
      creationParams: creationParams,
      onPlatformViewCreated: (id) {
        widget.onMapCreated?.call(_mapController);
      },
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
