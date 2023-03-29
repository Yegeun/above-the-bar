part of 'athlete_list_bloc.dart';

abstract class AthleteListEvent extends Equatable {
  const AthleteListEvent();

  @override
  List<Object> get props => [];
}

class LoadAthleteList extends AthleteListEvent {}

class UpdateAthleteList extends AthleteListEvent {
  final List<String> athleteList;

  const UpdateAthleteList(this.athleteList);

  @override
  List<Object> get props => [athleteList];
}

class DeleteAthleteProfile extends AthleteListEvent {
  final String athlete;

  const DeleteAthleteProfile(this.athlete);

  @override
  List<Object> get props => [athlete];
}
