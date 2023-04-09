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
  const UpdateCreateAthleteProfile(this.email, this.blockId, this.startDate,
      this.maxWeek, this.maxSession, this.maxExercise, this.week, this.session);

  final String email;
  final String blockId;
  final DateTime startDate;
  final int maxWeek;
  final int maxSession;
  final int maxExercise;
  final int week;
  final int session;

  @override
  List<Object> get props => [
        email,
        blockId,
        startDate,
        maxWeek,
        maxSession,
        maxExercise,
        week,
        session
      ];
}
