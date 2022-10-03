import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mapbox_map_gl/src/mapbox_map_gl_method_channel.dart';

void main() {
  MethodChannelMapboxMapGl platform = MethodChannelMapboxMapGl();
  const MethodChannel channel = MethodChannel('mapbox_map_gl');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

}
