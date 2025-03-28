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
  register('/register'),
  login('/login'),
  products('/products');

  final String value;
  const Endpoint(this.value);

  Uri get url {
    String baseUrl = Constant.baseUrl;
    return Uri.parse('$baseUrl$value/');
  } 
  bool get useAuthorization => !(this == Endpoint.register || this == Endpoint.login || this == Endpoint.products);
}

class BaseService {
  @protected
  var headers = {'Content-Type': 'application/json'};

  Future<http.Response> request(Endpoint endpoint, [String? body, Method? method]) async {
    if(endpoint.useAuthorization) {
      TokenModel? token = await Storage.instance.getToken();
      if (token != null) {
        headers['Authorization'] = token.access;
      }
    }

http.Response response;
switch (method) {
  case Method.post:
    response = await http.post(
      endpoint.url,
      headers: headers,
      body: body
    );
    break;
  default:
    response = await http.get(
      endpoint.url,
      headers: headers,
    );
    break;
}
    

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw Exception(response.body);
    }
  }
}
