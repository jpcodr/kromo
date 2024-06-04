import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kromo/data/models/theme.dart';

import 'optional.dart';

class AppSettings extends Equatable {
  const AppSettings({
    this.themeMode = ThemeMode.light,
    this.themeSeed,
    this.themeType = ThemeType.mono,
  });

  final ThemeMode themeMode;
  final Color? themeSeed;
  final ThemeType themeType;

  @override
  List<Object?> get props => [
        themeMode,
        themeSeed,
        themeType,
      ];

  @override
  bool get stringify => true;

  factory AppSettings.fromMap(Map<String, dynamic> json) => AppSettings(
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
      'themeMode': themeMode.name,
      'themeSeed': themeSeed?.value,
      'themeType': themeType.name,
    };
  }

  AppSettings copyWith({
    ThemeMode? themeMode,
    Optional<Color?>? themeSeed,
    ThemeType? themeType,
  }) =>
      AppSettings(
        themeMode: themeMode ?? this.themeMode,
        themeSeed: themeSeed != null ? themeSeed.value : this.themeSeed,
        themeType: themeType ?? this.themeType,
      );
}
