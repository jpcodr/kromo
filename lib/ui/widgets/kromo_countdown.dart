import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kromo/data/models/remaining_time.dart';
import 'package:kromo/data/models/timer.dart';
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
  late final Ticker _ticker;
  late final ProviderSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _initialTime = ref.read(timerProvider).duration;
    _remaining = RemainingTime(duration: _initialTime);
    _ticker = createTicker(_onTimeChanged);
    _subscription = ref.listenManual<TimerModel>(timerProvider, _stateListener);
  }

  @override
  void dispose() {
    _subscription.close();
    _ticker.dispose();
    super.dispose();
  }

  void _onTimeChanged(Duration elapsed) {
    Duration currentTime = _initialTime - elapsed;
    // print(
    //     '${_initialTime.inMilliseconds} - ${elapsed.inMilliseconds} = ${currentTime.inMilliseconds}');
    setState(() {
      _remaining = RemainingTime(duration: currentTime);

      if (_remaining.duration.inMilliseconds <= 0) {
        ref.read(timerProvider.notifier).next();
      }
    });
  }

  void _stateListener(TimerModel? prev, TimerModel next) {
    _ticker.stop();

    setState(() {
      _initialTime = ref.read(timerProvider).duration;

      if (next.state == TimerState.running) {
        _ticker.start();
      } else {
        _remaining = RemainingTime(duration: _initialTime);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = ref.watch(timerProvider).state == TimerState.running;
    
    return Column(
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
    );
  }
}
