part of 'athlete_program_data_bloc.dart';

@immutable
abstract class AthleteProgramDataEvent extends Equatable {
  const AthleteProgramDataEvent();

  @override
  List<Object> get props => [];
}

class LoadAthleteProgramData extends AthleteProgramDataEvent {}

class UpdateAthleteProgramData extends AthleteProgramDataEvent {
  final List<AthleteProgramDataModel> data;

  const UpdateAthleteProgramData(this.data);

  @override
  List<Object> get props => [data];
}

class CreateAthleteProgramData extends AthleteProgramDataEvent {
  final AthleteProgramDataModel data;

  const CreateAthleteProgramData(this.data);

  @override
  List<Object> get props => [data];
}
