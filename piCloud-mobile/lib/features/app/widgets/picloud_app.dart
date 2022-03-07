import 'package:app/common/auth/auth_manager.dart';
import 'package:app/features/app/router/app_router.gr.dart';
import 'package:app/features/app/router/guards/admin_guard.dart';
import 'package:app/features/app/themes/no_transitions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PICloudApp extends StatefulWidget {
  const PICloudApp({Key? key}) : super(key: key);

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: NoTransitions(),
      ),
      routerDelegate: AutoRouterDelegate(
        _appRouter,
        navigatorObservers: () => [AutoRouteObserver()],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
    );
  }
}
