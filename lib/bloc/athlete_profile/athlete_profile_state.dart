part of 'athlete_profile_bloc.dart';

abstract class AthleteProfileState extends Equatable {
  const AthleteProfileState();

  @override
  List<Object> get props => [];
}

class AthleteProfileLoading extends AthleteProfileState {}

class AthleteProfileLoaded extends AthleteProfileState {
  final AthleteProfileModel athleteProfile;

  const AthleteProfileLoaded({
    this.athleteProfile = const AthleteProfileModel(
      email: 'empty',
      weightClass: 0.0,
      coachEmail: 'empty',
      programId: 'empty',
      startDate: ConstDateTime(2022, 1, 1),
      week: 1,
      session: 1,
      snatch: 0,
      cleanAndJerk: 0,
      hangSnatch: 0,
      powerSnatch: 0,
      blockSnatch: 0,
      snatchDeadlift: 0,
      clean: 0,
      hangClean: 0,
      powerClean: 0,
      blockClean: 0,
      cleanDeadlift: 0,
      jerkFromRack: 0,
      powerJerk: 0,
      jerkFromBlock: 0,
      pushPress: 0,
      backSquat: 0,
      frontSquat: 0,
      strictPress: 0,
      strictRow: 0,
      trunkHold: 0,
      backHold: 0,
      sideHold: 0,
    ),
  });

  @override
  List<Object> get props => [athleteProfile];
}

class AthleteProfileUpdating extends AthleteProfileState {
  final AthleteProfileModel athleteProfile;

  const AthleteProfileUpdating({
    this.athleteProfile = const AthleteProfileModel(
      email: 'empty',
      weightClass: 0.0,
      coachEmail: 'empty',
      programId: 'empty',
      startDate: ConstDateTime(2022, 1, 1),
      week: 1,
      session: 1,
      snatch: 0,
      cleanAndJerk: 0,
      hangSnatch: 0,
      powerSnatch: 0,
      blockSnatch: 0,
      snatchDeadlift: 0,
      clean: 0,
      hangClean: 0,
      powerClean: 0,
      blockClean: 0,
      cleanDeadlift: 0,
      jerkFromRack: 0,
      powerJerk: 0,
      jerkFromBlock: 0,
      pushPress: 0,
      backSquat: 0,
      frontSquat: 0,
      strictPress: 0,
      strictRow: 0,
      trunkHold: 0,
      backHold: 0,
      sideHold: 0,
    ),
  });

  @override
  List<Object> get props => [athleteProfile];
}

class AthleteProfileCreateUpdating extends AthleteProfileState {
  final String email;
  final String programId;
  final DateTime startDate;
  final String maxWeek;
  final String week;
  final String maxSession;
  final String session;

  const AthleteProfileCreateUpdating({
    required this.email,
    required this.programId,
    required this.startDate,
    required this.maxWeek,
    required this.week,
    required this.maxSession,
    required this.session,
  });
}

class AthleteProfileCreateUpdated extends AthleteProfileState {}

class AthleteProfilePersonalBestUpdate extends AthleteProfileState {
  final String email;
  final String exercise;
  final int weight;

  const AthleteProfilePersonalBestUpdate({
    required this.email,
    required this.exercise,
    required this.weight,
  });
}

class AthleteProfilePersonalBestUpdated extends AthleteProfileState {}

class AthleteProfileWeightClassUpdate extends AthleteProfileState {
  final String email;
  final double weightClass;
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

  const AthleteProfileWeightClassUpdate({
    required this.email,
    required this.weightClass,
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
    required this.sideHold,
  });
}

class AthleteProfileWeightClassUpdated extends AthleteProfileState {}
