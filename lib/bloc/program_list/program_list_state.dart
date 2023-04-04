part of 'program_list_bloc.dart';

@immutable
abstract class ProgramListState extends Equatable {
  const ProgramListState();

  @override
  List<Object> get props => [];
}

class ProgramListLoading extends ProgramListState {}

class ProgramListLoaded extends ProgramListState {
  final List<String> programList;
  final String coachEmail;

  const ProgramListLoaded(
      {this.programList = const <String>[], this.coachEmail = ''});

  @override
  List<Object> get props => [programList, coachEmail];
}

class ProgramListUpdating extends ProgramListState {
  final List<String> programList;
  final String coachEmail;

  const ProgramListUpdating(
      {this.programList = const <String>[], this.coachEmail = ''});

  @override
  List<Object> get props => [programList, coachEmail];
}

class ProgramListDeleting extends ProgramListState {
  const ProgramListDeleting();

  @override
  List<Object> get props => [];
}

class ProgramListDeleted extends ProgramListState {
  const ProgramListDeleted(
      {this.programs = const <String>[], this.coachEmail = ''});

  final List<String> programs;
  final String coachEmail;

  @override
  List<Object> get props => [programs, coachEmail];
}

class ProgramListCopying extends ProgramListState {
  const ProgramListCopying();

  @override
  List<Object> get props => [];
}

class ProgramListCopied extends ProgramListState {
  const ProgramListCopied(
      {this.programs = const <String>[],
      this.copyPrograms = const <String>[],
      this.coachEmail = ''});

  final List<String> programs;
  final List<String> copyPrograms;
  final String coachEmail;

  @override
  List<Object> get props => [programs, coachEmail];
}
