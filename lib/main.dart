import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kromo/ui/theme/text_theme.dart';

void main() async {
  await GoogleFonts.pendingFonts([
    GoogleFonts.chakraPetch,
    GoogleFonts.montserrat,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: const Center(
        child: Text(
          'An alternative Pokémon RNG Timer',
        ),
      ),
    );
  }
}
