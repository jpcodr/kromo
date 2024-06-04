import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kromo/data/repositories/local_storage.dart';
import 'package:kromo/domain/providers/preferences.dart';
import 'package:kromo/domain/repositories/local_storage.dart';

final storageProvider = Provider<LocalStorage>((ref) {
  final prefs = ref.watch(sharedPrefsProvider).requireValue;

  return LocalStorageImpl(prefs);
});
