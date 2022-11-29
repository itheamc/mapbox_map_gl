/// Abstract Annotation class
/// Created by Amit Chaudhary, 2022/11/29
abstract class Annotation<T> {
  /// AnnotationOptions
  /// It contains the properties that is needed to build and create annotation
  final T? annotationOptions;

  /// Constructor
  Annotation({
    this.annotationOptions,
  });

  /// Method to convert Layer object to Map
  Map<String, dynamic> toMap();
}
