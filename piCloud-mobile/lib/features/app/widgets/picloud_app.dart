import 'package:app/common/auth/auth_manager.dart';
import 'package:app/common/preferences/app_shared_preferences.dart';
import 'package:app/features/app/router/app_router.gr.dart';
import 'package:app/features/app/router/guards/admin_guard.dart';
import 'package:app/features/app/themes/no_transitions.dart';
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
  late final _appRouter = AppRouter(
    adminGuard: AdminGuard(context.read<AuthManager>()),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      key: _navigatorKey,
      title: 'PICloud App',
      theme: _isDarkTheme() ? _getDarkTheme() : _getLightTheme(),
      routerDelegate: AutoRouterDelegate(
        _appRouter,
        navigatorObservers: () => [AutoRouteObserver()],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
    );
  }

  void switchTheme() => setState(() {
        context.read<AppSharedPreferences>().toggleTheme();
      });

  bool _isDarkTheme() => !context.read<AppSharedPreferences>().useDarkTheme();

  ThemeData _getDarkTheme() => ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue.shade900,
        // ignore: deprecated_member_use
        accentColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: NoTransitions(),
      );

  ThemeData _getLightTheme() => ThemeData(
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: NoTransitions(),
      );
}
