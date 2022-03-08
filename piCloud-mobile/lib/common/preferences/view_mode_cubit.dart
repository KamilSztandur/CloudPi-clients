import 'package:app/common/models/view_mode.dart';
import 'package:app/common/preferences/app_shared_preferences.dart';
import 'package:bloc/bloc.dart';

class ViewModeCubit extends Cubit<ViewMode> {
  ViewModeCubit(this._preferences) : super(ViewMode.tile);

  final AppSharedPreferences _preferences;

  void init() {
    emit(_preferences.getPreferredViewMode());
  }

  void setViewMode(ViewMode viewMode) {
    _preferences.setPreferredViewMode(viewMode);

    emit(viewMode);
  }

  void toggleViewMode() {
    setViewMode(state == ViewMode.list ? ViewMode.tile : ViewMode.list);
  }
}
