import 'dart:convert';

import 'package:supershoes/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:supershoes/services/base_service.dart';
import 'package:supershoes/utils/storage.dart';

class AuthService extends BaseService {
  Future<UserModel> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    final body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    });
    final response = await request(Endpoint.register, body, Method.post);
    final data = jsonDecode(response.body);
    final user = UserModel.fromJson(data);
    await Storage.instance.saveUser(user);

    return user;
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final body = jsonEncode({
      'username': email,
      'password': password,
    });
    final response = await request(Endpoint.login, body, Method.post);
    final data = jsonDecode(response.body);
    final user = UserModel.fromJson(data);
    await Storage.instance.saveUser(user);

    return user;
  }
}
