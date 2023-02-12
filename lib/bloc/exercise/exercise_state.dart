part of 'exercise_bloc.dart';

abstract class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object> get props => [];
}

class ExerciseLoading extends ExerciseState {}

class ExerciseLoaded extends ExerciseState {
  final List<Exercise> exercises;

  const ExerciseLoaded({this.exercises = const <Exercise>[]});

  @override
  List<Object> get props => [exercises];
}

// class ExerciseInitial extends ExerciseState {
//   @override
//   List<Object> get props => [];
// }
