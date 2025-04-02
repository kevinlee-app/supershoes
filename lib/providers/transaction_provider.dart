import 'package:flutter/foundation.dart';
import 'package:supershoes/models/cart_model.dart';
import 'package:supershoes/services/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  Future<bool> checkout(List<CartModel> carts, double totalPrice) async {
    try {
      return await TransactionService().checkout(carts, totalPrice);
    } catch (e) {
      return false;
    }
  }
}