import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final _storage = const FlutterSecureStorage();

  // Сохраняем секретный ключ (JWT)
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  // Читаем ключ
  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  // Удаляем при выходе (Logout)
  Future<void> deleteToken() async {
    await _storage.delete(key: 'jwt_token');
  }
}