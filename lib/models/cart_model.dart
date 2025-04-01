import 'package:supershoes/models/product_model.dart';

class CartModel {
  final int id;
  final ProductModel product;
  int quantity;

  CartModel({
    required this.id,
    required this.product,
    required this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        id: json['id'],
        product: ProductModel.fromJson(json['product']),
        quantity: json['quantity'] as int);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product,
      'quantity': quantity,
    };
  }

  double getTotalPrice() {
    return product.price * quantity;
  }
}
