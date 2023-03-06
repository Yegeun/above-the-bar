part of 'athlete_data_bloc.dart';

@immutable
abstract class AthleteDataState extends Equatable {
  const AthleteDataState();

  @override
  List<Object> get props => [];
}

class AthleteDataLoading extends AthleteDataState {}

class AthleteDataUpdating extends AthleteDataState {
  final List<AthleteDataEntryModel> entries;

  const AthleteDataUpdating({this.entries = const <AthleteDataEntryModel>[]});

  @override
  List<Object> get props => [entries];
}

class AthleteDataLoaded extends AthleteDataState {
  final List<AthleteDataEntryModel> entries;

  const AthleteDataLoaded({this.entries = const <AthleteDataEntryModel>[]});

  @override
  List<Object> get props => [entries];
}

class AthleteDataDeleting extends AthleteDataState {
  const AthleteDataDeleting();

  @override
  List<Object> get props => [];
}

class AthleteDataDeleted extends AthleteDataState {
  const AthleteDataDeleted({this.entries = const <AthleteDataEntryModel>[]});

  final List<AthleteDataEntryModel> entries;

  @override
  List<Object> get props => [entries];
}
