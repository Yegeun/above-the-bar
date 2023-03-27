import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserPublicModel extends Equatable {
  final String email;
  final String occupation;
  final String coachEmail;

  const UserPublicModel({
    required this.email,
    required this.occupation,
    required this.coachEmail,
  });

  @override
  List<Object?> get props => [email, coachEmail, occupation];

  Map<String, dynamic> toDocument() {
    return {
      'email': email,
      'coach': coachEmail,
      'occupation': occupation,
    };
  }

  static UserPublicModel fromSnapshot(DocumentSnapshot snap) {
    UserPublicModel user = UserPublicModel(
      email: snap['email'],
      occupation: snap['occupation'],
      coachEmail: snap['coach'],
    );
    return user;
  }
}
