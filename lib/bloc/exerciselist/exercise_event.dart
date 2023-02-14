part of 'exercise_bloc.dart';

abstract class ExerciseEvent extends Equatable {
  const ExerciseEvent();

  @override
  List<Object> get props => [];
}

class LoadExercises extends ExerciseEvent {}

class UpdateExercises extends ExerciseEvent {
  final List<Exercise> exercises;

  const UpdateExercises(this.exercises);

  @override
  List<Object> get props => [exercises];

  // @override
  // String toString() => 'UpdateExercise { exercise: $exercise }';
}
