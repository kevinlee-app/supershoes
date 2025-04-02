import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:supershoes/models/token_model.dart';
import 'package:supershoes/utils/constant.dart';
import 'package:supershoes/utils/storage.dart';
import 'package:http/http.dart' as http;

enum Method {
  post,
  get,
}

enum Endpoint {
  refreshToken('api/token/refresh'),
  register('register'),
  login('login'),
  products('products'),
  checkout('checkout');

  final String value;
  const Endpoint(this.value);

  Uri get url {
    String baseUrl = Constant.baseUrl;
    return Uri.parse('$baseUrl$value/');
  }

  bool get useAuthorization => !(this == Endpoint.register ||
      this == Endpoint.login ||
      this == Endpoint.products);
}

class BaseService {
  var _headers = {'Content-Type': 'application/json'};

  Future<http.Response> request(Endpoint endpoint,
      [String? body, Method? method]) async {
    if (endpoint.useAuthorization) {
      TokenModel? token = (await Storage.instance.getUser())?.token;
      if (token != null) {
        _headers['Authorization'] = 'Bearer ${token.access}';
      }
    }

    http.Response response;
    switch (method) {
      case Method.post:
        response = await http.post(
          endpoint.url,
          headers: _headers,
          body: body,
        );
        break;
      default:
        response = await http.get(
          endpoint.url,
          headers: _headers,
        );
        break;
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else if (response.statusCode == 401) {
      return await _refreshToken(() => request(endpoint, body, method));
    } else {
      throw Exception(response.body);
    }
  }

  Future<http.Response> _refreshToken(
      Future<http.Response> Function() request) async {
    var token = (await Storage.instance.getUser())?.token;
    if (token != null) {
      final body = jsonEncode({'refresh': token.refresh});
      final response = await http.post(
        Endpoint.refreshToken.url,
        headers: _headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = TokenModel.fromJson(data);
        await Storage.instance.saveToken(token);
        return await request();
      } else {
        await Storage.instance.deleteUser();
      }
    }

    throw Exception("Refresh token failed");
  }
}
