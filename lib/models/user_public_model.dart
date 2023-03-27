import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserPublicModel extends Equatable {
  final String email;
  final String occupation;

  const UserPublicModel({
    required this.email,
    required this.occupation,
  });

  @override
  List<Object?> get props => [email, occupation];

  Map<String, dynamic> toDocument() {
    return {
      'email': email,
      'occupation': occupation,
    };
  }

  static UserPublicModel fromSnapshot(DocumentSnapshot snap) {
    UserPublicModel user = UserPublicModel(
      email: snap['email'],
      occupation: snap['occupation'],
    );
    return user;
  }
}
