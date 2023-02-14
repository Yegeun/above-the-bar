part of 'create_new_exercise_bloc.dart';

abstract class CreateNewExerciseState extends Equatable {
  const CreateNewExerciseState();

  @override
  List<Object> get props => [];
}

class CreateNewExerciseLoading extends CreateNewExerciseState {}

class CreateNewExerciseLoaded extends CreateNewExerciseState {
  final SingleExercise singleExercise;

  const CreateNewExerciseLoaded(
      {this.singleExercise = const SingleExercise(newName: 'empty')});

  @override
  List<Object> get props => [singleExercise];
}
