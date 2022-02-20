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

    final accessToken = result.headers['authorization']!;
    final refreshTokenSetCookie = result.headers['set-cookie']!;
    final refreshToken = refreshTokenSetCookie.substring(
      'Refresh-Token='.length,
      refreshTokenSetCookie.indexOf(';'),
    );

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
      final refreshedToken = await _refreshToken();

      if (refreshedToken == null) {
        await logout();

        return null;
      }

      await _storage.write(key: accessTokenKey, value: refreshedToken);

      return refreshedToken;
    }

    return encodedToken;
  }

  Future<String?> _refreshToken() async {
    final encodedToken = await _storage.read(key: refreshTokenKey);

    if (encodedToken == null) {
      return null;
    }

    final token = JwtDecoder.decode(encodedToken);

    final expiration = DateTime.parse(token['exp'].toString());

    if (DateTime.now().isAfter(expiration)) {
      await logout();

      return null;
    }

    // TODO: Refresh token

    return '';
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
