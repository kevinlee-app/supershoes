import 'package:supershoes/models/product_model.dart';
import 'package:supershoes/models/user_model.dart';

class MessageModel {
  final String message;
  final UserModel user;
  final ProductModel product;
  final DateTime createdAt;
  final DateTime updatedAt;

  MessageModel({
    required this.message,
    required this.user,
    required this.product,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'] as String,
      user: UserModel.fromJson(json['user']),
      product: json['product'].isNotEmpty
          ? ProductModel.fromJson(json['product'])
          : UnitinializedProductModel(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'user': user.toJson(),
      'product': product is UnitinializedProductModel ? {} : product.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
