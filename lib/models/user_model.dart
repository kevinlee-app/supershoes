import 'package:supershoes/models/token_model.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String username;
  final String profilePhotoUrl;
  final bool isStaff;
  final TokenModel token;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.username,
      required this.profilePhotoUrl,
      required this.isStaff,
      required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['user']['id'] as int,
        name: json['user']['name'] as String,
        email: json['user']['email'] as String,
        username: json['user']['username'] as String,
        profilePhotoUrl: json['user']['profile_photo_url'] as String,
        isStaff: json['user']['is_staff'] as bool,
        token: TokenModel.fromJson(json['token']));
  }

  Map<String, dynamic> toJson() {
    return {
      'user': {
        'id': id,
        'name': name,
        'email': email,
        'username': username,
        'profile_photo_url': profilePhotoUrl,
        'is_staff': isStaff,
      },
      'token': token.toJson()
    };
  }
}
