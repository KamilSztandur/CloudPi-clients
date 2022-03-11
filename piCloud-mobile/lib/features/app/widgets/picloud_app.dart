import 'package:app/common/auth/auth_manager.dart';
import 'package:app/common/preferences/app_shared_preferences.dart';
import 'package:app/features/app/router/app_router.gr.dart';
import 'package:app/features/app/router/guards/admin_guard.dart';
import 'package:app/features/app/themes/themes_supplier.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PICloudApp extends StatefulWidget {
  const PICloudApp({Key? key}) : super(key: key);

  static _PICloudAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_PICloudAppState>();

  @override
  State<PICloudApp> createState() => _PICloudAppState();
}

class _PICloudAppState extends State<PICloudApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late AppRouter _appRouter;
  late AppSharedPreferences _preferences;

  @override
  void initState() {
    _appRouter = AppRouter(
      adminGuard: AdminGuard(context.read<AuthManager>()),
    );

    _preferences = context.read<AppSharedPreferences>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      key: _navigatorKey,
      title: 'PICloud App',
      theme: _isDarkTheme()
          ? ThemesSupplier.getDarkTheme()
          : ThemesSupplier.getLightTheme(),
      routerDelegate: AutoRouterDelegate(
        _appRouter,
        navigatorObservers: () => [AutoRouteObserver()],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
    );
  }

  bool _isDarkTheme() => _preferences.useDarkTheme();

  void switchTheme() => setState(() {
        _preferences.toggleTheme();
      });
}
