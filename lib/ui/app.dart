import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kromo/data/models/theme.dart';
import 'package:kromo/domain/providers/app.dart';
import 'package:kromo/domain/providers/settings.dart';
import 'package:kromo/ui/app_error.dart';
import 'package:kromo/ui/screens/home/home.dart';
import 'package:kromo/ui/theme/theme.dart';

class AppBootstrap extends ConsumerWidget {
  const AppBootstrap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);

    return appState.when(data: (data) {
      FlutterNativeSplash.remove();
      return const KromoApp();
    }, error: (error, _) {
      FlutterNativeSplash.remove();
      return AppError(
        error: error.toString(),
        onRetry: () => ref.invalidate(appStateProvider),
      );
    }, loading: () {
      return const SizedBox.shrink();
    });
  }
}

class KromoApp extends ConsumerWidget {
  const KromoApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    const theme = AppTheme();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kromo RNG',
      themeMode: settings.themeMode,
      theme: settings.themeType == ThemeType.custom && settings.themeSeed != null
          ? theme.customThemeFromSeed(Brightness.light, settings.themeSeed!)
          : theme.light(),
      darkTheme: settings.themeType == ThemeType.custom && settings.themeSeed != null
          ? theme.customThemeFromSeed(Brightness.dark, settings.themeSeed!)
          : theme.dark(),
      home: const HomePage(title: 'Kromo RNG'),
    );
  }
}
