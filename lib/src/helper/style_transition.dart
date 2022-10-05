/// A StyleTransition Class
/// [delay] Transition delay
/// [duration] Transition duration
class StyleTransition {
  final int delay;
  final Duration duration;

  /// Internal constructor to construct
  /// the StyleTransition
  StyleTransition._(this.delay, this.duration);

  /// Factory method to build the Style Transition
  factory StyleTransition.build({int? delay, Duration? duration}) {
    return StyleTransition._(
      delay ?? 0,
      duration ?? const Duration(milliseconds: 300),
    );
  }

  /// Method to convert the StyleTransition to Json form
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "delay": delay,
      "duration": duration.inMilliseconds
    };
  }
}
