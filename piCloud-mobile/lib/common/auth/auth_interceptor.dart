import 'dart:async';

import 'package:app/common/auth/auth_manager.dart';
import 'package:chopper/chopper.dart';

class AuthInterceptor extends RequestInterceptor {
  AuthInterceptor(this._authManager);

  final AuthManager _authManager;

  @override
  FutureOr<Request> onRequest(Request request) async {
    final token = await _authManager.getAccessToken();

    return request.copyWith(
      headers: {
        ...request.headers,
        'Authorization': 'Bearer $token',
      },
    );
  }
}
