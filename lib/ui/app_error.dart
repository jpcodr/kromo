
import 'package:flutter/material.dart';
import 'package:kromo/ui/theme/text_theme.dart';

class AppError extends StatelessWidget {
  const AppError({
    super.key,
    required this.error,
    required this.onRetry,
  });

  final String error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: AppTextTheme.textTheme,
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.error, size: MediaQuery.sizeOf(context).width / 3),
              const SizedBox(height: 16.0),
              Text(
                error,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32.0),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                onPressed: onRetry,
                label: const Text('Reintentar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
