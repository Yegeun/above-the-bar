part of 'program_bloc.dart';

abstract class ProgramEvent extends Equatable {
  const ProgramEvent();

  @override
  List<Object> get props => [];
}

class LoadProgram extends ProgramEvent {
  const LoadProgram(this.athleteEmail, this.coachEmail);

  final String athleteEmail;
  final String coachEmail;

  @override
  List<Object> get props => [athleteEmail, coachEmail];
}

class UpdateProgram extends ProgramEvent {
  final List<ProgramModel> program;

  const UpdateProgram(this.program);

  @override
  List<Object> get props => [program];
}

class CreateProgram extends ProgramEvent {
  final ProgramModel program;

  const CreateProgram(this.program);

  @override
  List<Object> get props => [program];
}
