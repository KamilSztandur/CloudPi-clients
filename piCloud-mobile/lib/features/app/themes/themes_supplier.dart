import 'package:app/features/app/themes/main_app_color.dart';
import 'package:app/features/app/themes/no_transitions.dart';
import 'package:flutter/material.dart';

class ThemesSupplier {
  static ThemeData getDarkTheme() => ThemeData(
        primaryColor: MainAppColor().shade600,
        primaryColorLight: MainAppColor(),
        primaryColorDark: MainAppColor().shade700,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MainAppColor(),
          brightness: Brightness.dark,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: NoTransitions(),
      );

  static ThemeData getLightTheme() => ThemeData(
        primaryColor: MainAppColor().shade500,
        primaryColorLight: MainAppColor(),
        primaryColorDark: MainAppColor().shade600,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MainAppColor(),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: NoTransitions(),
      );
}
