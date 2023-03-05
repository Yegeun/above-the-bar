part of 'athlete_bloc.dart';

@immutable
abstract class AthleteState extends Equatable {
  const AthleteState();

  @override
  List<Object> get props => [];
}

class AthleteLoading extends AthleteState {}

class AthleteLoaded extends AthleteState {
  final List<AthleteModel> athletes;

  const AthleteLoaded({this.athletes = const <AthleteModel>[]});

  @override
  List<Object> get props => [athletes];
}
