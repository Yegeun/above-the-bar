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
  const UpdateCreateAthleteProfile(this.email, this.blockId, this.startDate);

  final String email;
  final String blockId;
  final DateTime startDate;

  @override
  List<Object> get props => [email, blockId, startDate];
}
