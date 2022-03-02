import 'dart:convert';

import 'package:app/common/core/config.dart';
import 'package:app/contracts/api.swagger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rxdart/rxdart.dart';

class AuthManager {
  AuthManager(this._storage);

  static const accessTokenKey = 'accessToken';
  static const refreshTokenKey = 'refreshToken';

  final FlutterSecureStorage _storage;

  BehaviorSubject<bool>? _loggedInSubject;

  ValueStream<bool> get loggedIn =>
      _loggedInSubject?.stream ?? BehaviorSubject<bool>.seeded(false).stream;

  Future<void> init() async {
    final accessToken = await getAccessToken();

    _loggedInSubject = BehaviorSubject<bool>.seeded(accessToken != null);
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    final result = await http.post(
      Uri.parse('${Config.apiBaseUrl}/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        LoginRequest(
          username: username,
          password: password,
        ).toJson(),
      ),
    );

    if (result.statusCode != 200) {
      return;
    }

    final accessToken = _extractAccessToken(result.headers);
    final refreshToken = _extractRefreshToken(result.headers);

    await _storage.write(key: accessTokenKey, value: accessToken);
    await _storage.write(key: refreshTokenKey, value: refreshToken);

    _loggedInSubject?.add(true);
  }

  Future<String?> getAccessToken() async {
    final encodedToken = await _storage.read(key: accessTokenKey);

    if (encodedToken == null) {
      return null;
    }

    final token = JwtDecoder.decode(encodedToken);

    final expiration =
        DateTime.fromMillisecondsSinceEpoch((token['exp'] as int) * 1000);

    if (DateTime.now().isAfter(expiration)) {
      final accessTokenRefreshed = await _refreshAccessToken();
      final refreshTokenRefreshed = await _refreshRefreshToken();

      if (!accessTokenRefreshed || !refreshTokenRefreshed) {
        await logout();

        return null;
      }

      return getAccessToken();
    }

    return encodedToken;
  }

  Future<bool> _refreshAccessToken() async {
    final encodedAccessToken = await _storage.read(key: accessTokenKey);
    final encodedRefreshToken = await _storage.read(key: refreshTokenKey);

    if (encodedRefreshToken == null) {
      return false;
    }

    final refreshToken = JwtDecoder.decode(encodedRefreshToken);

    final expiration = DateTime.fromMillisecondsSinceEpoch(
      (int.parse(refreshToken['exp'].toString())) * 1000,
    );

    if (DateTime.now().isAfter(expiration)) {
      return false;
    }

    final result = await http.post(
      Uri.parse('${Config.apiBaseUrl}/refresh/auth-token'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $encodedAccessToken',
        'Cookie': 'Refresh-Token=$encodedRefreshToken'
      },
    );

    if (result.statusCode != 200) {
      return false;
    }

    final newAccessToken = _extractAccessToken(result.headers);

    await _storage.write(key: accessTokenKey, value: newAccessToken);

    return true;
  }

  Future<bool> _refreshRefreshToken() async {
    final encodedAccessToken = await _storage.read(key: accessTokenKey);
    final encodedRefreshToken = await _storage.read(key: refreshTokenKey);

    if (encodedRefreshToken == null) {
      return false;
    }

    final refreshToken = JwtDecoder.decode(encodedRefreshToken);

    final expiration = DateTime.fromMillisecondsSinceEpoch(
      (refreshToken['exp'] as int) * 1000,
    );

    if (DateTime.now().isAfter(expiration)) {
      return false;
    }

    final result = await http.post(
      Uri.parse('${Config.apiBaseUrl}/refresh/refresh-token'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $encodedAccessToken',
        'Cookie': 'Refresh-Token=$encodedRefreshToken'
      },
    );

    if (result.statusCode != 200) {
      return false;
    }

    final newRefreshToken = _extractRefreshToken(result.headers);

    await _storage.write(key: refreshTokenKey, value: newRefreshToken);

    return true;
  }

  String _extractAccessToken(Map<String, String> headers) =>
      headers['authorization']!;

  String _extractRefreshToken(Map<String, String> headers) {
    final refreshTokenSetCookie = headers['set-cookie']!;
    return refreshTokenSetCookie.substring(
      'Refresh-Token='.length,
      refreshTokenSetCookie.indexOf(';'),
    );
  }

  Future<void> logout() async {
    _loggedInSubject?.add(false);

    await _storage.delete(key: accessTokenKey);
    await _storage.delete(key: refreshTokenKey);
  }

  Future<String?> getUsernameOfLoggedUser() async {
    final encodedToken = await _storage.read(key: accessTokenKey);

    if (encodedToken == null) {
      return null;
    }

    final token = JwtDecoder.decode(encodedToken);
    return token['sub'] as String;
  }
}
