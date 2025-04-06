import 'package:flutter/material.dart';
import 'package:supershoes/models/category_model.dart';
import 'package:supershoes/models/product_model.dart';
import 'package:supershoes/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  late List<ProductModel> _products;
  List<ProductModel> get products => _products;

  List<CategoryModel> get categories {
    List<CategoryModel> list =
        products.map((product) => product.category).toSet().toList();

    list.insert(0, CategoryModel(id: 0, name: "All"));

    return list;
  }

  List<ProductModel> productsByCategory(int categoryId) {
    return categoryId == 0
        ? _products
        : _products
            .where((product) => product.category.id == categoryId)
            .toList();
  }

  List<ProductModel> get newArrivalProducts {
    return _products.take(5).toList();
  }

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<void> getProducts() async {
    try {
      List<ProductModel> products = await ProductService().getProducts();
      _products = products;
      _products.sort(
          (a, b) => b.createdAt?.compareTo(a.createdAt ?? DateTime.now()) ?? 0);
    } catch (e) {
      print(e);
    }
  }
}
