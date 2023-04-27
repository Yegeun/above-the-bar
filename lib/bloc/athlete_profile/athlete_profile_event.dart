part of 'athlete_profile_bloc.dart';

abstract class AthleteProfileEvent extends Equatable {
  const AthleteProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadAthleteProfile extends AthleteProfileEvent {
  const LoadAthleteProfile(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class UpdateAthleteProfile extends AthleteProfileEvent {
  const UpdateAthleteProfile(this.athleteProfile);

  final AthleteProfileModel athleteProfile;

  @override
  List<Object> get props => [athleteProfile];
}

class CreateAthleteProfile extends AthleteProfileEvent {
  const CreateAthleteProfile(this.athleteProfile);

  final AthleteProfileModel athleteProfile;

  @override
  List<Object> get props => [athleteProfile];
}

class UpdateCreateAthleteProfile extends AthleteProfileEvent {
  const UpdateCreateAthleteProfile(
      this.email, this.programId, this.startDate, this.week, this.session);

  final String email;
  final String programId;
  final DateTime startDate;
  final int week;
  final int session;

  @override
  List<Object> get props => [email, programId, startDate, week, session];
}

class UpdatePersonalBestProfile extends AthleteProfileEvent {
  const UpdatePersonalBestProfile(this.email, this.exercise, this.weight);

  final String email;
  final String exercise;
  final int weight;

  @override
  List<Object> get props => [email, exercise, weight];
}

class UpdateWeightsOnProfile extends AthleteProfileEvent {
  const UpdateWeightsOnProfile(
      this.email,
      this.weightClass,
      this.snatch,
      this.cleanAndJerk,
      this.hangSnatch,
      this.powerSnatch,
      this.blockSnatch,
      this.snatchDeadlift,
      this.clean,
      this.hangClean,
      this.powerClean,
      this.blockClean,
      this.cleanDeadlift,
      this.jerkFromRack,
      this.powerJerk,
      this.jerkFromBlock,
      this.pushPress,
      this.backSquat,
      this.frontSquat,
      this.strictPress,
      this.strictRow,
      this.trunkHold,
      this.backHold,
      this.sideHold);

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

  @override
  List<Object> get props => [
        email,
        weightClass,
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
}
