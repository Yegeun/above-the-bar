part of 'athlete_profile_bloc.dart';

abstract class AthleteProfileState extends Equatable {
  const AthleteProfileState();

  @override
  List<Object> get props => [];
}

class AthleteProfileLoading extends AthleteProfileState {}

class AthleteProfileLoaded extends AthleteProfileState {
  final AthleteProfileModel athleteProfile;

  const AthleteProfileLoaded(
      {this.athleteProfile = const AthleteProfileModel(
          email: 'empty', weightClass: 0.0, coachEmail: 'empty')});

  @override
  List<Object> get props => [athleteProfile];
}

class AthleteProfileUpdating extends AthleteProfileState {
  final AthleteProfileModel athleteProfile;

  const AthleteProfileUpdating(
      {this.athleteProfile = const AthleteProfileModel(
          email: 'empty', weightClass: 0.0, coachEmail: 'empty')});

  @override
  List<Object> get props => [athleteProfile];
}
