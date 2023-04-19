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

class AthleteProfilePersonalBestUpdated extends AthleteProfileState {
}
