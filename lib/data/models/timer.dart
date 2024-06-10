import 'package:equatable/equatable.dart';

enum TimerState { initial, running }

class TimerModel extends Equatable {
  final Duration duration;
  final TimerState state;

  const TimerModel({
    this.duration = Duration.zero,
    this.state = TimerState.initial,
  });

  @override
  List<Object?> get props => [
        duration,
        state,
      ];

  @override
  bool get stringify => true;

  TimerModel copyWith({
    Duration? duration,
    TimerState? state,
  }) =>
      TimerModel(
        duration: duration ?? this.duration,
        state: state ?? this.state,
      );
}
