import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:above_the_bar/models/exercise_model.dart';
import 'package:above_the_bar/repositories/exerciselist/exercise_repository.dart';
import 'package:equatable/equatable.dart';

part 'exercise_event.dart';

part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final ExerciseRepository _exerciseRepository;
  StreamSubscription? _exerciseSubscription;

  ExerciseBloc({required ExerciseRepository exerciseRepository})
      : _exerciseRepository = exerciseRepository,
        super(ExerciseLoading()) {
    on<LoadExercises>(_onLoadExercises);
    on<UpdateExercises>(_onUpdateExercises);
  }

  void _onLoadExercises(LoadExercises event, Emitter<ExerciseState> emit) {
    _exerciseSubscription?.cancel();
    _exerciseSubscription =
        _exerciseRepository.getAllExercises(event.email).listen(
              (exercise) => add(
                UpdateExercises(exercise, event.email),
              ),
            );
  }

  void _onUpdateExercises(
    UpdateExercises event,
    Emitter<ExerciseState> emit,
  ) {
    emit(
      ExerciseLoaded(exercises: event.exercises),
    );
  }
}
