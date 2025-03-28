import 'package:supershoes/models/category_model.dart';
import 'package:supershoes/models/gallery_model.dart';

class ProductModel {
  final int id;
  final String name;
  final double price;
  final String description;
  final String tags;
  final CategoryModel category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<GalleryModel> gallery;

  ProductModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.tags,
      required this.category,
      required this.createdAt,
      required this.updatedAt,
      required this.gallery});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'] as int,
        name: json['name'] as String,
        price: double.parse(json['price'].toString()),
        description: json['description'] as String,
        tags: json['tags'] as String,
        category: CategoryModel.fromJson(json['category']),
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        gallery: (json['gallery'] as List<dynamic>?)
            ?.map((gallery) => GalleryModel.fromJson(gallery))
            .toList() ?? []);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'tags': tags,
      'category': category.toJson(),
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
      'gallery': gallery.map((gallery) => gallery.toJson()).toList(),
    };
  }
}
