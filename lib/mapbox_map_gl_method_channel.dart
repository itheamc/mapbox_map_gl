import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'mapbox_map_gl_platform_interface.dart';

/// An implementation of [MapboxMapGlPlatform] that uses method channels.
class MethodChannelMapboxMapGl extends MapboxMapGlPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel =
  const MethodChannel('mapbox_map_gl');

  // @override
  // Future<String?> getPlatformVersion() async {
  //   final version =
  //       await methodChannel.invokeMethod<String>('getPlatformVersion');
  //   return version;
  // }

  @override
  Widget buildView(
      {required Map<String, dynamic> creationParams,
        void Function(int id)? onPlatformViewCreated}) {
    const viewType = "mapbox_map_gl";

    return AndroidView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
      onPlatformViewCreated: onPlatformViewCreated,
    );
  }
}
