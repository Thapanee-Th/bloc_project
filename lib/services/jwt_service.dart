import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JwtService {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'jwt_token';

  static Future<void> saveToken(String token) async =>
      await _storage.write(key: _tokenKey, value: token);

  static Future<String?> getToken() async =>
      await _storage.read(key: _tokenKey);

  static Future<void> clearToken() async =>
      await _storage.delete(key: _tokenKey);
}
