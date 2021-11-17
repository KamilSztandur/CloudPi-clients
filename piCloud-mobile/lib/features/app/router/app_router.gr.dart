// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../../favourites_page/presentation/pages/favourites_page.dart' as _i3;
import '../../file_explorer/presentation/pages/file_explorer_page.dart' as _i4;
import '../../home_page/presentation/pages/home_page.dart' as _i1;
import '../../libraries_page/presentation/pages/libraries_page.dart' as _i5;
import '../../shared_page/presentation/pages/shared_page.dart' as _i2;
import '../../user_profile/presentation/pages/user_profile_page.dart' as _i6;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.HomePage(key: args.key));
    },
    SharedRoute.name: (routeData) {
      final args = routeData.argsAs<SharedRouteArgs>(
          orElse: () => const SharedRouteArgs());
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.SharedPage(key: args.key));
    },
    FavouritesRoute.name: (routeData) {
      final args = routeData.argsAs<FavouritesRouteArgs>(
          orElse: () => const FavouritesRouteArgs());
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.FavouritesPage(key: args.key));
    },
    FileExplorerRoute.name: (routeData) {
      final args = routeData.argsAs<FileExplorerRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.FileExplorerPage(key: args.key, path: args.path));
    },
    LibrariesRoute.name: (routeData) {
      final args = routeData.argsAs<LibrariesRouteArgs>(
          orElse: () => const LibrariesRouteArgs());
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.LibrariesPage(key: args.key));
    },
    UserProfileRoute.name: (routeData) {
      final args = routeData.argsAs<UserProfileRouteArgs>(
          orElse: () => const UserProfileRouteArgs());
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: _i6.UserProfilePage(key: args.key));
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(HomeRoute.name, path: '/'),
        _i7.RouteConfig(SharedRoute.name, path: '/shared-page'),
        _i7.RouteConfig(FavouritesRoute.name, path: '/favourites-page'),
        _i7.RouteConfig(FileExplorerRoute.name, path: '/file-explorer-page'),
        _i7.RouteConfig(LibrariesRoute.name, path: '/libraries-page'),
        _i7.RouteConfig(UserProfileRoute.name, path: '/user-profile-page')
      ];
}

/// generated route for [_i1.HomePage]
class HomeRoute extends _i7.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({_i8.Key? key})
      : super(name, path: '/', args: HomeRouteArgs(key: key));

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final _i8.Key? key;
}

/// generated route for [_i2.SharedPage]
class SharedRoute extends _i7.PageRouteInfo<SharedRouteArgs> {
  SharedRoute({_i8.Key? key})
      : super(name, path: '/shared-page', args: SharedRouteArgs(key: key));

  static const String name = 'SharedRoute';
}

class SharedRouteArgs {
  const SharedRouteArgs({this.key});

  final _i8.Key? key;
}

/// generated route for [_i3.FavouritesPage]
class FavouritesRoute extends _i7.PageRouteInfo<FavouritesRouteArgs> {
  FavouritesRoute({_i8.Key? key})
      : super(name,
            path: '/favourites-page', args: FavouritesRouteArgs(key: key));

  static const String name = 'FavouritesRoute';
}

class FavouritesRouteArgs {
  const FavouritesRouteArgs({this.key});

  final _i8.Key? key;
}

/// generated route for [_i4.FileExplorerPage]
class FileExplorerRoute extends _i7.PageRouteInfo<FileExplorerRouteArgs> {
  FileExplorerRoute({_i8.Key? key, required String path})
      : super(name,
            path: '/file-explorer-page',
            args: FileExplorerRouteArgs(key: key, path: path));

  static const String name = 'FileExplorerRoute';
}

class FileExplorerRouteArgs {
  const FileExplorerRouteArgs({this.key, required this.path});

  final _i8.Key? key;

  final String path;
}

/// generated route for [_i5.LibrariesPage]
class LibrariesRoute extends _i7.PageRouteInfo<LibrariesRouteArgs> {
  LibrariesRoute({_i8.Key? key})
      : super(name,
            path: '/libraries-page', args: LibrariesRouteArgs(key: key));

  static const String name = 'LibrariesRoute';
}

class LibrariesRouteArgs {
  const LibrariesRouteArgs({this.key});

  final _i8.Key? key;
}

/// generated route for [_i6.UserProfilePage]
class UserProfileRoute extends _i7.PageRouteInfo<UserProfileRouteArgs> {
  UserProfileRoute({_i8.Key? key})
      : super(name,
            path: '/user-profile-page', args: UserProfileRouteArgs(key: key));

  static const String name = 'UserProfileRoute';
}

class UserProfileRouteArgs {
  const UserProfileRouteArgs({this.key});

  final _i8.Key? key;
}
