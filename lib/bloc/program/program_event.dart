part of 'program_bloc.dart';

@immutable
abstract class ProgramEvent extends Equatable {
  const ProgramEvent();

  @override
  List<Object> get props => [];
}

class LoadProgram extends ProgramEvent {}

class UpdateProgram extends ProgramEvent {
  final List<Program> program;

  const UpdateProgram(this.program);

  @override
  List<Object> get props => [program];
}

class CreateProgram extends ProgramEvent {
  final Program program;

  const CreateProgram(this.program);

  @override
  List<Object> get props => [program];
}
