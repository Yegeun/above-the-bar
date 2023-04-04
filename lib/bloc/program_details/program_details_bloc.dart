import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:above_the_bar/models/program_details_model.dart';
import 'package:above_the_bar/repositories/program_details/program_details_repository.dart';

part 'program_details_event.dart';

part 'program_details_state.dart';

class ProgramDetailsBloc
    extends Bloc<ProgramDetailsEvent, ProgramDetailsState> {
  final ProgramDetailsRepository _programDetailsRepository;
  StreamSubscription? _programDetailsSubscription;

  ProgramDetailsBloc(
      {required ProgramDetailsRepository programDetailsRepository})
      : _programDetailsRepository = programDetailsRepository,
        super(ProgramDetailsLoaded()) {
    on<LoadProgramDetails>(_onLoadProgramDetails);
    on<UpdateProgramDetails>(_onUpdateProgramDetails);
  }

  void _onLoadProgramDetails(
      LoadProgramDetails event, Emitter<ProgramDetailsState> emit) {
    _programDetailsSubscription?.cancel();
    _programDetailsSubscription = _programDetailsRepository
        .getProgramDetails(event.coachEmail, event.programId)
        .listen(
          (programDetails) => add(
            UpdateProgramDetails(programDetails),
          ),
        );
  }

  void _onUpdateProgramDetails(
      UpdateProgramDetails event, Emitter<ProgramDetailsState> emit) {
    emit(
      ProgramDetailsLoaded(programDetails: event.programDetails),
    );
  }
}
