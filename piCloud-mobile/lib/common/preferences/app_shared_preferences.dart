import 'package:app/common/models/view_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  const AppSharedPreferences(this._preferences);

  static const _preferredViewKey = 'preferredView';

  final SharedPreferences _preferences;

  ViewMode getPreferredViewMode() {
    return ViewModeSerialization.deserialize(
          _preferences.getString(_preferredViewKey),
        ) ??
        ViewMode.list;
  }

  void setPreferredViewMode(ViewMode viewMode) {
    _preferences.setString(_preferredViewKey, viewMode.serialize());
  }
}
