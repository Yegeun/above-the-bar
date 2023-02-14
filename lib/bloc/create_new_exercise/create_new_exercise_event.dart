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
  final SingleExercise singleExercise;

  const UpdateNewExercises(this.singleExercise);

  @override
  List<Object> get props => [SingleExercise(newName: singleExercise.newName)];

  // @override
  // String toString() => 'UpdateExercise { exercise: $exercise }';
}

class CreateNewExercise extends CreateNewExerciseEvent {
  final SingleExercise singleExercise;

  const CreateNewExercise(this.singleExercise);

  @override
  List<Object> get props => [singleExercise.newName];
}
