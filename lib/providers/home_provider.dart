import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int _currentCategoryId = 0;
  int get currentCategoryId => _currentCategoryId;

  set currentCategoryId(int currentCategoryId) {
    _currentCategoryId = currentCategoryId;
    notifyListeners();
  }
}