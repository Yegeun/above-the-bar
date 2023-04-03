part of 'athlete_bloc.dart';

@immutable
abstract class AthleteEvent extends Equatable {
  const AthleteEvent();

  @override
  List<Object> get props => [];
}

class LoadAthlete extends AthleteEvent {
  final String coachEmail;

  const LoadAthlete(this.coachEmail);

  @override
  List<Object> get props => [coachEmail];

}

class UpdateAthletes extends AthleteEvent {
  final List<AthleteModel> athletes;
  final String coachEmail;

  const UpdateAthletes(this.athletes, this.coachEmail);

  @override
  List<Object> get props => [athletes, coachEmail];
}

class CreateAthlete extends AthleteEvent {
  final AthleteModel athlete;
  final String coachEmail;

  const CreateAthlete(this.athlete, this.coachEmail);

  @override
  List<Object> get props => [athlete, coachEmail];
}

class DeleteAthlete extends AthleteEvent {
  final AthleteModel athlete;
  final String coachEmail;

  const DeleteAthlete(this.athlete, this.coachEmail);

  @override
  List<Object> get props => [athlete, coachEmail];
}
