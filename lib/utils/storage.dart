import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supershoes/models/token_model.dart';

class Storage {
  Storage._privateConstructor();
  static final Storage instance = Storage._privateConstructor();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveToken(TokenModel token) async {
    await _storage.write(key: 'token', value: jsonEncode(token.toJson()));
  }

  Future<TokenModel?> getToken() async {
    String? jsonString = await _storage.read(key: 'token');
    if (jsonString == null) return null;
    return TokenModel.fromJson(jsonDecode(jsonString));
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'token');
  }
}