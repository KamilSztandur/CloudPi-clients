// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;

import '../../favourites_page/presentation/pages/favourites_page.dart' as _i4;
import '../../file_explorer/presentation/pages/file_explorer_page.dart' as _i5;
import '../../home_page/presentation/pages/home_page.dart' as _i2;
import '../../libraries_page/presentation/pages/libraries_page.dart' as _i6;
import '../../login/presentation/pages/login_page.dart' as _i1;
import '../../settings/presentation/pages/cloud_settings_page.dart' as _i9;
import '../../settings/presentation/pages/settings_page.dart' as _i8;
import '../../shared_page/presentation/pages/shared_page.dart' as _i3;
import '../../user_profile/presentation/pages/user_profile_page.dart' as _i7;
import '../../user_wizard/data/models/user.dart' as _i14;
import '../../user_wizard/presentation/pages/user_wizard_page.dart' as _i10;
import 'guards/admin_guard.dart' as _i13;

class AppRouter extends _i11.RootStackRouter {
  AppRouter(
      {_i12.GlobalKey<_i12.NavigatorState>? navigatorKey,
      required this.adminGuard})
      : super(navigatorKey);

  final _i13.AdminGuard adminGuard;

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i1.LoginPage());
    },
    HomeRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i2.HomePage());
    },
    SharedRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i3.SharedPage());
    },
    FavouritesRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i4.FavouritesPage());
    },
    FileExplorerRoute.name: (routeData) {
      final args = routeData.argsAs<FileExplorerRouteArgs>();
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: _i5.FileExplorerPage(key: args.key, path: args.path));
    },
    LibrariesRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData, child: const _i6.LibrariesPage());
    },
    UserProfileRoute.name: (routeData) {
      final args = routeData.argsAs<UserProfilePageRouteArgs>();
      return _i11.MaterialPageX<void>(
        routeData: routeData,
        child: _i7.UserProfilePage(
          key: args.key,
          username: args.username,
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: const _i8.SettingsPage(),
          fullscreenDialog: true);
    },
    CloudSettingsRoute.name: (routeData) {
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: const _i9.CloudSettingsPage(),
          fullscreenDialog: true);
    },
    UserWizardRoute.name: (routeData) {
      final args = routeData.argsAs<UserWizardRouteArgs>(
          orElse: () => const UserWizardRouteArgs());
      return _i11.MaterialPageX<void>(
          routeData: routeData,
          child: _i10.UserWizardPage(key: args.key, user: args.user),
          fullscreenDialog: true);
    }
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(LoginRoute.name, path: '/'),
        _i11.RouteConfig(HomeRoute.name, path: '/home-page'),
        _i11.RouteConfig(SharedRoute.name, path: '/shared-page'),
        _i11.RouteConfig(FavouritesRoute.name, path: '/favourites-page'),
        _i11.RouteConfig(FileExplorerRoute.name, path: '/file-explorer-page'),
        _i11.RouteConfig(LibrariesRoute.name, path: '/libraries-page'),
        _i11.RouteConfig(UserProfileRoute.name, path: '/user-profile-page'),
        _i11.RouteConfig(SettingsRoute.name, path: '/settings-page'),
        _i11.RouteConfig(CloudSettingsRoute.name,
            path: '/cloud-settings-page', guards: [adminGuard]),
        _i11.RouteConfig(UserWizardRoute.name,
            path: '/user-wizard-page', guards: [adminGuard])
      ];
}

/// generated route for [_i1.LoginPage]
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute() : super(name, path: '/');

  static const String name = 'LoginRoute';
}

/// generated route for [_i2.HomePage]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/home-page');

  static const String name = 'HomeRoute';
}

/// generated route for [_i3.SharedPage]
class SharedRoute extends _i11.PageRouteInfo<void> {
  const SharedRoute() : super(name, path: '/shared-page');

  static const String name = 'SharedRoute';
}

/// generated route for [_i4.FavouritesPage]
class FavouritesRoute extends _i11.PageRouteInfo<void> {
  const FavouritesRoute() : super(name, path: '/favourites-page');

  static const String name = 'FavouritesRoute';
}

/// generated route for [_i5.FileExplorerPage]
class FileExplorerRoute extends _i11.PageRouteInfo<FileExplorerRouteArgs> {
  FileExplorerRoute({_i12.Key? key, required String path})
      : super(name,
            path: '/file-explorer-page',
            args: FileExplorerRouteArgs(key: key, path: path));

  static const String name = 'FileExplorerRoute';
}

class FileExplorerRouteArgs {
  const FileExplorerRouteArgs({this.key, required this.path});

  final _i12.Key? key;

  final String path;
}

/// generated route for [_i6.LibrariesPage]
class LibrariesRoute extends _i11.PageRouteInfo<void> {
  const LibrariesRoute() : super(name, path: '/libraries-page');

  static const String name = 'LibrariesRoute';
}

/// generated route for [_i7.UserProfilePage]
class UserProfileRoute extends _i11.PageRouteInfo<UserProfilePageRouteArgs> {
  UserProfileRoute({_i12.Key? key, required String username})
      : super(name,
            path: '/user-profile-page',
            args: UserProfilePageRouteArgs(key: key, username: username));

  static const String name = 'UserProfileRoute';
}

class UserProfilePageRouteArgs {
  const UserProfilePageRouteArgs({this.key, required this.username});

  final _i12.Key? key;

  final String username;
}

/// generated route for [_i8.SettingsPage]
class SettingsRoute extends _i11.PageRouteInfo<void> {
  const SettingsRoute() : super(name, path: '/settings-page');

  static const String name = 'SettingsRoute';
}

/// generated route for [_i9.CloudSettingsPage]
class CloudSettingsRoute extends _i11.PageRouteInfo<void> {
  const CloudSettingsRoute() : super(name, path: '/cloud-settings-page');

  static const String name = 'CloudSettingsRoute';
}

/// generated route for [_i10.UserWizardPage]
class UserWizardRoute extends _i11.PageRouteInfo<UserWizardRouteArgs> {
  UserWizardRoute({_i12.Key? key, _i14.User? user})
      : super(name,
            path: '/user-wizard-page',
            args: UserWizardRouteArgs(key: key, user: user));

  static const String name = 'UserWizardRoute';
}

class UserWizardRouteArgs {
  const UserWizardRouteArgs({this.key, this.user});

  final _i12.Key? key;

  final _i14.User? user;
}
