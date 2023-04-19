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
