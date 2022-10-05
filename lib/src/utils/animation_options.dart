class AnimationOptions {
  final int startDelay;
  final Duration duration;

  AnimationOptions._(this.startDelay, this.duration);

  factory AnimationOptions.mapAnimationOptions(
      {int? startDelay, Duration? duration}) {
    return AnimationOptions._(
      startDelay ?? 0,
      duration ?? const Duration(milliseconds: 300),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "startDelay": startDelay,
      "duration": duration.inMilliseconds
    };
  }
}
