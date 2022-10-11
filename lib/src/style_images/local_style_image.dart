import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'style_image.dart';

/// LocalStyleImage class
///
/// Created by Amit Chaudhary, 2022/10/11
class LocalStyleImage extends StyleImage {
  /// [imageName] - An image name along with the path
  /// e.g. - assets/images/icon.png
  final String imageName;

  /// Constructor
  LocalStyleImage({
    required super.imageId,
    required this.imageName,
    super.sdf = false,
  });

  /// Method to convert the NetworkStyleImage to map
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "imageId": imageId,
      "imageName": imageName,
      "sdf": sdf,
    };
  }

  /// Method to get byte array
  @override
  Future<Uint8List?> getByteArray() async {
    try {
      if (imageName.trim().isEmpty) return null;

      final bytes = await rootBundle.load(imageName.trim());
      final list = bytes.buffer.asUint8List();
      return list;
    } on Exception catch (e, _) {
      if (kDebugMode) {
        print("[LocalStyleImage.getByteArray] -----> $e");
      }
    }
    return null;
  }
}
