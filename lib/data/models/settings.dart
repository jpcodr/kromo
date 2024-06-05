import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kromo/data/models/theme.dart';

import 'optional.dart';

class AppSettings extends Equatable {
  const AppSettings({
    this.counterBeeps = 6,
    this.counterSoundEnabled = true,
    this.frameRate = 60.0,
    this.themeMode = ThemeMode.system,
    this.themeSeed,
    this.themeType = ThemeType.mono,
  });

  final int counterBeeps;
  final bool counterSoundEnabled;
  final double frameRate;
  final ThemeMode themeMode;
  final Color? themeSeed;
  final ThemeType themeType;

  @override
  List<Object?> get props => [
        counterBeeps,
        counterSoundEnabled,
        frameRate,
        themeMode,
        themeSeed,
        themeType,
      ];

  @override
  bool get stringify => true;

  factory AppSettings.fromMap(Map<String, dynamic> json) => AppSettings(
        counterBeeps: json['counterBeeps'] ?? 6,
        counterSoundEnabled: json['counterSoundEnabled'] ?? true,
        frameRate: json['frameRate'] ?? 60.0,
        themeMode: json['themeMode'] != null
            ? ThemeMode.values.byName(json['themeMode'])
            : ThemeMode.system,
        themeSeed: json['themeSeed'] != null ? Color(json['themeSeed']) : null,
        themeType: json['themeType'] != null
            ? ThemeType.values.byName(json['themeType'])
            : ThemeType.mono,
      );

  Map<String, dynamic> toMap() {
    return {
      'counterBeeps': counterBeeps,
      'counterSoundEnabled': counterSoundEnabled,
      'frameRate': frameRate,
      'themeMode': themeMode.name,
      'themeSeed': themeSeed?.value,
      'themeType': themeType.name,
    };
  }

  AppSettings copyWith({
    int? counterBeeps,
    bool? counterSoundEnabled,
    double? frameRate,
    ThemeMode? themeMode,
    Optional<Color?>? themeSeed,
    ThemeType? themeType,
  }) =>
      AppSettings(
        counterBeeps: counterBeeps ?? this.counterBeeps,
        counterSoundEnabled: counterSoundEnabled ?? this.counterSoundEnabled,
        frameRate: frameRate ?? this.frameRate,
        themeMode: themeMode ?? this.themeMode,
        themeSeed: themeSeed != null ? themeSeed.value : this.themeSeed,
        themeType: themeType ?? this.themeType,
      );
}
