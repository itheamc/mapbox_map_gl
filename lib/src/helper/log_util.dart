import 'package:flutter/foundation.dart';

/// LogUtil Class
/// Created by Amit Chaudhary, 2022/10/13
class LogUtil {
  static void log({
    String className = "_",
    required String function,
    required dynamic message,
  }) {
    if (kDebugMode) {
      print("[$className.$function] -----> $message");
    }
  }
}
