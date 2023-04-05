import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AthleteProfileModel extends Equatable {
  final String email;
  final double weightClass;
  final String coachEmail;
  final String programId;
  final DateTime startDate;

  const AthleteProfileModel(
      {required this.email,
      required this.weightClass,
      required this.coachEmail,
      required this.programId,
      required this.startDate});

  @override
  List<Object?> get props => [email, coachEmail, weightClass, programId];

  Map<String, dynamic> toDocument() {
    return {
      'email': email,
      'coach': coachEmail,
      'weightClass': weightClass,
      'programId': programId,
      'startDate': startDate
    };
  }

  static AthleteProfileModel fromSnapshot(DocumentSnapshot snap) {
    AthleteProfileModel user = AthleteProfileModel(
        email: snap['email'],
        weightClass: snap['weightClass'],
        coachEmail: snap['coach'],
        programId: snap['programId'],
        startDate: snap['startDate'].toDate());
    return user;
  }
}
