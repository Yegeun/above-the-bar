part of 'exercise_bloc.dart';

abstract class ExerciseEvent extends Equatable {
  const ExerciseEvent();

  @override
  List<Object> get props => [];
}

class LoadExercises extends ExerciseEvent {
  final String email;

  const LoadExercises(this.email);

  @override
  List<Object> get props => [email];
}

class UpdateExercises extends ExerciseEvent {
  final List<Exercise> exercises;
  final String email;

  const UpdateExercises(this.exercises, this.email);

  @override
  List<Object> get props => [exercises, email];

// @override
// String toString() => 'UpdateExercise { exercise: $exercise }';
}
