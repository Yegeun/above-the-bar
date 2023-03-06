part of 'program_bloc.dart';

@immutable
abstract class ProgramState extends Equatable {
  const ProgramState();

  @override
  List<Object> get props => [];
}

class ProgramLoading extends ProgramState {}

class ProgramLoaded extends ProgramState {
  final List<ProgramModel> program;

  const ProgramLoaded({this.program = const <ProgramModel>[]});

  @override
  List<Object> get props => [program];
}

// class ProgramUpdating extends ProgramState {
//   final List<ProgramModel> program;
//
//   const ProgramUpdating({this.program = const <ProgramModel>[]});
//
//   @override
//   List<Object> get props => [program];
// }
