part of 'program_details_bloc.dart';

abstract class ProgramDetailsEvent extends Equatable {
  const ProgramDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadProgramDetails extends ProgramDetailsEvent {
  final String coachEmail;
  final String programId;

  const LoadProgramDetails(this.coachEmail, this.programId);

  @override
  List<Object> get props => [coachEmail, programId];
}

class UpdateProgramDetails extends ProgramDetailsEvent {
  final ProgramDetailsModel programDetails;

  const UpdateProgramDetails(this.programDetails);

  @override
  List<Object> get props => [programDetails];
}
