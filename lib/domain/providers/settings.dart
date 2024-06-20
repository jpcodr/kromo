import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kromo/data/models/optional.dart';
import 'package:kromo/data/models/settings.dart';
import 'package:kromo/data/models/theme.dart';
import 'package:kromo/domain/providers/countdowns.dart';
import 'package:kromo/domain/providers/storage.dart';
import 'package:kromo/domain/providers/timer.dart';

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

  void toggleSound(bool newValue) {
    state = state.copyWith(counterSoundEnabled: newValue);
    ref.read(storageProvider).save(_fileName, state.toMap());
  }

  void changeBeepsNumber(int newValue) {
    state = state.copyWith(counterBeeps: newValue);
    ref.read(storageProvider).save(_fileName, state.toMap());
  }

  void changeFrameRate(double newFrameRate) {
    state = state.copyWith(frameRate: newFrameRate);
    ref.read(storageProvider).save(_fileName, state.toMap());
  }

  void reset() {
    state = const AppSettings();
    ref.invalidate(countdownsProvider);
    ref.invalidate(timerProvider);
    ref.read(storageProvider).clear();
    ref.read(storageProvider).save(_fileName, state.toMap());
  }
}
