import 'dart:async';

import 'package:kromo/data/models/frame_rate.dart';

FrameRate getFrameRateByValue(double value) => FrameRate.values.firstWhere(
      (el) => el.rate == value,
      orElse: () => FrameRate.custom,
    );

class Debouncer {
  final int milliseconds;
  Timer? _timer;
  Debouncer({required this.milliseconds});
  void run(void Function() action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
