import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:kromo/domain/providers/audio.dart';
import 'package:kromo/domain/providers/preferences.dart';

final appStateProvider = FutureProvider<void>((ref) async {
  ref.onDispose(() {
    ref.invalidate(sharedPrefsProvider);
    // ref.invalidate(audioProvider);
  });

  await ref.watch(sharedPrefsProvider.future);
  // await ref.watch(audioProvider.future);
});
