import 'dart:async';

import 'package:app/common/auth/auth_manager.dart';
import 'package:chopper/chopper.dart';

class AuthInterceptor extends RequestInterceptor {
  AuthInterceptor(this._authManager);

  final AuthManager _authManager;

  @override
  FutureOr<Request> onRequest(Request request) {
    return request.copyWith(
      headers: {
        ...request.headers,
        'Authorization': 'Bearer ${_authManager.getAccessToken()}'
      },
    );
  }
}
