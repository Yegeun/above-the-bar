import 'base_user_repository.dart';
import 'package:above_the_bar/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository implements BaseUserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createUser(UserModel user) async {
    await _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .set(user.toDocument());
  }
}
