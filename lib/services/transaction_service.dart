import 'dart:convert';

import 'package:supershoes/models/cart_model.dart';
import 'package:supershoes/services/base_service.dart';

class TransactionService extends BaseService {
  Future<bool> checkout(List<CartModel> carts, double totalPrice) async {
    final body = jsonEncode({
      'address': 'Address from app',
      'details': carts.map((item) => {
            'product_id': item.product.id,
            'quantity': item.quantity,
          }).toList(),
      'status': 'PENDING',
      'total_price': totalPrice,
      'shipping_price': 0,
    });
    
    final response = await request(Endpoint.checkout, body, Method.post);

    return response.statusCode == 201;
  }
}
