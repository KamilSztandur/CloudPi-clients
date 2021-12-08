import 'package:auto_route/auto_route.dart';

class AdminGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuthenticated = _isAuthenticated();

    if (isAuthenticated) {
      resolver.next();
    }
  }

  bool _isAuthenticated() {
    // TODO

    return true;
  }
}
