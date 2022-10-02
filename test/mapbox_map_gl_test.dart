import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mapbox_map_gl/mapbox_map_gl.dart';
import 'package:mapbox_map_gl/mapbox_map_gl_platform_interface.dart';
import 'package:mapbox_map_gl/mapbox_map_gl_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMapboxMapGlPlatform
    with MockPlatformInterfaceMixin
    implements MapboxMapGlPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Widget buildView({required Map<String, dynamic> creationParams, void Function(int id)? onPlatformViewCreated}) {
    // TODO: implement buildView
    throw UnimplementedError();
  }
}

void main() {
  final MapboxMapGlPlatform initialPlatform = MapboxMapGlPlatform.instance;

  test('$MethodChannelMapboxMapGl is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMapboxMapGl>());
  });


}
