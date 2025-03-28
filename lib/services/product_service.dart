import 'dart:convert';
import 'package:supershoes/models/product_model.dart';
import 'package:supershoes/services/base_service.dart';

class ProductService extends BaseService {
  Future<List<ProductModel>> getProducts() async {
    var response = await request(Endpoint.products);
    var data = jsonDecode(response.body)['results'];
    List<ProductModel> products = [];
    for (var item in data) {
      products.add(ProductModel.fromJson(item));
    }

    return products;
  }
}
