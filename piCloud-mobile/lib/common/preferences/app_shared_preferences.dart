import 'package:app/common/models/view_mode.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  const AppSharedPreferences(this._preferences);

  static const _preferredViewKey = 'preferredView';
  static const _preferredThemeKey = 'useDarkTheme';

  final SharedPreferences _preferences;

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

  void setPreferredViewMode(ViewMode viewMode) {
    _preferences.setString(_preferredViewKey, viewMode.serialize());
  }

  Future<void> setDefaultThemeIfNeeded() async {
    if (!_preferences.containsKey(_preferredThemeKey)) {
      final systemBrightness =
          SchedulerBinding.instance!.window.platformBrightness;
      final isDarkMode = systemBrightness == Brightness.dark;

      await _preferences.setBool(_preferredThemeKey, isDarkMode);
    }
  }
}
