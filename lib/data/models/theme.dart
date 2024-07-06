import 'package:flutter/material.dart';

extension ThemeModeExtension on ThemeMode {
  String get label {
    switch (name) {
      case 'light':
        return 'Claro';
      case 'dark':
        return 'Oscuro';
      default:
        return 'Definido por el sistema';
    }
  }
}

enum ThemeType { mono, custom }

extension ThemeTypeExtension on ThemeType {
  String get label {
    switch (name) {
      case 'mono':
        return 'Default';
      case 'custom':
        return 'Personalizado';
      default:
        return '-';
    }
  }
}
