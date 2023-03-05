part of 'athlete_bloc.dart';

@immutable
abstract class AthleteEvent extends Equatable {
  const AthleteEvent();

  @override
  List<Object> get props => [];
}

class LoadAthlete extends AthleteEvent {}

class UpdateAthletes extends AthleteEvent {
  final List<AthleteModel> athletes;

  const UpdateAthletes(this.athletes);

  @override
  List<Object> get props => [athletes];
}

class CreateAthlete extends AthleteEvent {
  final AthleteModel athlete;

  const CreateAthlete(this.athlete);

  @override
  List<Object> get props => [athlete];
}
