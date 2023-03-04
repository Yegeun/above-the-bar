import 'dart:async';

import 'package:above_the_bar/models/athlete_program_data_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:above_the_bar/repositories/athlete_program_data/athlete_program_data_repository.dart';
import 'package:flutter/foundation.dart';

part 'athlete_program_data_event.dart';
part 'athlete_program_data_state.dart';

class AthleteProgramDataBloc
    extends Bloc<AthleteProgramDataEvent, AthleteProgramDataState> {
  final AthleteProgramDataRepository _athleteProgramDataRepository;
  StreamSubscription? _athleteProgramDataSubscription;

  AthleteProgramDataBloc(
      {required AthleteProgramDataRepository athleteProgramDataRepository})
      : _athleteProgramDataRepository = athleteProgramDataRepository,
        super(AthleteProgramDataLoading()) {
    on<LoadAthleteProgramData>(_onLoadAthleteProgramData);
    on<UpdateAthleteProgramData>(_onUpdateAthleteProgramData);
    on<CreateAthleteProgramData>(_onCreateAthleteProgramData);
  }

  void _onLoadAthleteProgramData(
      LoadAthleteProgramData event, Emitter<AthleteProgramDataState> emit) {
    _athleteProgramDataSubscription?.cancel();
    //TODO - change this to get athlete data for a specific athlete
    _athleteProgramDataSubscription = _athleteProgramDataRepository
        .getAthleteProgramData('yegeunator@gmail.com')
        .listen(
          (data) => add(
            UpdateAthleteProgramData(data),
          ),
        );
  }

  void _onUpdateAthleteProgramData(
    UpdateAthleteProgramData event,
    Emitter<AthleteProgramDataState> emit,
  ) {
    emit(
      AthleteProgramDataLoaded(data: event.data),
    );
  }

  void _onCreateAthleteProgramData(
    CreateAthleteProgramData event,
    Emitter<AthleteProgramDataState> emit,
  ) async {
    var tempData = event.data;
    _athleteProgramDataSubscription?.cancel();
    await _athleteProgramDataRepository.createAthleteProgramData(tempData);
    if (kDebugMode) {
      print(tempData);
    }
    emit(AthleteProgramDataLoaded());
  }
}
