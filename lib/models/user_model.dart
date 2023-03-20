import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? id;
  final String fullName;
  final String email;
  final String occupation;

  const UserModel({
    this.id,
    this.fullName = "",
    this.email = "",
    this.occupation = "",
  });

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? occupation,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      occupation: occupation ?? this.occupation,
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snap) {
    return UserModel(
      id: snap.id,
      fullName: snap['fullName'],
      email: snap['email'],
      occupation: snap['occupation'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'fullName': fullName,
      'email': email,
      'occupation': occupation,
    };
  }

  @override
  List<Object?> get props =>
      [
        id,
        fullName,
        email,
        occupation,
      ];
}
