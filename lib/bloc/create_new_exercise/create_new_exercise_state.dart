part of 'create_new_exercise_bloc.dart';

abstract class CreateNewExerciseState extends Equatable {
  const CreateNewExerciseState();

  @override
  List<Object> get props => [];
}

class CreateNewExerciseLoading extends CreateNewExerciseState {}

class CreateNewExerciseLoaded extends CreateNewExerciseState {
  final Exercise singleExercise;
  final String email;

  const CreateNewExerciseLoaded(
      {this.singleExercise = const Exercise(name: 'empty'),
      this.email = 'exercise@gmail.com'});

  @override
  List<Object> get props => [singleExercise, email];
}

class CreateNewExerciseDeleting extends CreateNewExerciseState {}

class CreateNewExerciseDeleted extends CreateNewExerciseState {
  final Exercise singleExercise;
  final String email;

  const CreateNewExerciseDeleted(
      {this.singleExercise = const Exercise(name: 'empty'), this.email = ''});
}
