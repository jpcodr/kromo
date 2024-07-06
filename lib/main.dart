import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kromo/ui/app.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await GoogleFonts.pendingFonts([
    GoogleFonts.chakraPetch,
    GoogleFonts.montserrat,
  ]);

  runApp(const ProviderScope(
    child: AppBootstrap(),
  ));
}
