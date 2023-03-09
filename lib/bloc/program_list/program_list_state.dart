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
