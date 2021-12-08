// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../../admin_settings/presentation/pages/admin_settings_page.dart'
    as _i7;
import '../../favourites_page/presentation/pages/favourites_page.dart' as _i3;
import '../../file_explorer/presentation/pages/file_explorer_page.dart' as _i4;
import '../../home_page/presentation/pages/home_page.dart' as _i1;
import '../../libraries_page/presentation/pages/libraries_page.dart' as _i5;
import '../../shared_page/presentation/pages/shared_page.dart' as _i2;
import '../../user_profile/presentation/pages/user_profile_page.dart' as _i6;
import 'guards/admin_guard.dart' as _i10;

class AppRouter extends _i8.RootStackRouter {
  AppRouter(
      {_i9.GlobalKey<_i9.NavigatorState>? navigatorKey,
      required this.adminGuard})
      : super(navigatorKey);

  final _i10.AdminGuard adminGuard;

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i8.MaterialPageX<void>(
          routeData: routeData, child: const _i1.HomePage());
    },
    SharedRoute.name: (routeData) {
      return _i8.MaterialPageX<void>(
          routeData: routeData, child: const _i2.SharedPage());
    },
    FavouritesRoute.name: (routeData) {
      return _i8.MaterialPageX<void>(
          routeData: routeData, child: const _i3.FavouritesPage());
    },
    FileExplorerRoute.name: (routeData) {
      final args = routeData.argsAs<FileExplorerRouteArgs>();
      return _i8.MaterialPageX<void>(
          routeData: routeData,
          child: _i4.FileExplorerPage(key: args.key, path: args.path));
    },
    LibrariesRoute.name: (routeData) {
      return _i8.MaterialPageX<void>(
          routeData: routeData, child: const _i5.LibrariesPage());
    },
    UserProfileRoute.name: (routeData) {
      return _i8.MaterialPageX<void>(
          routeData: routeData, child: const _i6.UserProfilePage());
    },
    AdminSettingsRoute.name: (routeData) {
      return _i8.MaterialPageX<void>(
          routeData: routeData,
          child: const _i7.AdminSettingsPage(),
          fullscreenDialog: true);
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(HomeRoute.name, path: '/'),
        _i8.RouteConfig(SharedRoute.name, path: '/shared-page'),
        _i8.RouteConfig(FavouritesRoute.name, path: '/favourites-page'),
        _i8.RouteConfig(FileExplorerRoute.name, path: '/file-explorer-page'),
        _i8.RouteConfig(LibrariesRoute.name, path: '/libraries-page'),
        _i8.RouteConfig(UserProfileRoute.name, path: '/user-profile-page'),
        _i8.RouteConfig(AdminSettingsRoute.name,
            path: '/admin-settings-page', guards: [adminGuard])
      ];
}

/// generated route for [_i1.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for [_i2.SharedPage]
class SharedRoute extends _i8.PageRouteInfo<void> {
  const SharedRoute() : super(name, path: '/shared-page');

  static const String name = 'SharedRoute';
}

/// generated route for [_i3.FavouritesPage]
class FavouritesRoute extends _i8.PageRouteInfo<void> {
  const FavouritesRoute() : super(name, path: '/favourites-page');

  static const String name = 'FavouritesRoute';
}

/// generated route for [_i4.FileExplorerPage]
class FileExplorerRoute extends _i8.PageRouteInfo<FileExplorerRouteArgs> {
  FileExplorerRoute({_i9.Key? key, required String path})
      : super(name,
            path: '/file-explorer-page',
            args: FileExplorerRouteArgs(key: key, path: path));

  static const String name = 'FileExplorerRoute';
}

class FileExplorerRouteArgs {
  const FileExplorerRouteArgs({this.key, required this.path});

  final _i9.Key? key;

  final String path;
}

/// generated route for [_i5.LibrariesPage]
class LibrariesRoute extends _i8.PageRouteInfo<void> {
  const LibrariesRoute() : super(name, path: '/libraries-page');

  static const String name = 'LibrariesRoute';
}

/// generated route for [_i6.UserProfilePage]
class UserProfileRoute extends _i8.PageRouteInfo<void> {
  const UserProfileRoute() : super(name, path: '/user-profile-page');

  static const String name = 'UserProfileRoute';
}

/// generated route for [_i7.AdminSettingsPage]
class AdminSettingsRoute extends _i8.PageRouteInfo<void> {
  const AdminSettingsRoute() : super(name, path: '/admin-settings-page');

  static const String name = 'AdminSettingsRoute';
}
