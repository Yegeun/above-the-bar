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
    ),
  });

  @override
  List<Object> get props => [athleteProfile];
}

class AthleteProfileCreateUpdating extends AthleteProfileState {
  final String email;
  final String blockId;
  final DateTime startDate;

  const AthleteProfileCreateUpdating({
    required this.email,
    required this.blockId,
    required this.startDate,
  });

}

class AthleteProfileCreateUpdated extends AthleteProfileState {
}

