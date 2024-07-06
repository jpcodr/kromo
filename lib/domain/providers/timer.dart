import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kromo/data/models/timer.dart';
import 'package:kromo/domain/providers/audio.dart';
import 'package:kromo/domain/providers/countdowns.dart';

final timerProvider =
    NotifierProvider<TimerNotifier, TimerModel>(TimerNotifier.new);

class TimerNotifier extends Notifier<TimerModel> {
  @override
  TimerModel build() {
    final countdowns = ref.watch(countdownsProvider);

    return TimerModel(
      duration: countdowns[_currentIdx].duration,
    );
  }

  int _currentIdx = 0;

  void start() {
    ref.read(audioProvider);
    state = state.copyWith(state: TimerState.running);
  }

  void next() {
    final countdowns = ref.read(countdownsProvider);

    if (_currentIdx + 1 < countdowns.length) {
      _currentIdx++;
      state = state.copyWith(
        duration: countdowns[_currentIdx].duration,
        currentCountdownIdx: _currentIdx,
      );
    } else {
      stop();
    }
  }

  void stop() {
    _currentIdx = 0;
    state = state.copyWith(
      state: TimerState.idle,
      duration: ref.read(countdownsProvider)[_currentIdx].duration,
      currentCountdownIdx: _currentIdx,
    );
  }
}
