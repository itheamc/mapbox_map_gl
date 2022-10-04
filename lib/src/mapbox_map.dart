import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_map_gl/mapbox_map_gl.dart';
import 'package:mapbox_map_gl/src/feature.dart';
import 'package:mapbox_map_gl/src/mapbox_map_controller.dart';
import 'package:mapbox_map_gl/src/methods.dart';

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
/// [LatLng] - It consists the latitude and longitude of the clicked feature
/// [ScreenCoordinate] - It consists the x and y coordinate of the clicked feature
/// in device screen
typedef OnMapClick = void Function(LatLng, ScreenCoordinate);

/// Method to handle onMapLongClick callback
/// [LatLng] - It consists the latitude and longitude of the clicked feature
/// [ScreenCoordinate] - It consists the x and y coordinate of the clicked feature
/// in device screen
typedef OnMapLongClick = void Function(LatLng, ScreenCoordinate);

/// Method to handle onFeatureClick callback
/// [LatLng] - It consists the latitude and longitude of the clicked feature
/// [ScreenCoordinate] - It consists the x and y coordinate of the clicked feature
/// in device screen
/// [Feature] - It is the feature objects that contains feature id, properties,
/// geometry etc.
/// [String] - Source of the feature
typedef OnFeatureClick = void Function(
    LatLng, ScreenCoordinate, Feature, String?);

/// Method to handle onFeatureLongClick callback
/// [LatLng] - It consists the latitude and longitude of the clicked feature
/// [ScreenCoordinate] - It consists the x and y coordinate of the clicked feature
/// in device screen
/// [Feature] - It is the feature objects that contains feature id, properties,
/// geometry etc.
/// [String] - Source of the feature
typedef OnFeatureLongClick = void Function(
    LatLng, ScreenCoordinate, Feature, String?);

class MapboxMap extends StatefulWidget {
  final CameraPosition? initialCameraPosition;
  final OnMapCreated? onMapCreated;
  final OnStyleLoaded? onStyleLoaded;
  final OnStyleLoadError? onStyleLoadError;
  final OnMapClick? onMapClick;
  final OnMapLongClick? onMapLongClick;
  final OnFeatureClick? onFeatureClick;
  final OnFeatureLongClick? onFeatureLongClick;

  const MapboxMap({
    Key? key,
    this.initialCameraPosition,
    this.onMapCreated,
    this.onStyleLoaded,
    this.onStyleLoadError,
    this.onMapClick,
    this.onMapLongClick,
    this.onFeatureClick,
    this.onFeatureLongClick,
  }) : super(key: key);

  @override
  State<MapboxMap> createState() => _MapboxMapState();
}

class _MapboxMapState extends State<MapboxMap> {
  /// Attaching the method call handler to the Channel method
  /// to handle the method call triggered through the native channel
  @override
  void initState() {
    super.initState();

    MapboxMapGlPlatform.instance.attachedMethodCallHandler(_methodCallHandler);
  }

  /// Method to handle the method call
  /// [call] -> It is an instance of the Method call that
  /// contains method name and argument
  Future<dynamic> _methodCallHandler(MethodCall call) async {
    switch (call.method) {
      case Methods.onMapCreated:
        widget.onMapCreated?.call(MapboxMapController());
        break;
      case Methods.onStyleLoaded:
        widget.onStyleLoaded?.call();
        break;
      case Methods.onMapLoadError:
        widget.onStyleLoadError?.call(call.arguments);
        break;
      case Methods.onMapClick:
        final latLng = LatLng.from(call.arguments['latLng']);
        final coordinate =
            ScreenCoordinate.from(call.arguments['screen_coordinate']);
        widget.onMapClick?.call(latLng, coordinate);
        break;
      case Methods.onMapLongClick:
        final latLng = LatLng.from(call.arguments['latLng']);
        final coordinate =
            ScreenCoordinate.from(call.arguments['screen_coordinate']);
        widget.onMapLongClick?.call(latLng, coordinate);
        break;
      case Methods.onFeatureClick:
        final latLng = LatLng.from(call.arguments['latLng']);
        final coordinate =
            ScreenCoordinate.from(call.arguments['screen_coordinate']);
        final feature = Feature.from(jsonDecode(call.arguments['feature']));
        final source = call.arguments['source'];
        widget.onFeatureClick?.call(latLng, coordinate, feature, source);
        break;
      case Methods.onFeatureLongClick:
        final latLng = LatLng.from(call.arguments['latLng']);
        final coordinate =
            ScreenCoordinate.from(call.arguments['screen_coordinate']);
        final feature = Feature.from(jsonDecode(call.arguments['feature']));
        final source = call.arguments['source'];
        widget.onFeatureLongClick?.call(latLng, coordinate, feature, source);
        break;
      default:
        if (kDebugMode) {
          print("[METHOD INVOKED]-----------> ${call.method}");
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final creationParams = <String, dynamic>{};

    creationParams['initialCameraPosition'] =
        widget.initialCameraPosition?.toJson();

    return MapboxMapGlPlatform.instance.buildMapView(
        creationParams: creationParams, onPlatformViewCreated: (id) {});
  }
}
