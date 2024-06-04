import 'package:kromo/data/models/frame_rate.dart';

FrameRate getFrameRateByValue(double value) => FrameRate.values.firstWhere(
      (el) => el.rate == value,
      orElse: () => FrameRate.custom,
    );
