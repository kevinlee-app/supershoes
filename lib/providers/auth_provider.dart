import 'package:flutter/material.dart';
import 'package:supershoes/models/user_model.dart';
import 'package:supershoes/services/auth_service.dart';
import 'package:supershoes/utils/storage.dart';

class AuthProvider with ChangeNotifier {
  late UserModel _user;
  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        username: username,
        email: email,
        password: password,
      );
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
  
  Future<bool> getUser() async {
    final savedUser = await Storage.instance.getUser();
    if (savedUser != null) {
      _user = savedUser;
      return true;
    }

    return false;
  }
}
