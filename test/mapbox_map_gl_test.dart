import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mapbox_map_gl/src/mapbox_map_gl_method_channel.dart';
import 'package:mapbox_map_gl/src/mapbox_map_gl_platform_interface.dart';
import 'package:mapbox_map_gl/src/mapbox_map_gl_view_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMapboxMapGlPlatform
    with MockPlatformInterfaceMixin
    implements MapboxMapGlPlatform {
  @override
  Widget buildMapView(
      {required Map<String, dynamic> creationParams,
      void Function(int id)? onPlatformViewCreated,
      bool hyperComposition = false}) {
    // TODO: implement buildMapView
    throw UnimplementedError();
  }

  @override
  void attachedMethodCallHandler(MethodCallHandler callHandler) {
    // TODO: implement attachedMethodCallHandler
  }
}

void main() {
  final MapboxMapGlPlatform initialPlatform = MapboxMapGlPlatform.instance;

  test('$MethodChannelMapboxMapGl is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMapboxMapGl>());
  });
}
