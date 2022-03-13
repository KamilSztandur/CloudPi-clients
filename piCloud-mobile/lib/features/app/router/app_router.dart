import 'package:app/features/app/router/guards/admin_guard.dart';
import 'package:app/features/favorites_page/presentation/pages/favorites_page.dart';
import 'package:app/features/file_explorer/presentation/pages/file_explorer_page.dart';
import 'package:app/features/login/presentation/pages/login_page.dart';
import 'package:app/features/media_reader/presentation/pages/media_reader_page.dart';
import 'package:app/features/search_page/presentation/pages/search_page.dart';
import 'package:app/features/settings/presentation/pages/cloud_settings_page.dart';
import 'package:app/features/settings/presentation/pages/settings_page.dart';
import 'package:app/features/shared_page/presentation/pages/shared_page.dart';
import 'package:app/features/user_profile/presentation/pages/user_profile_page.dart';
import 'package:app/features/user_wizard/presentation/pages/user_wizard_page.dart';
import 'package:auto_route/auto_route.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<void>(page: LoginPage, initial: true),
    AutoRoute<void>(page: SharedPage),
    AutoRoute<void>(page: FavoritesPage),
    AutoRoute<void>(page: FileExplorerPage),
    AutoRoute<void>(
      page: MediaReaderPage,
      fullscreenDialog: true,
    ),
    AutoRoute<void>(page: UserProfilePage),
    AutoRoute<void>(
      page: SearchPage,
      fullscreenDialog: true,
    ),
    AutoRoute<void>(
      page: SettingsPage,
      fullscreenDialog: true,
    ),
    AutoRoute<void>(
      page: CloudSettingsPage,
      fullscreenDialog: true,
      guards: [AdminGuard],
    ),
    AutoRoute<void>(
      page: UserWizardPage,
      fullscreenDialog: true,
      guards: [AdminGuard],
    ),
  ],
)
class $AppRouter {}
