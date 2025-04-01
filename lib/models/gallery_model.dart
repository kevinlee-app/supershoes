import 'package:supershoes/utils/constant.dart';

class GalleryModel {
  final int id;
  final String imageUrl;

   GalleryModel({
    required this.id,
    required this.imageUrl,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    return GalleryModel(
      id: json['id'] as int,
      imageUrl: json['image_url'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': imageUrl,
    };
  }
}
