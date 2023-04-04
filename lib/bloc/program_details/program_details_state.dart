part of 'program_details_bloc.dart';

abstract class ProgramDetailsState extends Equatable {
  const ProgramDetailsState();

  @override
  List<Object> get props => [];
}

class ProgramDetailsLoading extends ProgramDetailsState {}

class ProgramDetailsLoaded extends ProgramDetailsState {
  final ProgramDetailsModel programDetails;

  const ProgramDetailsLoaded(
      {this.programDetails = const ProgramDetailsModel(
          programName: 'empty', weeks: 0, sessions: 0, exercises: 0)});

  @override
  List<Object> get props => [programDetails];
}

class ProgramDetailsUpdating extends ProgramDetailsState {
  final ProgramDetailsModel programDetails;

  const ProgramDetailsUpdating(
      {this.programDetails = const ProgramDetailsModel(
          programName: 'empty', weeks: 0, sessions: 0, exercises: 0)});

  @override
  List<Object> get props => [programDetails];
}
