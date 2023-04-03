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

  const ProgramListLoaded({this.programList = const <String>[]});

  @override
  List<Object> get props => [programList];
}

class ProgramListUpdating extends ProgramListState {
  final List<String> programList;

  const ProgramListUpdating({this.programList = const <String>[]});

  @override
  List<Object> get props => [programList];
}

class ProgramListDeleting extends ProgramListState {
  const ProgramListDeleting();

  @override
  List<Object> get props => [];
}

class ProgramListDeleted extends ProgramListState {
  const ProgramListDeleted({this.programs = const <String>[]});

  final List<String> programs;

  @override
  List<Object> get props => [programs];
}

class ProgramListCopying extends ProgramListState {
  const ProgramListCopying();

  @override
  List<Object> get props => [];
}

class ProgramListCopied extends ProgramListState {
  const ProgramListCopied({this.programs = const <String>[]});

  final List<String> programs;

  @override
  List<Object> get props => [programs];
}
