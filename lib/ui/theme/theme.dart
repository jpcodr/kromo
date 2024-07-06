import "package:flutter/material.dart";
import "package:kromo/ui/theme/text_theme.dart";

class AppTheme {
  const AppTheme();

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff010503),
      surfaceTint: Color(0xff59605c),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff222a26),
      onPrimaryContainer: Color(0xffaeb6b1),
      secondary: Color(0xff5c5f5d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffe3e4e1),
      onSecondaryContainer: Color(0xff474947),
      tertiary: Color(0xff040609),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff26292e),
      onTertiaryContainer: Color(0xffb3b5bb),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfffcf9f7),
      onBackground: Color(0xff1b1c1b),
      surface: Color(0xfffcf9f7),
      onSurface: Color(0xff1c1b1b),
      surfaceVariant: Color(0xffe0e3e0),
      onSurfaceVariant: Color(0xff434845),
      outline: Color(0xff747875),
      outlineVariant: Color(0xffc3c7c4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inverseOnSurface: Color(0xfff3f0ef),
      inversePrimary: Color(0xffc1c8c3),
      primaryFixed: Color(0xffdde4df),
      onPrimaryFixed: Color(0xff161d1a),
      primaryFixedDim: Color(0xffc1c8c3),
      onPrimaryFixedVariant: Color(0xff414845),
      secondaryFixed: Color(0xffe2e3e0),
      onSecondaryFixed: Color(0xff191c1b),
      secondaryFixedDim: Color(0xffc5c7c4),
      onSecondaryFixedVariant: Color(0xff454745),
      tertiaryFixed: Color(0xffe1e2e9),
      onTertiaryFixed: Color(0xff191c21),
      tertiaryFixedDim: Color(0xffc4c6cd),
      onTertiaryFixedVariant: Color(0xff44474c),
      surfaceDim: Color(0xffdcd9d8),
      surfaceBright: Color(0xfffcf9f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xfff0edec),
      surfaceContainerHigh: Color(0xffebe7e6),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffffff),
      surfaceTint: Color(0xffc3c8c3),
      onPrimary: Color(0xff2c322e),
      primaryContainer: Color(0xffd1d6d1),
      onPrimaryContainer: Color(0xff3b413d),
      secondary: Color(0xffc6c7c4),
      onSecondary: Color(0xff2f312f),
      secondaryContainer: Color(0xff3b3d3c),
      onSecondaryContainer: Color(0xffd0d0ce),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff2e3035),
      tertiaryContainer: Color(0xffd4d4da),
      onTertiaryContainer: Color(0xff3d3f44),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff131313),
      onBackground: Color(0xffe5e2e1),
      surface: Color(0xff131313),
      onSurface: Color(0xffe5e2e1),
      surfaceVariant: Color(0xff434845),
      onSurfaceVariant: Color(0xffc4c7c3),
      outline: Color(0xff8e928e),
      outlineVariant: Color(0xff434845),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inverseOnSurface: Color(0xff313030),
      inversePrimary: Color(0xff5a605c),
      primaryFixed: Color(0xffdfe4df),
      onPrimaryFixed: Color(0xff171d1a),
      primaryFixedDim: Color(0xffc3c8c3),
      onPrimaryFixedVariant: Color(0xff434845),
      secondaryFixed: Color(0xffe2e3e0),
      onSecondaryFixed: Color(0xff1a1c1b),
      secondaryFixedDim: Color(0xffc6c7c4),
      onSecondaryFixedVariant: Color(0xff454745),
      tertiaryFixed: Color(0xffe2e2e8),
      onTertiaryFixed: Color(0xff1a1c20),
      tertiaryFixedDim: Color(0xffc6c6cc),
      onTertiaryFixedVariant: Color(0xff45474b),
      surfaceDim: Color(0xff131313),
      surfaceBright: Color(0xff393938),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1b1c1b),
      surfaceContainer: Color(0xff20201f),
      surfaceContainerHigh: Color(0xff2a2a29),
      surfaceContainerHighest: Color(0xff353534),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: AppTextTheme.textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
        bottomAppBarTheme: BottomAppBarTheme(
          color: colorScheme.inversePrimary,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),
      );

  ThemeData customThemeFromSeed(Brightness brightness, Color color) {
    ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: color,
      brightness: brightness,
    );

    return theme(scheme);
  }
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      // background: background,
      // onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      // surfaceVariant: surfaceVariant,
      surfaceContainerHighest: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}
