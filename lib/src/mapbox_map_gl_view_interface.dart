import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

/// Method Call Handler to handler the methods triggered from the native
/// platform
/// [call] An object than contains method name and args
typedef MethodCallHandler = Future<dynamic> Function(MethodCall call);

/// MapboxMapGlViewInterface Mixin to contains the methods that are
/// responsible to render the Mapbox Map to the flutter app
mixin MapboxMapGlViewInterface {
  Widget buildMapView({
    required Map<String, dynamic> creationParams,
    void Function(int id)? onPlatformViewCreated,
    bool hyperComposition = false,
  });

  /// Method to set call handler to the method channel
  void attachedMethodCallHandler(MethodCallHandler callHandler);

  /// Method to get the method channel
  MethodChannel get channel;
}
