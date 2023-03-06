part of 'athlete_data_bloc.dart';

@immutable
abstract class AthleteDataEvent extends Equatable {
  const AthleteDataEvent();

  @override
  List<Object> get props => [];
}

class LoadAthleteData extends AthleteDataEvent {}

class UpdateAthleteData extends AthleteDataEvent {
  final List<AthleteDataEntryModel> entries;

  const UpdateAthleteData(this.entries);

  @override
  List<Object> get props => [entries];
}

class CreateAthleteData extends AthleteDataEvent {
  final AthleteDataEntryModel entryModel;

  const CreateAthleteData(this.entryModel);

  @override
  List<Object> get props => [entryModel];
}

class DeleteAthleteData extends AthleteDataEvent {
  final AthleteDataEntryModel entryModel;

  const DeleteAthleteData(this.entryModel);

  @override
  List<Object> get props => [entryModel];
}
