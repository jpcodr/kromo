import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kromo/data/data.dart';

import 'package:kromo/data/models/countdown.dart';
import 'package:kromo/domain/providers/storage.dart';

final countdownsProvider =
    NotifierProvider<CountdownsNotifier, List<Countdown>>(
        CountdownsNotifier.new);

class CountdownsNotifier extends Notifier<List<Countdown>> {
  final String _fileName = 'countdowns.dat';

  @override
  List<Countdown> build() {
    final data = ref.read(storageProvider).load(_fileName);
    final countdowns = List<Countdown>.from(data['countdowns'] != null
        ? data['countdowns'].map((el) => Countdown.fromMap(el))
        : []);

    if (countdowns.isEmpty) {
      ref.read(storageProvider).save(_fileName, {
        'countdowns': [defaultCountdown.toMap()]
      });

      return [defaultCountdown];
    }

    return countdowns;
  }

  void save(Countdown countdown, [String? id]) {
    if (id != null) {
      state = [
        for (var c in state)
          if (c.id == id) countdown else c
      ];
    } else {
      state = [...state, countdown];
    }

    ref.read(storageProvider).save(_fileName, {
      'countdowns': state.map((el) => el.toMap()).toList(),
    });
  }

  void delete(String id) {
    state = [
      for (var c in state)
        if (c.id != id) c
    ];
  }
}
