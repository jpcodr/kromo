import 'package:equatable/equatable.dart';

enum TimerState { initial, running }

class TimerModel extends Equatable {
  final Duration duration;
  final TimerState state;
  final int currentCountdownIdx;

  const TimerModel({
    this.duration = Duration.zero,
    this.state = TimerState.initial,
    this.currentCountdownIdx = 0,
  });

  @override
  List<Object?> get props => [
        duration,
        state,
        currentCountdownIdx,
      ];

  @override
  bool get stringify => true;

  TimerModel copyWith({
    Duration? duration,
    TimerState? state,
    int? currentCountdownIdx,
  }) =>
      TimerModel(
        duration: duration ?? this.duration,
        state: state ?? this.state,
        currentCountdownIdx: currentCountdownIdx ?? this.currentCountdownIdx,
      );
}
