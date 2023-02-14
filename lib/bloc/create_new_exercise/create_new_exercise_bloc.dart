import 'dart:async';
import 'dart:math';

import 'package:above_the_bar/bloc/blocs.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:above_the_bar/models/single_exercise_model.dart';
import 'package:above_the_bar/repositories/create_new_exercise/create_new_exercise_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'create_new_exercise_event.dart';
part 'create_new_exercise_state.dart';

class CreateNewExerciseBloc
    extends Bloc<CreateNewExerciseEvent, CreateNewExerciseState> {
  final CreateNewExerciseRepository _createNewExerciseRepository;
  StreamSubscription? _exerciseSubscription;

  CreateNewExerciseBloc(
      {required CreateNewExerciseRepository createNewExerciseRepository})
      : _createNewExerciseRepository = createNewExerciseRepository,
        super(CreateNewExerciseLoaded()) {
    on<UpdateNewExercises>(_onUpdateNewExercises);
    on<CreateNewExercise>(_onAddCreateNewExercise);
  }

  void _onUpdateNewExercises(
    UpdateNewExercises event,
    Emitter<CreateNewExerciseState> emit,
  ) {
    emit(CreateNewExerciseLoaded(singleExercise: event.singleExercise));
  }

  void _onAddCreateNewExercise(
    CreateNewExercise event,
    Emitter<CreateNewExerciseState> emit,
  ) async {
    var tempExercise = event.singleExercise;
    _exerciseSubscription?.cancel();
    await _createNewExerciseRepository.createNewExercise(tempExercise);
    if (kDebugMode) {
      print("Exercise confirmed");
    }
    emit(CreateNewExerciseLoaded());
  }
}
