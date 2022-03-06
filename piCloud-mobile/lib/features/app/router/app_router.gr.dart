// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;

import '../../favourites_page/presentation/pages/favourites_page.dart' as _i4;
import '../../file_explorer/presentation/pages/file_explorer_page.dart' as _i5;
import '../../home_page/presentation/pages/home_page.dart' as _i2;
import '../../libraries_page/presentation/pages/libraries_page.dart' as _i7;
import '../../login/presentation/pages/login_page.dart' as _i1;
import '../../media_reader/presentation/pages/media_reader_page.dart' as _i6;
import '../../settings/presentation/pages/cloud_settings_page.dart' as _i10;
import '../../settings/presentation/pages/settings_page.dart' as _i9;
import '../../shared_page/presentation/pages/shared_page.dart' as _i3;
import '../../user_profile/presentation/pages/user_profile_page.dart' as _i8;
import '../../user_wizard/data/models/user.dart' as _i15;
import '../../user_wizard/presentation/pages/user_wizard_page.dart' as _i11;
import 'guards/admin_guard.dart' as _i14;

class AppRouter extends _i12.RootStackRouter {
  AppRouter(
      {_i13.GlobalKey<_i13.NavigatorState>? navigatorKey,
      required this.adminGuard})
      : super(navigatorKey);

  final _i14.AdminGuard adminGuard;

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i1.LoginPage());
    },
    HomeRoute.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i2.HomePage());
    },
    SharedRoute.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i3.SharedPage());
    },
    FavouritesRoute.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i4.FavouritesPage());
    },
    FileExplorerRoute.name: (routeData) {
      final args = routeData.argsAs<FileExplorerRouteArgs>();
      return _i12.MaterialPageX<void>(
          routeData: routeData,
          child: _i5.FileExplorerPage(key: args.key, path: args.path));
    },
    MediaReaderRoute.name: (routeData) {
      final args = routeData.argsAs<MediaReaderRouteArgs>();
      return _i12.MaterialPageX<void>(
          routeData: routeData,
          child: _i6.MediaReaderPage(
              key: args.key,
              path: args.path,
              resourceName: args.resourceName,
              resourcePubId: args.resourcePubId),
          fullscreenDialog: true);
    },
    LibrariesRoute.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i7.LibrariesPage());
    },
    UserProfileRoute.name: (routeData) {
      final args = routeData.argsAs<UserProfileRouteArgs>();
      return _i12.MaterialPageX<void>(
          routeData: routeData,
          child: _i8.UserProfilePage(key: args.key, username: args.username));
    },
    SettingsRoute.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData,
          child: const _i9.SettingsPage(),
          fullscreenDialog: true);
    },
    CloudSettingsRoute.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData,
          child: const _i10.CloudSettingsPage(),
          fullscreenDialog: true);
    },
    UserWizardRoute.name: (routeData) {
      final args = routeData.argsAs<UserWizardRouteArgs>(
          orElse: () => const UserWizardRouteArgs());
      return _i12.MaterialPageX<void>(
          routeData: routeData,
          child: _i11.UserWizardPage(key: args.key, user: args.user),
          fullscreenDialog: true);
    }
  };

  @override
  List<_i12.RouteConfig> get routes => [
        _i12.RouteConfig(LoginRoute.name, path: '/'),
        _i12.RouteConfig(HomeRoute.name, path: '/home-page'),
        _i12.RouteConfig(SharedRoute.name, path: '/shared-page'),
        _i12.RouteConfig(FavouritesRoute.name, path: '/favourites-page'),
        _i12.RouteConfig(FileExplorerRoute.name, path: '/file-explorer-page'),
        _i12.RouteConfig(MediaReaderRoute.name, path: '/media-reader-page'),
        _i12.RouteConfig(LibrariesRoute.name, path: '/libraries-page'),
        _i12.RouteConfig(UserProfileRoute.name, path: '/user-profile-page'),
        _i12.RouteConfig(SettingsRoute.name, path: '/settings-page'),
        _i12.RouteConfig(CloudSettingsRoute.name,
            path: '/cloud-settings-page', guards: [adminGuard]),
        _i12.RouteConfig(UserWizardRoute.name,
            path: '/user-wizard-page', guards: [adminGuard])
      ];
}

/// generated route for [_i1.LoginPage]
class LoginRoute extends _i12.PageRouteInfo<void> {
  const LoginRoute() : super(name, path: '/');

  static const String name = 'LoginRoute';
}

/// generated route for [_i2.HomePage]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/home-page');

  static const String name = 'HomeRoute';
}

/// generated route for [_i3.SharedPage]
class SharedRoute extends _i12.PageRouteInfo<void> {
  const SharedRoute() : super(name, path: '/shared-page');

  static const String name = 'SharedRoute';
}

/// generated route for [_i4.FavouritesPage]
class FavouritesRoute extends _i12.PageRouteInfo<void> {
  const FavouritesRoute() : super(name, path: '/favourites-page');

  static const String name = 'FavouritesRoute';
}

/// generated route for [_i5.FileExplorerPage]
class FileExplorerRoute extends _i12.PageRouteInfo<FileExplorerRouteArgs> {
  FileExplorerRoute({_i13.Key? key, required String path})
      : super(name,
            path: '/file-explorer-page',
            args: FileExplorerRouteArgs(key: key, path: path));

  static const String name = 'FileExplorerRoute';
}

class FileExplorerRouteArgs {
  const FileExplorerRouteArgs({this.key, required this.path});

  final _i13.Key? key;

  final String path;
}

/// generated route for [_i6.MediaReaderPage]
class MediaReaderRoute extends _i12.PageRouteInfo<MediaReaderRouteArgs> {
  MediaReaderRoute(
      {_i13.Key? key,
      required String path,
      required String resourceName,
      required String? resourcePubId})
      : super(name,
            path: '/media-reader-page',
            args: MediaReaderRouteArgs(
                key: key,
                path: path,
                resourceName: resourceName,
                resourcePubId: resourcePubId));

  static const String name = 'MediaReaderRoute';
}

class MediaReaderRouteArgs {
  const MediaReaderRouteArgs(
      {this.key,
      required this.path,
      required this.resourceName,
      required this.resourcePubId});

  final _i13.Key? key;

  final String path;

  final String resourceName;

  final String? resourcePubId;
}

/// generated route for [_i7.LibrariesPage]
class LibrariesRoute extends _i12.PageRouteInfo<void> {
  const LibrariesRoute() : super(name, path: '/libraries-page');

  static const String name = 'LibrariesRoute';
}

/// generated route for [_i8.UserProfilePage]
class UserProfileRoute extends _i12.PageRouteInfo<UserProfileRouteArgs> {
  UserProfileRoute({_i13.Key? key, required String username})
      : super(name,
            path: '/user-profile-page',
            args: UserProfileRouteArgs(key: key, username: username));

  static const String name = 'UserProfileRoute';
}

class UserProfileRouteArgs {
  const UserProfileRouteArgs({this.key, required this.username});

  final _i13.Key? key;

  final String username;
}

/// generated route for [_i9.SettingsPage]
class SettingsRoute extends _i12.PageRouteInfo<void> {
  const SettingsRoute() : super(name, path: '/settings-page');

  static const String name = 'SettingsRoute';
}

/// generated route for [_i10.CloudSettingsPage]
class CloudSettingsRoute extends _i12.PageRouteInfo<void> {
  const CloudSettingsRoute() : super(name, path: '/cloud-settings-page');

  static const String name = 'CloudSettingsRoute';
}

/// generated route for [_i11.UserWizardPage]
class UserWizardRoute extends _i12.PageRouteInfo<UserWizardRouteArgs> {
  UserWizardRoute({_i13.Key? key, _i15.User? user})
      : super(name,
            path: '/user-wizard-page',
            args: UserWizardRouteArgs(key: key, user: user));

  static const String name = 'UserWizardRoute';
}

class UserWizardRouteArgs {
  const UserWizardRouteArgs({this.key, this.user});

  final _i13.Key? key;

  final _i15.User? user;
}
