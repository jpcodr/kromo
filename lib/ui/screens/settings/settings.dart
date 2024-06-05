import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kromo/data/models/frame_rate.dart';
import 'package:kromo/data/models/theme.dart';
import 'package:kromo/data/utils.dart';
import 'package:kromo/domain/providers/settings.dart';
import 'package:kromo/ui/widgets/color_field.dart';
import 'package:kromo/ui/widgets/keyboard_dismiss.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late TextEditingController _beepsController;
  late TextEditingController _rateController;
  late FrameRate currentRate;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(settingsProvider);
    _beepsController = TextEditingController(text: '${settings.counterBeeps}');
    currentRate = getFrameRateByValue(settings.frameRate);
    _rateController = TextEditingController(
        text: currentRate == FrameRate.custom
            ? '${settings.frameRate}'
            : '${FrameRate.custom.rate}');
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final settings = ref.watch(settingsProvider);

    return KeyboardDismiss(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          padding:
              const EdgeInsets.all(16.0) + const EdgeInsets.only(bottom: 32.0),
          children: [
            Text('Configuración de tema', style: tt.headlineSmall),
            const SizedBox(height: 12.0),
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
            const SizedBox(height: 16.0),
            Text('Color', style: tt.labelMedium),
            const SizedBox(height: 8.0),
            ColorField(
              color: settings.themeSeed,
              enabled: settings.themeType == ThemeType.custom,
              onColorChanged: (newColor) {
                if (newColor != null) {
                  ref.read(settingsProvider.notifier).changeThemeSeed(newColor);
                }
              },
            ),
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
            const SizedBox(height: 32.0),
            Text('Configuración de contador', style: tt.headlineSmall),
            const SizedBox(height: 8.0),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              activeTrackColor: Theme.of(context).colorScheme.secondary,
              value: settings.counterSoundEnabled,
              onChanged: ref.read(settingsProvider.notifier).toggleSound,
              title: const Text('Sonido'),
            ),
            const SizedBox(height: 16.0),
            Text('Número de alertas', style: tt.labelMedium),
            const SizedBox(height: 8.0),
            TextField(
              controller: _beepsController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final count = int.tryParse(value) ?? 6;
                ref.read(settingsProvider.notifier).changeBeepsNumber(count);
              },
            ),
            const SizedBox(height: 16.0),
            Text('Cuadros por segundo', style: tt.labelMedium),
            DropdownButton<FrameRate>(
              isExpanded: true,
              value: currentRate,
              onChanged: (newFrameRate) {
                if (newFrameRate != null) {
                  setState(() {
                    currentRate = newFrameRate;
                  });
                  ref
                      .read(settingsProvider.notifier)
                      .changeFrameRate(newFrameRate.rate);
                }
              },
              items: FrameRate.values
                  .map((el) => DropdownMenuItem(
                        value: el,
                        child: Text(
                            '${el.label}${el != FrameRate.custom && el != FrameRate.initial ? ' (${el.rate} fps)' : ''}'),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16.0),
            TextField(
              enabled: currentRate == FrameRate.custom,
              controller: _rateController,
              onChanged: (value) {
                final newRate = double.tryParse(value) ?? FrameRate.custom.rate;
                ref.read(settingsProvider.notifier).changeFrameRate(newRate);
              },
            ),
            const SizedBox(height: 32.0),
            FilledButton.tonal(
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return RestoreSettingsDialog(
                      onPressed: () =>
                          ref.read(settingsProvider.notifier).reset(),
                    );
                  },
                );
              },
              child: const Text('Reestablecer'),
            ),
          ],
        ),
      ),
    );
  }
}
