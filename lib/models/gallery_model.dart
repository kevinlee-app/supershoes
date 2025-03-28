class GalleryModel {
  final int id;
  final String url;

   GalleryModel({
    required this.id,
    required this.url,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    return GalleryModel(
      id: json['id'] as int,
      url: json['url'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
    };
  }
}
