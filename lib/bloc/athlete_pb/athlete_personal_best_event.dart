part of 'athlete_personal_best_bloc.dart';

@immutable
abstract class AthletePersonalBestEvent extends Equatable {
  const AthletePersonalBestEvent();

  @override
  List<Object> get props => [];
}

class LoadAthletePersonalBest extends AthletePersonalBestEvent {}

class UpdateAthletePersonalBest extends AthletePersonalBestEvent {
  final List<AthletePersonalBestModel> pb;

  const UpdateAthletePersonalBest(this.pb);

  @override
  List<Object> get props => [pb];
}

class CreateAthletePersonalBest extends AthletePersonalBestEvent {
  final AthletePersonalBestModel entryModel;

  const CreateAthletePersonalBest(this.entryModel);

  @override
  List<Object> get props => [entryModel];
}
