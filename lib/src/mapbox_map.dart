import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_map_gl/src/camera_position.dart';
import 'package:mapbox_map_gl/src/methods.dart';

import 'mapbox_map_gl_platform_interface.dart';

typedef OnMapCreated = VoidCallback;
typedef OnStyleLoaded = VoidCallback;
typedef OnStyleLoadError = void Function(String err);
typedef OnMapClick = void Function(dynamic);
typedef OnMapLongClick = void Function(dynamic);
typedef OnFeatureClick = void Function(dynamic);
typedef OnFeatureLongClick = void Function(dynamic);

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
        widget.onMapCreated?.call();
        break;
      case Methods.onStyleLoaded:
        widget.onStyleLoaded?.call();
        break;
      case Methods.onMapLoadError:
        widget.onStyleLoadError?.call(call.arguments);
        break;
      case Methods.onMapClick:
        widget.onMapClick?.call(call.arguments);
        break;
      case Methods.onMapLongClick:
        widget.onMapLongClick?.call(call.arguments);
        break;
      case Methods.onFeatureClick:
        widget.onFeatureClick?.call(call.arguments);
        break;
      case Methods.onFeatureLongClick:
        widget.onFeatureLongClick?.call(call.arguments);
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
