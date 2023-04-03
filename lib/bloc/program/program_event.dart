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
  final String coachEmail;

  const UpdateProgram(this.program, this.coachEmail);

  @override
  List<Object> get props => [program, coachEmail];
}

class CreateProgram extends ProgramEvent {
  final ProgramModel program;
  final String coachEmail;

  const CreateProgram(this.program, this.coachEmail);

  @override
  List<Object> get props => [program, coachEmail];
}
