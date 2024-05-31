import 'package:flutter_riverpod/flutter_riverpod.dart';

final appStateProvider = FutureProvider<void>((ref) async {
  ref.onDispose(() {});

  await Future.delayed(const Duration(seconds: 3));
});
