part of 'program_list_bloc.dart';

@immutable
abstract class ProgramListEvent extends Equatable {
  const ProgramListEvent();

  @override
  List<Object> get props => [];
}

class LoadProgramList extends ProgramListEvent {}

class UpdateProgramList extends ProgramListEvent {
  final List<String> programList;

  const UpdateProgramList(this.programList);

  @override
  List<Object> get props => [programList];
}

class DeleteProgram extends ProgramListEvent {
  final String program;

  const DeleteProgram(this.program);

  @override
  List<Object> get props => [program];
}

class CopyProgram extends ProgramListEvent {
  final String program;
  final String copyProgram;

  const CopyProgram(this.program, this.copyProgram);

  @override
  List<Object> get props => [program, copyProgram];
}
