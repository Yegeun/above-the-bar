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
  final int snatch;
  final int cleanAndJerk;

  const AthleteProfileModel(
      {required this.email,
      required this.weightClass,
      required this.coachEmail,
      required this.programId,
      required this.startDate,
      required this.week,
      required this.session,
      required this.snatch,
      required this.cleanAndJerk});

  @override
  List<Object?> get props => [
        email,
        coachEmail,
        weightClass,
        programId,
        startDate,
        week,
        session,
        snatch,
        cleanAndJerk
      ];

  Map<String, dynamic> toDocument() {
    return {
      'email': email,
      'coach': coachEmail,
      'weightClass': weightClass,
      'programId': programId,
      'startDate': startDate,
      'week': week,
      'session': session,
      'Snatch': snatch,
      'Clean and Jerk': cleanAndJerk,
    };
  }

  static AthleteProfileModel fromSnapshot(DocumentSnapshot snap) {
    AthleteProfileModel user = AthleteProfileModel(
      email: snap['email'],
      weightClass: snap['weightClass'],
      coachEmail: snap['coach'],
      programId: snap['programId'],
      startDate: snap['startDate'].toDate(),
      week: snap['week'],
      session: snap['session'],
      snatch: snap['Snatch'],
      cleanAndJerk: snap['Clean and Jerk'],
    );
    return user;
  }

  int getWeightliftingResult(String type) {
    switch (type) {
      case 'Snatch':
        return snatch;
      case 'Clean and Jerk':
        return cleanAndJerk;
      default:
        throw ArgumentError('Invalid weightlifting type: $type');
    }
  }
}
