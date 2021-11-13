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
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: SharedPage),
    AutoRoute(page: FavouritesPage),
    AutoRoute(page: FileExplorerPage),
    AutoRoute(page: LibrariesPage),
    AutoRoute(page: UserProfilePage),
  ],
)
class $AppRouter {}
