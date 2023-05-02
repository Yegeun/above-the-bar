part of 'exercise_bloc.dart';

abstract class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object> get props => [];
}

class ExerciseLoading extends ExerciseState {}

class ExerciseLoaded extends ExerciseState {
  final List<Exercise> exercises;
  final String email;

  const ExerciseLoaded({this.exercises = const <Exercise>[], this.email = ''});

  @override
  List<Object> get props => [exercises];
}
