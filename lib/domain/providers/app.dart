import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kromo/domain/providers/preferences.dart';

final appStateProvider = FutureProvider<void>((ref) async {
  ref.onDispose(() {
    ref.invalidate(sharedPrefsProvider);
  });

  await ref.watch(sharedPrefsProvider.future);
});
