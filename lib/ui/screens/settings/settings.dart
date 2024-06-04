import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kromo/data/models/theme.dart';
import 'package:kromo/domain/providers/settings.dart';
import 'package:kromo/ui/widgets/color_field.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tt = Theme.of(context).textTheme;
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding:
            const EdgeInsets.all(16.0) + const EdgeInsets.only(bottom: 32.0),
        children: [
          Text('Configuración de tema', style: tt.headlineSmall),
          const SizedBox(height: 8.0),
          Text('Tema', style: tt.labelMedium),
          DropdownButton<ThemeType>(
            isExpanded: true,
            value: settings.themeType,
            onChanged: (newType) {
              if (newType != null) {
                ref.read(settingsProvider.notifier).changeThemeType(newType);
              }
            },
            items: ThemeType.values
                .map((el) => DropdownMenuItem(
                      value: el,
                      child: Text(el.label),
                    ))
                .toList(),
          ),
          if (settings.themeType == ThemeType.custom) ...[
            const SizedBox(height: 16.0),
            Text('Color', style: tt.labelMedium),
            const SizedBox(height: 8.0),
            ColorField(
              color: settings.themeSeed,
              onColorChanged: (newColor) {
                if (newColor != null) {
                  ref.read(settingsProvider.notifier).changeThemeSeed(newColor);
                }
              },
            )
          ],
          const SizedBox(height: 16.0),
          Text('Modo', style: tt.labelMedium),
          DropdownButton<ThemeMode>(
            isExpanded: true,
            value: settings.themeMode,
            onChanged: (newMode) {
              if (newMode != null) {
                ref.read(settingsProvider.notifier).changeThemeMode(newMode);
              }
            },
            items: ThemeMode.values
                .map((el) => DropdownMenuItem(
                      value: el,
                      child: Text(el.label),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
