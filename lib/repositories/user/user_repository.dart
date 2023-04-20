import 'package:above_the_bar/models/models.dart';

import 'base_user_repository.dart';
import 'package:above_the_bar/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository implements BaseUserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createUser(UserPublicModel user) async {
    print(user.occupation);
    await _firebaseFirestore
        .collection('users')
        .doc(user.email)
        .set(user.toDocument());
    if (user.occupation == 'coach') {
      await _firebaseFirestore
          .collection('coaches')
          .doc(user.email)
          .set(user.toDocument());
    }
  }

  @override
  Stream<UserPublicModel> getUser(String email) {
    return _firebaseFirestore
        .collection('users')
        .doc(email)
        .snapshots()
        .map((docSnapshot) => UserPublicModel.fromSnapshot(docSnapshot));
  }
}
