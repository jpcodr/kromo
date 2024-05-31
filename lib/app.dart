import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kromo/domain/providers/app.dart';
import 'package:kromo/ui/screens/home/home.dart';
import 'package:kromo/ui/theme/text_theme.dart';

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
      return MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: AppTextTheme.textTheme,
          ),
          home: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.error, size: MediaQuery.sizeOf(context).width / 3),
                const SizedBox(height: 16.0),
                Text(error.toString()),
                const SizedBox(height: 32.0),
                ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    ref.invalidate(appStateProvider);
                  },
                  label: const Text('Reintentar'),
                )
              ],
            ),
          ));
    }, loading: () {
      return const SizedBox.shrink();
    });
  }
}

class KromoApp extends ConsumerWidget {
  const KromoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: AppTextTheme.textTheme,
      ),
      home: const MyHomePage(title: 'Kromo RNG'),
    );
  }
}
