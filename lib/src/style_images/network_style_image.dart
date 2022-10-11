import 'dart:io';
import 'package:flutter/foundation.dart';
import 'style_image.dart';

/// NetworkStyleImage class
///
/// Created by Amit Chaudhary, 2022/10/11
class NetworkStyleImage extends StyleImage {
  /// [url] - An image url to load image
  final String url;

  /// Constructor
  NetworkStyleImage({
    required super.imageId,
    required this.url,
    super.sdf = false,
  });

  /// Method to convert the NetworkStyleImage to map
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "imageId": imageId,
      "url": url,
      "sdf": sdf,
    };
  }

  /// Method to get byte array
  @override
  Future<Uint8List?> getByteArray() async {
    try {
      if (url.trim().isEmpty || !url.contains("http")) return null;

      final uri = Uri.tryParse(url.trim());

      if (uri == null) return null;

      final client = HttpClient();
      final request = await client.getUrl(uri);
      final response = await request.close();

      final list = await response.first;

      return Uint8List.fromList(list);
    } on Exception catch (e, _) {
      if (kDebugMode) {
        print("[NetworkStyleImage.getByteArray] -----> $e");
      }
    }
    return null;
  }
}
