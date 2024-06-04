import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kromo/data/models/optional.dart';
import 'package:kromo/data/models/settings.dart';
import 'package:kromo/data/models/theme.dart';
import 'package:kromo/domain/providers/storage.dart';

final settingsProvider = NotifierProvider<SettingsNotifier, AppSettings>(
  SettingsNotifier.new,
);

class SettingsNotifier extends Notifier<AppSettings> {
  final String _fileName = 'settings.dat';

  @override
  AppSettings build() {
    final localData = ref.read(storageProvider).load(_fileName);
    return AppSettings.fromMap(localData);
  }

  void changeThemeType(ThemeType newType) {
    state = state.copyWith(
      themeType: newType,
    );
    ref.read(storageProvider).save(_fileName, state.toMap());
  }

  void changeThemeMode(ThemeMode newMode) {
    state = state.copyWith(
      themeMode: newMode,
    );
    ref.read(storageProvider).save(_fileName, state.toMap());
  }

  void changeThemeSeed(Color? newColor) {
    state = state.copyWith(themeSeed: Optional.value(newColor));
    ref.read(storageProvider).save(_fileName, state.toMap());
  }
}
