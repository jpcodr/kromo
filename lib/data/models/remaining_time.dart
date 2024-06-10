class RemainingTime {
  const RemainingTime({required this.duration});

  final Duration duration;

  String _fill(int n, {int count = 2}) => n.toString().padLeft(count, "0");

  /// Get the remaining days.
  String get days => duration.inDays.toString();

  /// Get the remaining hours always with two digits.
  String get hours => _fill(duration.inHours.remainder(24));

  /// Get the remaining minutes always with two digits.
  String get minutes => _fill(duration.inMinutes.remainder(60));

  /// Get the remaining seconds always with two digits.
  String get seconds => _fill(duration.inSeconds.remainder(60));

  /// Get the remaining milliseconds always with three digits.
  String get hundreds =>
      _fill((duration.inMilliseconds / 10).truncate().remainder(100));
}
