// import 'base_user_repository.dart';
// import 'package:above_the_bar/models/user_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class UserRepository implements BaseUserRepository {
//   final FirebaseFirestore _firebaseFirestore;
//
//   UserRepository({FirebaseFirestore? firebaseFirestore})
//       : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
//
//   @override
//   Future<void> createUser(UserModel user) async {
//     await _firebaseFirestore
//         .collection('users')
//         .doc(user.id)
//         .set(user.toDocument());
//   }
//
//   @override
//   Stream<UserModel> getUser(String userId) {
//     print('Getting user with id: $userId from Firestore');
//     return _firebaseFirestore
//         .collection('users')
//         .doc(userId)
//         .snapshots()
//         .map((snapshot) => UserModel.fromSnapshot(snapshot));
//   }
//
//   //this is how you update the document //TODO add this to the user model
//   @override
//   Future<void> updateUser(UserModel user) async {
//     await _firebaseFirestore
//         .collection('users')
//         .doc(user.id)
//         .update(user.toDocument())
//         .then((value) => print("User Updated"))
//         .catchError((error) => print("Failed to update user: $error"));
//   }
//
//   @override
//   Future<void> deleteUser(String uid) async {
//     await _firebaseFirestore.collection('users').doc(uid).delete();
//   }
// }
