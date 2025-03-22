import 'dart:convert';

import 'package:supershoes/models/token_model.dart';
import 'package:supershoes/models/user_model.dart';
import 'package:http/http.dart' as http;

enum Endpoint {
  register('/register'),
  login('/login');

  final String value;
  const Endpoint(this.value);

  final String baseUrl = 'http://10.0.2.2:8000';
  Uri get url => Uri.parse('$baseUrl$value/');
}

class AuthService {
  String baseUrl = 'http://127.0.0.1:8000';

  Future<UserModel> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    Uri url = Endpoint.register.url;
    var headers = {'Content-Type': 'application/json'};
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
    var headers = {'Content-Type': 'application/json'};
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
