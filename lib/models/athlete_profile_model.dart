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
  final int hangSnatch;
  final int powerSnatch;
  final int blockSnatch;
  final int snatchDeadlift;
  final int clean;
  final int hangClean;
  final int powerClean;
  final int blockClean;
  final int cleanDeadlift;
  final int jerkFromRack;
  final int powerJerk;
  final int jerkFromBlock;
  final int pushPress;
  final int backSquat;
  final int frontSquat;
  final int strictPress;
  final int strictRow;
  final int trunkHold;
  final int backHold;
  final int sideHold;

  const AthleteProfileModel(
      {required this.email,
      required this.weightClass,
      required this.coachEmail,
      required this.programId,
      required this.startDate,
      required this.week,
      required this.session,
      required this.snatch,
      required this.cleanAndJerk,
      required this.hangSnatch,
      required this.powerSnatch,
      required this.blockSnatch,
      required this.snatchDeadlift,
      required this.clean,
      required this.hangClean,
      required this.powerClean,
      required this.blockClean,
      required this.cleanDeadlift,
      required this.jerkFromRack,
      required this.powerJerk,
      required this.jerkFromBlock,
      required this.pushPress,
      required this.backSquat,
      required this.frontSquat,
      required this.strictPress,
      required this.strictRow,
      required this.trunkHold,
      required this.backHold,
      required this.sideHold});

  @override
  List<Object?> get props => [
        email,
        weightClass,
        coachEmail,
        programId,
        startDate,
        week,
        session,
        snatch,
        cleanAndJerk,
        hangSnatch,
        powerSnatch,
        blockSnatch,
        snatchDeadlift,
        clean,
        hangClean,
        powerClean,
        blockClean,
        cleanDeadlift,
        jerkFromRack,
        powerJerk,
        jerkFromBlock,
        pushPress,
        backSquat,
        frontSquat,
        strictPress,
        strictRow,
        trunkHold,
        backHold,
        sideHold
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
      'Hang Snatch': hangSnatch,
      'Power Snatch': powerSnatch,
      'Block Snatch': blockSnatch,
      'Snatch Deadlift': snatchDeadlift,
      'Clean': clean,
      'Hang Clean': hangClean,
      'Power Clean': powerClean,
      'Block Clean': blockClean,
      'Clean Deadlift': cleanDeadlift,
      'Jerk from Rack': jerkFromRack,
      'Power Jerk': powerJerk,
      'Jerk from Block': jerkFromBlock,
      'Push Press': pushPress,
      'Back Squat': backSquat,
      'Front Squat': frontSquat,
      'Strict Press': strictPress,
      'Strict Row': strictRow,
      'Trunk Hold': trunkHold,
      'Back Hold': backHold,
      'Side Hold': sideHold,
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
      hangSnatch: snap['Hang Snatch'],
      powerSnatch: snap['Power Snatch'],
      blockSnatch: snap['Block Snatch'],
      snatchDeadlift: snap['Snatch Deadlift'],
      clean: snap['Clean'],
      hangClean: snap['Hang Clean'],
      powerClean: snap['Power Clean'],
      blockClean: snap['Block Clean'],
      cleanDeadlift: snap['Clean Deadlift'],
      jerkFromRack: snap['Jerk from Rack'],
      powerJerk: snap['Power Jerk'],
      jerkFromBlock: snap['Jerk from Block'],
      pushPress: snap['Push Press'],
      backSquat: snap['Back Squat'],
      frontSquat: snap['Front Squat'],
      strictPress: snap['Strict Press'],
      strictRow: snap['Strict Row'],
      trunkHold: snap['Trunk Hold'],
      backHold: snap['Back Hold'],
      sideHold: snap['Side Hold'],
    );
    return user;
  }

  int getWeightliftingResult(String type) {
    switch (type) {
      case 'Snatch':
        return snatch;
      case 'Clean and Jerk':
        return cleanAndJerk;
      case 'Hang Snatch':
        return hangSnatch;
      case 'Power Snatch':
        return powerSnatch;
      case 'Block Snatch':
        return blockSnatch;
      case 'Snatch Deadlift':
        return snatchDeadlift;
      case 'Clean':
        return clean;
      case 'Hang Clean':
        return hangClean;
      case 'Power Clean':
        return powerClean;
      case 'Block Clean':
        return blockClean;
      case 'Clean Deadlift':
        return cleanDeadlift;
      case 'Jerk from Rack':
        return jerkFromRack;
      case 'Power Jerk':
        return powerJerk;
      case 'Jerk from Block':
        return jerkFromBlock;
      case 'Push Press':
        return pushPress;
      case 'Back Squat':
        return backSquat;
      case 'Front Squat':
        return frontSquat;
      case 'Strict Press':
        return strictPress;
      case 'Strict Row':
        return strictRow;
      case 'Trunk Hold':
        return trunkHold;
      case 'Back Hold':
        return backHold;
      case 'Side Hold':
        return sideHold;
      default:
        throw ArgumentError('Invalid weightlifting type: $type');
    }
  }
}
