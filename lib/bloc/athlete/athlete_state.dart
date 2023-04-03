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
  final String coachEmail;

  const AthleteLoaded(
      {this.athletes = const <AthleteModel>[], this.coachEmail = ''});

  @override
  List<Object> get props => [athletes];
}

class AthleteUpdating extends AthleteState {
  final List<AthleteModel> athletes;
  final String coachEmail;

  const AthleteUpdating(
      {this.athletes = const <AthleteModel>[], this.coachEmail = ''});

  @override
  List<Object> get props => [athletes];
}

class AthleteDeleting extends AthleteState {
  const AthleteDeleting();

  @override
  List<Object> get props => [];
}

class AthleteDeleted extends AthleteState {
  final List<AthleteModel> athletes;
  final String coachEmail;

  const AthleteDeleted(
      {this.athletes = const <AthleteModel>[], this.coachEmail = ''});

  @override
  List<Object> get props => [athletes, coachEmail];
}
