part of 'athlete_program_data_bloc.dart';

@immutable
abstract class AthleteProgramDataState extends Equatable {
  const AthleteProgramDataState();

  @override
  List<Object> get props => [];
}

class AthleteProgramDataLoading extends AthleteProgramDataState {}

class AthleteProgramDataLoaded extends AthleteProgramDataState {
  final List<AthleteProgramDataModel> data;

  const AthleteProgramDataLoaded(
      {this.data = const <AthleteProgramDataModel>[]});

  @override
  List<Object> get props => [data];
}
