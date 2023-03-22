import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String? fullName;
  final String? email;
  final String? occupation;

  const UserModel({
    required this.id,
    this.fullName,
    this.email,
    this.occupation,
  });

  static const empty = UserModel(id: '');

  bool get isEmpty => this == UserModel.empty;

  bool get isNotEmpty => this != UserModel.empty;

  @override
  List<Object?> get props => [id, fullName, email, occupation];
}
