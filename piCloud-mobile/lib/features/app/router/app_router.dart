import 'package:app/features/admin_settings/presentation/pages/admin_settings_page.dart';
import 'package:app/features/admin_settings/presentation/pages/create_new_user_page.dart';
import 'package:app/features/app/router/guards/admin_guard.dart';
import 'package:app/features/favourites_page/presentation/pages/favourites_page.dart';
import 'package:app/features/file_explorer/presentation/pages/file_explorer_page.dart';
import 'package:app/features/home_page/presentation/pages/home_page.dart';
import 'package:app/features/libraries_page/presentation/pages/libraries_page.dart';
import 'package:app/features/shared_page/presentation/pages/shared_page.dart';
import 'package:app/features/user_profile/presentation/pages/user_profile_page.dart';
import 'package:auto_route/auto_route.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<void>(page: HomePage, initial: true),
    AutoRoute<void>(page: SharedPage),
    AutoRoute<void>(page: FavouritesPage),
    AutoRoute<void>(page: FileExplorerPage),
    AutoRoute<void>(page: LibrariesPage),
    AutoRoute<void>(page: UserProfilePage),
    AutoRoute<void>(
      page: AdminSettingsPage,
      fullscreenDialog: true,
      guards: [AdminGuard],
    ),
    AutoRoute<void>(
      page: CreateNewUserPage,
      fullscreenDialog: true,
      guards: [AdminGuard],
    ),
  ],
)
class $AppRouter {}
