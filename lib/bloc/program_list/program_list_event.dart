part of 'program_list_bloc.dart';

@immutable
abstract class ProgramListEvent extends Equatable {
  const ProgramListEvent();

  @override
  List<Object> get props => [];
}

class LoadProgramList extends ProgramListEvent {
  final String coachEmail;

  const LoadProgramList(this.coachEmail);

  @override
  List<Object> get props => [coachEmail];
}

class UpdateProgramList extends ProgramListEvent {
  final List<String> programList;
  final String coachEmail;

  const UpdateProgramList(this.programList, this.coachEmail);

  @override
  List<Object> get props => [programList, coachEmail];
}

class DeleteProgram extends ProgramListEvent {
  final String program;
  final String coachEmail;

  const DeleteProgram(this.program, this.coachEmail);

  @override
  List<Object> get props => [program, coachEmail];
}

class CopyProgram extends ProgramListEvent {
  final String program;
  final String copyProgram;
  final String coachEmail;

  const CopyProgram(this.program, this.copyProgram, this.coachEmail);

  @override
  List<Object> get props => [program, copyProgram, coachEmail];
}
