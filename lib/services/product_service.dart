import 'dart:convert';
import 'package:supershoes/models/product_model.dart';
import 'package:supershoes/services/base_service.dart';

class ProductService extends BaseService {
  Future<List<ProductModel>> getProducts() async {
    final response = await request(Endpoint.products);
    final data = jsonDecode(response.body)['results'];
    List<ProductModel> products = [];
    for (final item in data) {
      products.add(ProductModel.fromJson(item));
    }
    
    return products;
  }
}
