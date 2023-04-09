import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AthleteProfileModel extends Equatable {
  final String email;
  final double weightClass;
  final String coachEmail;
  final String programId;
  final DateTime startDate;
  final int maxWeek;
  final int maxSession;
  final int maxExercise;
  final int week;
  final int session;

  const AthleteProfileModel(
      {required this.email,
      required this.weightClass,
      required this.coachEmail,
      required this.programId,
      required this.startDate,
      required this.maxWeek,
      required this.maxSession,
      required this.maxExercise,
      required this.week,
      required this.session});

  @override
  List<Object?> get props => [
        email,
        coachEmail,
        weightClass,
        programId,
        startDate,
        maxWeek,
        maxSession,
        maxExercise,
        week,
        session
      ];

  Map<String, dynamic> toDocument() {
    return {
      'email': email,
      'coach': coachEmail,
      'weightClass': weightClass,
      'block': programId,
      'startDate': startDate,
      'maxWeek': maxWeek,
      'maxSession': maxSession,
      'maxExercise': maxExercise,
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
      maxWeek: snap['maxWeek'],
      maxSession: snap['maxSession'],
      maxExercise: snap['maxExercise'],
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
        maxWeek: maxWeek,
        maxSession: maxSession,
        maxExercise: maxExercise,
        week: week,
        session: session);
  }
}
