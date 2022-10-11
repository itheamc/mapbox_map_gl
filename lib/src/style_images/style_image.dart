import 'dart:typed_data';

/// Abstract StyleImage class
/// Created by Amit Chaudhary, 2022/10/11
abstract class StyleImage {
  /// [imageId] - An unique id for the image to identify from the list of
  /// style images
  final String imageId;

  /// [sdf] - SDFs are a way of rendering images specially designed to preserve
  /// sharp outlines from a pixel image even when the image is resized.
  /// By default it is false
  final bool sdf;

  /// Constructor
  StyleImage({required this.imageId, this.sdf = false});

  /// Method to convert the StyleImage object to map
  Map<String, dynamic> toMap();

  /// Method to get the byte array of the image
  Future<Uint8List?> getByteArray();
}
