part of 'athlete_personal_best_bloc.dart';

@immutable
abstract class AthletePersonalBestState extends Equatable {
  const AthletePersonalBestState();

  @override
  List<Object> get props => [];
}

class AthletePersonalBestLoading extends AthletePersonalBestState {}

class AthletePersonalBestLoaded extends AthletePersonalBestState {
  final List<AthletePersonalBestModel> pb;

  const AthletePersonalBestLoaded(
      {this.pb = const <AthletePersonalBestModel>[]});

  @override
  List<Object> get props => [pb];
}
