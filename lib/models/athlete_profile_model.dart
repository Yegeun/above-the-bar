import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AthleteProfileModel extends Equatable {
  final String email;
  final double weightClass;
  final String coachEmail;
  final String programId;
  final DateTime startDate;
  final int week;
  final int session;

  const AthleteProfileModel(
      {required this.email,
      required this.weightClass,
      required this.coachEmail,
      required this.programId,
      required this.startDate,
      required this.week,
      required this.session});

  @override
  List<Object?> get props =>
      [email, coachEmail, weightClass, programId, startDate, week, session];

  Map<String, dynamic> toDocument() {
    return {
      'email': email,
      'coach': coachEmail,
      'weightClass': weightClass,
      'block': programId,
      'startDate': startDate,
      'week': week,
      'session': session
    };
  }

  static AthleteProfileModel fromSnapshot(DocumentSnapshot snap) {
    AthleteProfileModel user = AthleteProfileModel(
      email: snap['email'],
      weightClass: snap['weightClass'],
      coachEmail: snap['coach'],
      programId: snap['block'],
      startDate: snap['startDate'].toDate(),
      week: snap['week'],
      session: snap['session'],
    );
    return user;
  }

  AthleteProfileModel copyWith({required week, required session}) {
    return AthleteProfileModel(
        email: email,
        weightClass: weightClass,
        coachEmail: coachEmail,
        programId: programId,
        startDate: startDate,
        week: week,
        session: session);
  }
}
