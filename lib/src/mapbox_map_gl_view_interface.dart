import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

typedef MethodCallHandler = Future<dynamic> Function(MethodCall call);

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
