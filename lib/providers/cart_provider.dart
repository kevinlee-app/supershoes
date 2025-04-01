import 'package:flutter/foundation.dart';
import 'package:supershoes/models/cart_model.dart';
import 'package:supershoes/models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _carts = [];
  List<CartModel> get carts => _carts;

  set carts(List<CartModel> carts) {
    _carts = carts;
    notifyListeners();
  }

  void addCart(ProductModel product) {
    if (productExists(product)) {
      final index = _carts.indexWhere((item) => item.product.id == product.id);
      _carts[index].quantity++;
    } else {
      _carts.add(
        CartModel(id: _carts.length, product: product, quantity: 1),
      );
    }

    notifyListeners();
  }

  void removeCart(int id) {
    _carts.removeAt(id);
    notifyListeners();
  }

  void addQuantity(int id) {
    _carts[id].quantity++;
    notifyListeners();
  }

  void reduceQuantity(int id) {
    _carts[id].quantity--;
    if(_carts[id].quantity == 0) {
      _carts.removeAt(id);
    }
    notifyListeners();
  }

  int totalItems() {
    int total = 0;
    for(var item in _carts) {
      total += item.quantity;
    }

    return total;
  }

  double totalPrice() {
    double total = 0;
    for(var item in _carts) {
      total += item.getTotalPrice();
    }
    
    return total;
  }

  bool productExists(ProductModel product) {
    return _carts.indexWhere((item) => item.product.id == product.id) != -1;
  }
}
