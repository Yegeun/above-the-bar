import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:above_the_bar/models/programs_model.dart';
import 'package:above_the_bar/repositories/programs/programs_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'program_event.dart';
part 'program_state.dart';

class ProgramBloc extends Bloc<ProgramEvent, ProgramState> {
  final ProgramRepository _programRepository;
  StreamSubscription? _programSubscription;

  ProgramBloc({required ProgramRepository programRepository})
      : _programRepository = programRepository,
        super(ProgramLoaded()) {
    // Changed to Loaded from Loading
    on<LoadProgram>(_onLoadProgram);
    on<UpdateProgram>(_onUpdatePrograms);
    on<CreateProgram>(_onCreateProgram);
  }

  void _onLoadProgram(LoadProgram event, Emitter<ProgramState> emit) {
    _programSubscription?.cancel();
    _programSubscription = _programRepository.getProgram().listen(
          (programs) => add(
            UpdateProgram(programs),
          ),
        );
  }

  void _onUpdatePrograms(
    UpdateProgram event,
    Emitter<ProgramState> emit,
  ) {
    emit(
      ProgramLoaded(programs: event.program),
    );
  }

  void _onCreateProgram(
    CreateProgram event,
    Emitter<ProgramState> emit,
  ) async {
    var tempProgram = event.program;
    _programSubscription?.cancel();
    await _programRepository.createNewProgram(tempProgram);
    if (kDebugMode) {
      print(tempProgram);
    }
    emit(ProgramLoaded());
  }
}
