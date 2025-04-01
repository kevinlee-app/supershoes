import 'package:flutter/foundation.dart';
import 'package:supershoes/models/product_model.dart';

class WishlistProvider with ChangeNotifier {
  List<ProductModel> _wishlist = [];
  List<ProductModel> get wishlist => _wishlist;

  set wishlist(List<ProductModel> wishlist) {
    _wishlist = wishlist;
    notifyListeners();
  }

  setProduct(ProductModel product) {
    isWishList(product)
        ? _wishlist.removeWhere((item) => item.id == product.id)
        : _wishlist.add(product);
    notifyListeners();
  }

  bool isWishList(ProductModel product) {
    return _wishlist.indexWhere((item) => item.id == product.id) != -1;
  }
}
