import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'mapbox_map_gl_view_interface.dart';

import 'mapbox_map_gl_platform_interface.dart';

/// An implementation of [MapboxMapGlPlatform] that uses method channels.
class MethodChannelMapboxMapGl extends MapboxMapGlPlatform {
  /// View Type Id and Method Channel Name
  static const _viewType = "com.itheamc.mapbox_map_gl/view_type_id";
  static const _channelName = "com.itheamc.mapbox_map_gl/method_channel";

  /// The method channel used to interact with the native platform.
  final _methodChannel = const MethodChannel(_channelName);

  /// Method to build platform view
  @override
  Widget buildMapView({
    required Map<String, dynamic> creationParams,
    void Function(int id)? onPlatformViewCreated,
    bool hyperComposition = false,
  }) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        if (hyperComposition) {
          return PlatformViewLink(
            viewType: _viewType,
            surfaceFactory: (context, controller) {
              return AndroidViewSurface(
                controller: controller as AndroidViewController,
                gestureRecognizers: const <
                    Factory<OneSequenceGestureRecognizer>>{},
                hitTestBehavior: PlatformViewHitTestBehavior.opaque,
              );
            },
            onCreatePlatformView: (params) {
              return PlatformViewsService.initSurfaceAndroidView(
                id: params.id,
                viewType: _viewType,
                layoutDirection: TextDirection.ltr,
                creationParams: creationParams,
                creationParamsCodec: const StandardMessageCodec(),
                onFocus: () {
                  params.onFocusChanged(true);
                },
              )
                ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
                ..create();
            },
          );
        }

        return AndroidView(
          viewType: _viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
          onPlatformViewCreated: onPlatformViewCreated,
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: _viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        throw UnsupportedError('Unsupported platform view');
    }
  }

  /// Method to attached method call handler to handle the method call
  /// triggered from the native channel
  @override
  void attachedMethodCallHandler(MethodCallHandler callHandler) {
    _methodChannel.setMethodCallHandler(callHandler);
  }

  /// Getter for method channel
  @override
  MethodChannel get channel => _methodChannel;
}
