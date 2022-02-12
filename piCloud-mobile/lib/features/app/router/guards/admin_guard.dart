import 'package:app/common/auth/auth_manager.dart';
import 'package:auto_route/auto_route.dart';

class AdminGuard extends AutoRouteGuard {
  AdminGuard(this._authManager);

  final AuthManager _authManager;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuthenticated = _isAuthenticated();

    if (isAuthenticated) {
      resolver.next();
    }
  }

  bool _isAuthenticated() => _authManager.loggedIn.value;
}
