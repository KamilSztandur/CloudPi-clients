import 'package:app/common/models/view_mode.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  const AppSharedPreferences(this._preferences);

  static const _preferredViewKey = 'preferredView';
  static const _preferredThemeKey = 'useDarkTheme';

  final SharedPreferences _preferences;

  Future<void> init() async {
    if (!_preferences.containsKey(_preferredThemeKey)) {
      await setDefaultTheme();
    }

    if (!_preferences.containsKey(_preferredViewKey)) {
      await setPreferredViewMode(ViewMode.tile);
    }
  }

  ViewMode getPreferredViewMode() {
    return ViewModeSerialization.deserialize(
          _preferences.getString(_preferredViewKey),
        ) ??
        ViewMode.tile;
  }

  bool useDarkTheme() => _preferences.getBool(_preferredThemeKey) ?? false;

  Future<void> toggleTheme() => _preferences.setBool(
        _preferredThemeKey,
        !useDarkTheme(),
      );

  Future<void> setPreferredViewMode(ViewMode viewMode) async =>
      _preferences.setString(_preferredViewKey, viewMode.serialize());

  Future<void> setDefaultTheme() async {
    final systemBrightness =
        SchedulerBinding.instance!.window.platformBrightness;
    final isDarkMode = systemBrightness == Brightness.dark;

    await _preferences.setBool(_preferredThemeKey, isDarkMode);
  }
}
