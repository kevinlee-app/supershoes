import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supershoes/models/message_model.dart';
import 'package:supershoes/models/product_model.dart';
import 'package:supershoes/models/user_model.dart';

class MessageService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _collectionName = 'messages';
  Stream<List<MessageModel>>? getMessageByUserId(int userId) {
    try {
      return firestore
          .collection(_collectionName)
          .where('user.user.id', isEqualTo: userId)
          .snapshots()
          .map((QuerySnapshot list) {
        var result = list.docs.map<MessageModel>((DocumentSnapshot message) {
          return MessageModel.fromJson(message.data() as Map<String, dynamic>);
        }).toList();

          result.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        return result;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addMessage(
      UserModel user, ProductModel product, String message) async {
    try {
      firestore.collection(_collectionName).add({
        'user': user.toJson(false),
        'message': message,
        'product': product is UnitinializedProductModel ? {} : product.toJson(),
        'created_at': DateTime.now().toString(),
        'updated_at': DateTime.now().toString(),
      }).then((value) => "Message successfuly sent!");
    } catch (e) {
      throw (Exception("Failed to send message!"));
    }
  }
}
