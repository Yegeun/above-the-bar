part of 'athlete_list_bloc.dart';

abstract class AthleteListState extends Equatable {
  const AthleteListState();

  @override
  List<Object> get props => [];
}

class AthleteListLoading extends AthleteListState {}

class AthleteListLoaded extends AthleteListState {
  final List<String> athleteList;

  const AthleteListLoaded({this.athleteList = const <String>[]});

  @override
  List<Object> get props => [athleteList];
}

class AthleteListUpdating extends AthleteListState {
  final List<String> athleteList;

  const AthleteListUpdating({this.athleteList = const <String>[]});

  @override
  List<Object> get props => [athleteList];
}

class AthleteListDeleting extends AthleteListState {
  const AthleteListDeleting();

  @override
  List<Object> get props => [];
}

class AthleteListDeleted extends AthleteListState {
  const AthleteListDeleted({this.athletes = const <String>[]});

  final List<String> athletes;

  @override
  List<Object> get props => [athletes];
}

