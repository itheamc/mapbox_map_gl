/// AnimationOptions Class
class AnimationOptions {
  /// [startDelay] - It is the time delay in milliseconds for the animation.
  /// [duration] - It is the duration of animation
  /// How long animation take place is depends on duration
  final int startDelay;
  final Duration duration;

  /// An internal/private constructor
  /// to construct AnimationOptions object
  AnimationOptions._(this.startDelay, this.duration);

  /// Factory method to create an AnimationOptions object
  /// [startDelay] An int value for animation delay
  /// default startDelay is 0
  /// [duration] Duration for animation
  /// default duration is const Duration(milliseconds: 300)
  factory AnimationOptions.mapAnimationOptions(
      {int? startDelay, Duration? duration}) {
    return AnimationOptions._(
      startDelay ?? 0,
      duration ?? const Duration(milliseconds: 300),
    );
  }

  /// Method to convert the AnimationOptions object to Map
  /// so as to pass to the native platform
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "startDelay": startDelay,
      "duration": duration.inMilliseconds
    };
  }
}
