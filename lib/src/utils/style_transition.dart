class StyleTransition {
  final int delay;
  final Duration duration;

  StyleTransition._(this.delay, this.duration);

  factory StyleTransition.build({int? delay, Duration? duration}) {
    return StyleTransition._(
      delay ?? 0,
      duration ?? const Duration(milliseconds: 300),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "delay": delay,
      "duration": duration.inMilliseconds
    };
  }
}
