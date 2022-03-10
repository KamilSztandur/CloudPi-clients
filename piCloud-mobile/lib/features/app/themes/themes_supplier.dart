import 'package:app/features/app/themes/no_transitions.dart';
import 'package:flutter/material.dart';

class ThemesSupplier {
  static ThemeData getDarkTheme() => ThemeData(
        primaryColor: Colors.pink.shade800,
        primaryColorLight: Colors.pink,
        primaryColorDark: Colors.pink.shade900,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
          brightness: Brightness.dark,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: NoTransitions(),
      );

  static ThemeData getLightTheme() => ThemeData(
        primaryColor: Colors.pinkAccent.shade200,
        primaryColorLight: Colors.pinkAccent,
        primaryColorDark: Colors.pinkAccent.shade700,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: NoTransitions(),
      );
}
