part of 'create_new_exercise_bloc.dart';

@immutable
abstract class CreateNewExerciseEvent extends Equatable {
  const CreateNewExerciseEvent();

  @override
  List<Object> get props => [];
}

class LoadNewExercises extends CreateNewExerciseEvent {}

class UpdateNewExercises extends CreateNewExerciseEvent {
  //write
  final Exercise singleExercise;
  final String email;

  const UpdateNewExercises(this.singleExercise, this.email);

  @override
  List<Object> get props => [Exercise(name: singleExercise.name), email];

// @override
// String toString() => 'UpdateExercise { exercise: $exercise }';
}

class CreateNewExercise extends CreateNewExerciseEvent {
  final Exercise singleExercise;
  final String email;

  const CreateNewExercise(this.singleExercise, this.email);

  @override
  List<Object> get props => [singleExercise.name, email];
}

class DeleteExercise extends CreateNewExerciseEvent {
  final Exercise singleExercise;
  final String email;

  const DeleteExercise(this.singleExercise, this.email);

  @override
  List<Object> get props => [singleExercise.name, email];
}
