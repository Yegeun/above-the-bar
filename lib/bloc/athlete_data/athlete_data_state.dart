part of 'athlete_data_bloc.dart';

@immutable
abstract class AthleteDataState extends Equatable {
  const AthleteDataState();

  @override
  List<Object> get props => [];
}

class AthleteDataLoading extends AthleteDataState {}

class AthleteDataLoaded extends AthleteDataState {
  final List<AthleteDataEntryModel> entries;

  const AthleteDataLoaded({this.entries = const <AthleteDataEntryModel>[]});

  @override
  List<Object> get props => [entries];
}
