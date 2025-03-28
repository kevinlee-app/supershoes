import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supershoes/models/token_model.dart';
import 'package:supershoes/models/user_model.dart';

class Storage {
  Storage._privateConstructor();
  static final Storage instance = Storage._privateConstructor();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveUser(UserModel user) async {
    await _storage.write(key: 'user', value: jsonEncode(user.toJson()));
  }

  Future<UserModel?> getUser() async {
    String? jsonString = await _storage.read(key: 'user');
    if (jsonString == null) return null;
    return UserModel.fromJson(jsonDecode(jsonString));
  }
  
  Future<void> saveToken(TokenModel token) async {
    UserModel? user = await getUser();
    if (user != null) {
      var jsonString = user.toJson();
      jsonString['token'] = token.toJson();
      final updatedUser = UserModel.fromJson(jsonString);
      await saveUser(updatedUser);
    }
  }

  Future<void> deleteUser() async {
    await _storage.delete(key: 'user');
  }

}