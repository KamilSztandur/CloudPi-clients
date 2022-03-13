import 'package:app/common/preferences/app_shared_preferences.dart';

class DisplayService {
  const DisplayService({
    required this.preferences,
  });

  final AppSharedPreferences preferences;

  bool isDarkModeEnabled() => preferences.useDarkTheme();

  Future<void> toggleTheme() => preferences.toggleTheme();
}
