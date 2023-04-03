import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:above_the_bar/repositories/programs/programs_repository.dart';
import 'package:equatable/equatable.dart';

part 'program_list_event.dart';

part 'program_list_state.dart';

class ProgramListBloc extends Bloc<ProgramListEvent, ProgramListState> {
  final ProgramRepository _programListRepository;
  StreamSubscription? _programListSubscription;

  ProgramListBloc({required ProgramRepository programListRepository})
      : _programListRepository = programListRepository,
        super(ProgramListLoading()) {
    // Changed to Loaded from Loading
    on<LoadProgramList>(_onLoadProgramList);
    on<UpdateProgramList>(_onUpdateProgramList);
    on<DeleteProgram>(_onDeleteProgram);
    on<CopyProgram>(_onCopyProgram);
  }

  void _onLoadProgramList(
      LoadProgramList event, Emitter<ProgramListState> emit) {
    _programListSubscription?.cancel();
    _programListSubscription =
        _programListRepository.getProgramList(event.coachEmail).listen(
              (programList) => add(
                UpdateProgramList(programList, event.coachEmail),
              ),
            );
  }

  void _onUpdateProgramList(
    UpdateProgramList event,
    Emitter<ProgramListState> emit,
  ) {
    emit(
      ProgramListLoaded(
          programList: event.programList, coachEmail: event.coachEmail),
    );
  }

  void _onDeleteProgram(
    DeleteProgram event,
    Emitter<ProgramListState> emit,
  ) async {
    emit(ProgramListDeleting());
    await _programListRepository.deleteProgram(event.program, event.coachEmail);
    emit(ProgramListDeleted());
    print('Delete Successful 2');
    _programListSubscription?.cancel();
    _programListSubscription =
        _programListRepository.getProgramList(event.coachEmail).listen(
              (programList) => add(
                UpdateProgramList(programList, event.coachEmail),
              ),
            );
    // emit(UpdateAthleteData(event.entries));
  }

  void _onCopyProgram(
    CopyProgram event,
    Emitter<ProgramListState> emit,
  ) async {
    emit(ProgramListCopying());
    await _programListRepository.copyProgram(
        event.program, event.copyProgram, event.coachEmail);
    emit(ProgramListCopied());
    print('Copy Successful');
    _programListSubscription?.cancel();
    _programListSubscription =
        _programListRepository.getProgramList(event.coachEmail).listen(
              (programList) => add(
                UpdateProgramList(programList, event.coachEmail),
              ),
            );
  }
}
