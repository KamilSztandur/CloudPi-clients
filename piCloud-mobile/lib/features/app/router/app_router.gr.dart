// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;

import '../../create_new_user/presentation/pages/create_new_user_page.dart'
    as _i9;
import '../../favourites_page/presentation/pages/favourites_page.dart' as _i3;
import '../../file_explorer/presentation/pages/file_explorer_page.dart' as _i4;
import '../../home_page/presentation/pages/home_page.dart' as _i1;
import '../../libraries_page/presentation/pages/libraries_page.dart' as _i5;
import '../../settings/presentation/pages/cloud_settings_page.dart' as _i8;
import '../../settings/presentation/pages/settings_page.dart' as _i7;
import '../../shared_page/presentation/pages/shared_page.dart' as _i2;
import '../../user_profile/presentation/pages/user_profile_page.dart' as _i6;
import 'guards/admin_guard.dart' as _i12;

class AppRouter extends _i10.RootStackRouter {
  AppRouter(
      {_i11.GlobalKey<_i11.NavigatorState>? navigatorKey,
      required this.adminGuard})
      : super(navigatorKey);

  final _i12.AdminGuard adminGuard;

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i10.MaterialPageX<void>(
          routeData: routeData, child: const _i1.HomePage());
    },
    SharedRoute.name: (routeData) {
      return _i10.MaterialPageX<void>(
          routeData: routeData, child: const _i2.SharedPage());
    },
    FavouritesRoute.name: (routeData) {
      return _i10.MaterialPageX<void>(
          routeData: routeData, child: const _i3.FavouritesPage());
    },
    FileExplorerRoute.name: (routeData) {
      final args = routeData.argsAs<FileExplorerRouteArgs>();
      return _i10.MaterialPageX<void>(
          routeData: routeData,
          child: _i4.FileExplorerPage(key: args.key, path: args.path));
    },
    LibrariesRoute.name: (routeData) {
      return _i10.MaterialPageX<void>(
          routeData: routeData, child: const _i5.LibrariesPage());
    },
    UserProfileRoute.name: (routeData) {
      return _i10.MaterialPageX<void>(
          routeData: routeData, child: const _i6.UserProfilePage());
    },
    SettingsRoute.name: (routeData) {
      return _i10.MaterialPageX<void>(
          routeData: routeData,
          child: const _i7.SettingsPage(),
          fullscreenDialog: true);
    },
    CloudSettingsRoute.name: (routeData) {
      return _i10.MaterialPageX<void>(
          routeData: routeData,
          child: const _i8.CloudSettingsPage(),
          fullscreenDialog: true);
    },
    CreateNewUserRoute.name: (routeData) {
      return _i10.MaterialPageX<void>(
          routeData: routeData,
          child: const _i9.CreateNewUserPage(),
          fullscreenDialog: true);
    }
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(HomeRoute.name, path: '/'),
        _i10.RouteConfig(SharedRoute.name, path: '/shared-page'),
        _i10.RouteConfig(FavouritesRoute.name, path: '/favourites-page'),
        _i10.RouteConfig(FileExplorerRoute.name, path: '/file-explorer-page'),
        _i10.RouteConfig(LibrariesRoute.name, path: '/libraries-page'),
        _i10.RouteConfig(UserProfileRoute.name, path: '/user-profile-page'),
        _i10.RouteConfig(SettingsRoute.name, path: '/settings-page'),
        _i10.RouteConfig(CloudSettingsRoute.name,
            path: '/cloud-settings-page', guards: [adminGuard]),
        _i10.RouteConfig(CreateNewUserRoute.name,
            path: '/create-new-user-page', guards: [adminGuard])
      ];
}

/// generated route for [_i1.HomePage]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for [_i2.SharedPage]
class SharedRoute extends _i10.PageRouteInfo<void> {
  const SharedRoute() : super(name, path: '/shared-page');

  static const String name = 'SharedRoute';
}

/// generated route for [_i3.FavouritesPage]
class FavouritesRoute extends _i10.PageRouteInfo<void> {
  const FavouritesRoute() : super(name, path: '/favourites-page');

  static const String name = 'FavouritesRoute';
}

/// generated route for [_i4.FileExplorerPage]
class FileExplorerRoute extends _i10.PageRouteInfo<FileExplorerRouteArgs> {
  FileExplorerRoute({_i11.Key? key, required String path})
      : super(name,
            path: '/file-explorer-page',
            args: FileExplorerRouteArgs(key: key, path: path));

  static const String name = 'FileExplorerRoute';
}

class FileExplorerRouteArgs {
  const FileExplorerRouteArgs({this.key, required this.path});

  final _i11.Key? key;

  final String path;
}

/// generated route for [_i5.LibrariesPage]
class LibrariesRoute extends _i10.PageRouteInfo<void> {
  const LibrariesRoute() : super(name, path: '/libraries-page');

  static const String name = 'LibrariesRoute';
}

/// generated route for [_i6.UserProfilePage]
class UserProfileRoute extends _i10.PageRouteInfo<void> {
  const UserProfileRoute() : super(name, path: '/user-profile-page');

  static const String name = 'UserProfileRoute';
}

/// generated route for [_i7.SettingsPage]
class SettingsRoute extends _i10.PageRouteInfo<void> {
  const SettingsRoute() : super(name, path: '/settings-page');

  static const String name = 'SettingsRoute';
}

/// generated route for [_i8.CloudSettingsPage]
class CloudSettingsRoute extends _i10.PageRouteInfo<void> {
  const CloudSettingsRoute() : super(name, path: '/cloud-settings-page');

  static const String name = 'CloudSettingsRoute';
}

/// generated route for [_i9.CreateNewUserPage]
class CreateNewUserRoute extends _i10.PageRouteInfo<void> {
  const CreateNewUserRoute() : super(name, path: '/create-new-user-page');

  static const String name = 'CreateNewUserRoute';
}
