import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AthleteProfileModel extends Equatable {
  final String email;
  final double weightClass;
  final String coachEmail;

  const AthleteProfileModel({
    required this.email,
    required this.weightClass,
    required this.coachEmail,
  });

  @override
  List<Object?> get props => [email, coachEmail, weightClass];

  Map<String, dynamic> toDocument() {
    return {
      'email': email,
      'coach': coachEmail,
      'weightClass': weightClass,
    };
  }

  static AthleteProfileModel fromSnapshot(DocumentSnapshot snap) {
    AthleteProfileModel user = AthleteProfileModel(
      email: snap['email'],
      weightClass: snap['weightClass'],
      coachEmail: snap['coach'],
    );
    return user;
  }
}
