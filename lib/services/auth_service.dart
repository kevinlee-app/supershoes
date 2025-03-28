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
    Uri url = Endpoint.register.url;
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    });
    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(data);
      await Storage.instance.saveToken(user.token);
      return user;
    } else {
      throw Exception("Register failed");
    }
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    Uri url = Endpoint.login.url;
    var body = jsonEncode({
      'username': email,
      'password': password,
    });
    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(data);
      return user;
    } else {
      throw Exception("Login failed");
    }
  }
}
