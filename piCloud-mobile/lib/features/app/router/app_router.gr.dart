// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;

import '../../favourites_page/presentation/pages/favourites_page.dart' as _i4;
import '../../file_explorer/presentation/pages/file_explorer_page.dart' as _i5;
import '../../home_page/presentation/pages/home_page.dart' as _i2;
import '../../libraries_page/presentation/pages/libraries_page.dart' as _i7;
import '../../login/presentation/pages/login_page.dart' as _i1;
import '../../media_reader/presentation/pages/media_reader_page.dart' as _i6;
import '../../search_page/presentation/pages/search_page.dart' as _i9;
import '../../settings/presentation/pages/cloud_settings_page.dart' as _i11;
import '../../settings/presentation/pages/settings_page.dart' as _i10;
import '../../shared_page/presentation/pages/shared_page.dart' as _i3;
import '../../user_profile/presentation/pages/user_profile_page.dart' as _i8;
import '../../user_wizard/data/models/user.dart' as _i16;
import '../../user_wizard/presentation/pages/user_wizard_page.dart' as _i12;
import 'guards/admin_guard.dart' as _i15;

class AppRouter extends _i13.RootStackRouter {
  AppRouter(
      {_i14.GlobalKey<_i14.NavigatorState>? navigatorKey,
      required this.adminGuard})
      : super(navigatorKey);

  final _i15.AdminGuard adminGuard;

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i13.MaterialPageX<void>(
          routeData: routeData, child: const _i1.LoginPage());
    },
    HomeRoute.name: (routeData) {
      return _i13.MaterialPageX<void>(
          routeData: routeData, child: const _i2.HomePage());
    },
    SharedRoute.name: (routeData) {
      return _i13.MaterialPageX<void>(
          routeData: routeData, child: const _i3.SharedPage());
    },
    FavouritesRoute.name: (routeData) {
      return _i13.MaterialPageX<void>(
          routeData: routeData, child: const _i4.FavouritesPage());
    },
    FileExplorerRoute.name: (routeData) {
      final args = routeData.argsAs<FileExplorerRouteArgs>();
      return _i13.MaterialPageX<void>(
          routeData: routeData,
          child: _i5.FileExplorerPage(key: args.key, path: args.path));
    },
    MediaReaderRoute.name: (routeData) {
      final args = routeData.argsAs<MediaReaderRouteArgs>();
      return _i13.MaterialPageX<void>(
          routeData: routeData,
          child: _i6.MediaReaderPage(
              key: args.key,
              path: args.path,
              resourceName: args.resourceName,
              resourcePubId: args.resourcePubId),
          fullscreenDialog: true);
    },
    LibrariesRoute.name: (routeData) {
      return _i13.MaterialPageX<void>(
          routeData: routeData, child: const _i7.LibrariesPage());
    },
    UserProfileRoute.name: (routeData) {
      return _i13.MaterialPageX<void>(
          routeData: routeData, child: const _i8.UserProfilePage());
    },
    SearchRoute.name: (routeData) {
      return _i13.MaterialPageX<void>(
          routeData: routeData,
          child: const _i9.SearchPage(),
          fullscreenDialog: true);
    },
    SettingsRoute.name: (routeData) {
      return _i13.MaterialPageX<void>(
          routeData: routeData,
          child: const _i10.SettingsPage(),
          fullscreenDialog: true);
    },
    CloudSettingsRoute.name: (routeData) {
      return _i13.MaterialPageX<void>(
          routeData: routeData,
          child: const _i11.CloudSettingsPage(),
          fullscreenDialog: true);
    },
    UserWizardRoute.name: (routeData) {
      final args = routeData.argsAs<UserWizardRouteArgs>(
          orElse: () => const UserWizardRouteArgs());
      return _i13.MaterialPageX<void>(
          routeData: routeData,
          child: _i12.UserWizardPage(key: args.key, user: args.user),
          fullscreenDialog: true);
    }
  };

  @override
  List<_i13.RouteConfig> get routes => [
        _i13.RouteConfig(LoginRoute.name, path: '/'),
        _i13.RouteConfig(HomeRoute.name, path: '/home-page'),
        _i13.RouteConfig(SharedRoute.name, path: '/shared-page'),
        _i13.RouteConfig(FavouritesRoute.name, path: '/favourites-page'),
        _i13.RouteConfig(FileExplorerRoute.name, path: '/file-explorer-page'),
        _i13.RouteConfig(MediaReaderRoute.name, path: '/media-reader-page'),
        _i13.RouteConfig(LibrariesRoute.name, path: '/libraries-page'),
        _i13.RouteConfig(UserProfileRoute.name, path: '/user-profile-page'),
        _i13.RouteConfig(SearchRoute.name, path: '/search-page'),
        _i13.RouteConfig(SettingsRoute.name, path: '/settings-page'),
        _i13.RouteConfig(CloudSettingsRoute.name,
            path: '/cloud-settings-page', guards: [adminGuard]),
        _i13.RouteConfig(UserWizardRoute.name,
            path: '/user-wizard-page', guards: [adminGuard])
      ];
}

/// generated route for [_i1.LoginPage]
class LoginRoute extends _i13.PageRouteInfo<void> {
  const LoginRoute() : super(name, path: '/');

  static const String name = 'LoginRoute';
}

/// generated route for [_i2.HomePage]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/home-page');

  static const String name = 'HomeRoute';
}

/// generated route for [_i3.SharedPage]
class SharedRoute extends _i13.PageRouteInfo<void> {
  const SharedRoute() : super(name, path: '/shared-page');

  static const String name = 'SharedRoute';
}

/// generated route for [_i4.FavouritesPage]
class FavouritesRoute extends _i13.PageRouteInfo<void> {
  const FavouritesRoute() : super(name, path: '/favourites-page');

  static const String name = 'FavouritesRoute';
}

/// generated route for [_i5.FileExplorerPage]
class FileExplorerRoute extends _i13.PageRouteInfo<FileExplorerRouteArgs> {
  FileExplorerRoute({_i14.Key? key, required String path})
      : super(name,
            path: '/file-explorer-page',
            args: FileExplorerRouteArgs(key: key, path: path));

  static const String name = 'FileExplorerRoute';
}

class FileExplorerRouteArgs {
  const FileExplorerRouteArgs({this.key, required this.path});

  final _i14.Key? key;

  final String path;
}

/// generated route for [_i6.MediaReaderPage]
class MediaReaderRoute extends _i13.PageRouteInfo<MediaReaderRouteArgs> {
  MediaReaderRoute(
      {_i14.Key? key,
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

  final _i14.Key? key;

  final String path;

  final String resourceName;

  final String? resourcePubId;
}

/// generated route for [_i7.LibrariesPage]
class LibrariesRoute extends _i13.PageRouteInfo<void> {
  const LibrariesRoute() : super(name, path: '/libraries-page');

  static const String name = 'LibrariesRoute';
}

/// generated route for [_i8.UserProfilePage]
class UserProfileRoute extends _i13.PageRouteInfo<void> {
  const UserProfileRoute() : super(name, path: '/user-profile-page');

  static const String name = 'UserProfileRoute';
}

/// generated route for [_i9.SearchPage]
class SearchRoute extends _i13.PageRouteInfo<void> {
  const SearchRoute() : super(name, path: '/search-page');

  static const String name = 'SearchRoute';
}

/// generated route for [_i10.SettingsPage]
class SettingsRoute extends _i13.PageRouteInfo<void> {
  const SettingsRoute() : super(name, path: '/settings-page');

  static const String name = 'SettingsRoute';
}

/// generated route for [_i11.CloudSettingsPage]
class CloudSettingsRoute extends _i13.PageRouteInfo<void> {
  const CloudSettingsRoute() : super(name, path: '/cloud-settings-page');

  static const String name = 'CloudSettingsRoute';
}

/// generated route for [_i12.UserWizardPage]
class UserWizardRoute extends _i13.PageRouteInfo<UserWizardRouteArgs> {
  UserWizardRoute({_i14.Key? key, _i16.User? user})
      : super(name,
            path: '/user-wizard-page',
            args: UserWizardRouteArgs(key: key, user: user));

  static const String name = 'UserWizardRoute';
}

class UserWizardRouteArgs {
  const UserWizardRouteArgs({this.key, this.user});

  final _i14.Key? key;

  final _i16.User? user;
}
