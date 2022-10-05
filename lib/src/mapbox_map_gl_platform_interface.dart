import 'mapbox_map_gl_view_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mapbox_map_gl_method_channel.dart';

/// MapboxMapGlViewInterface Class
/// It is responsible for connecting flutter app with native platform
abstract class MapboxMapGlPlatform extends PlatformInterface
    with MapboxMapGlViewInterface {
  /// Constructs a MapboxMapGlPlatform.
  MapboxMapGlPlatform() : super(token: _token);

  /// Token
  static final Object _token = Object();

  /// Creating instance for the MapboxMapGlPlatform
  static MapboxMapGlPlatform _instance = MethodChannelMapboxMapGl();

  /// The default instance of [MapboxMapGlPlatform] to use.
  ///
  /// Defaults to [MethodChannelMapboxMapGl].
  static MapboxMapGlPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MapboxMapGlPlatform] when
  /// they register themselves.
  static set instance(MapboxMapGlPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }
}
