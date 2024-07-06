// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kromo/data/data.dart';
import 'package:kromo/data/models/remaining_time.dart';
import 'package:kromo/data/models/settings.dart';
import 'package:kromo/data/models/timer.dart';
import 'package:kromo/domain/providers/audio.dart';
import 'package:kromo/domain/providers/settings.dart';
import 'package:kromo/domain/providers/timer.dart';
import 'package:kromo/ui/widgets/timer_text.dart';

class KromoCountdown extends ConsumerStatefulWidget {
  const KromoCountdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KromoCountdownState();
}

class _KromoCountdownState extends ConsumerState<KromoCountdown>
    with SingleTickerProviderStateMixin {
  late Duration _initialTime;
  late RemainingTime _remaining;
  late int _currentAlert;
  late bool _playSound = true;
  late bool _alerting = false;
  late final Ticker _ticker;
  late final ProviderSubscription _timerSubscription;
  late final ProviderSubscription _settingsSubscription;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(settingsProvider);
    final timerState = ref.read(timerProvider);

    _initialTime = timerState.duration;
    _playSound = settings.counterSoundEnabled;
    _currentAlert = settings.counterBeeps - 1;
    _remaining = RemainingTime(duration: _initialTime);
    _ticker = createTicker(_onTimeChanged);
    _timerSubscription =
        ref.listenManual<TimerModel>(timerProvider, _timerListener);
    _settingsSubscription =
        ref.listenManual<AppSettings>(settingsProvider, _settingsListener);
  }

  @override
  void dispose() {
    _timerSubscription.close();
    _settingsSubscription.close();
    _ticker.dispose();
    super.dispose();
  }

  void _onTimeChanged(Duration elapsed) {
    Duration currentTime = _initialTime - elapsed;
    // log('${_initialTime.inMilliseconds} - ${elapsed.inMilliseconds} = ${currentTime.inMilliseconds}');
    setState(() {
      _remaining = RemainingTime(duration: currentTime);

      if (_currentAlert >= 0 &&
          (currentTime.inMilliseconds <= (alertLapse * _currentAlert) ||
              currentTime.inMilliseconds <= 0)) {
        // log('NEW ALERT AT: ${currentTime.inMilliseconds}');
        _createAlert();
      }

      if (currentTime.inMilliseconds <= 0) {
        ref.read(timerProvider.notifier).next();
      }
    });
  }

  void _timerListener(TimerModel? prev, TimerModel next) {
    // log('TIMER CHANGED');
    _ticker.stop();

    setState(() {
      _initialTime = next.duration;
      _currentAlert = ref.read(settingsProvider).counterBeeps - 1;

      if (next.state == TimerState.running) {
        _ticker.start();
      } else {
        _remaining = RemainingTime(duration: _initialTime);
      }
    });
  }

  void _settingsListener(AppSettings? prev, AppSettings next) {
    if (prev?.counterSoundEnabled != next.counterSoundEnabled ||
        prev?.counterBeeps != next.counterBeeps) {
      setState(() {
        _currentAlert = next.counterBeeps - 1;
        _playSound = next.counterSoundEnabled;
      });
    }
  }

  void _createAlert() {
    _alerting = true;

    if (_playSound) {
      ref.read(audioProvider.notifier).play();
    }

    _currentAlert--;

    Future.delayed(const Duration(milliseconds: 100), () {
      // log('CLEAR ALERT');
      setState(() {
        _alerting = false;
        // ref.read(audioProvider.notifier).stop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRunning = ref.watch(timerProvider).state == TimerState.running;
    final audio = ref.watch(audioProvider);

    return Stack(
      fit: StackFit.expand,
      children: [
        if (_alerting)
          Container(
            color: theme.colorScheme.primaryContainer.withOpacity(0.75),
          ),
        audio.maybeWhen(
          data: (_) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TimerText(
                  text:
                      '${_remaining.minutes}:${_remaining.seconds}.${_remaining.hundreds}',
                  width: 40.0,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 12.0),
                FilledButton(
                  onPressed: () {
                    if (isRunning) {
                      ref.read(timerProvider.notifier).stop();
                    } else {
                      ref.read(timerProvider.notifier).start();
                    }
                  },
                  child: Text(
                    isRunning ? 'Detener' : 'Empezar',
                  ),
                ),
              ],
            ),
          ),
          orElse: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        )
      ],
    );
  }
}
