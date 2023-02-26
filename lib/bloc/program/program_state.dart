part of 'program_bloc.dart';

@immutable
abstract class ProgramState extends Equatable {
  const ProgramState();

  @override
  List<Object> get props => [];
}

class ProgramLoading extends ProgramState {}

class ProgramLoaded extends ProgramState {
  final List<Program> programs;

  const ProgramLoaded({this.programs = const <Program>[]});

  @override
  List<Object> get props => [programs];
}
