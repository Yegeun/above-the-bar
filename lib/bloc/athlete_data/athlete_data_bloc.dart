import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:above_the_bar/models/athlete_data_entry_model.dart';
import 'package:above_the_bar/repositories/athlete_data/athlete_data_repository.dart';
import 'package:flutter/foundation.dart';

part 'athlete_data_event.dart';

part 'athlete_data_state.dart';

class AthleteDataBloc extends Bloc<AthleteDataEvent, AthleteDataState> {
  final AthleteDataRepository _athleteDataRepository;
  StreamSubscription? _athleteDataSubscription;

  AthleteDataBloc({required AthleteDataRepository athleteDataRepository})
      : _athleteDataRepository = athleteDataRepository,
        super(AthleteDataLoading()) {
    on<LoadAthleteData>(_onLoadAthleteData);
    on<UpdateAthleteData>(_onUpdateAthleteData);
    on<CreateAthleteData>(_onCreateAthleteData);
    on<DeleteAthleteData>(_onDeleteAthleteData);
  }

  void _onLoadAthleteData(
      LoadAthleteData event, Emitter<AthleteDataState> emit) {
    _athleteDataSubscription?.cancel();
    //TODO - change this to get athlete data for a specific athlete
    _athleteDataSubscription =
        _athleteDataRepository.getDataEntries('yegeunator@gmail.com').listen(
              (entries) => add(
                UpdateAthleteData(entries),
              ),
            );
  }

  void _onUpdateAthleteData(
    UpdateAthleteData event,
    Emitter<AthleteDataState> emit,
  ) {
    emit(
      AthleteDataLoaded(entries: event.entries),
    );
  }

  void _onCreateAthleteData(
    CreateAthleteData event,
    Emitter<AthleteDataState> emit,
  ) async {
    var tempAthlete = event.entryModel;
    _athleteDataSubscription?.cancel();
    await _athleteDataRepository.createAthleteDataEntry(tempAthlete);
    if (kDebugMode) {
      print(tempAthlete);
    }
    emit(AthleteDataLoaded());
  }

  void _onDeleteAthleteData(
    DeleteAthleteData event,
    Emitter<AthleteDataState> emit,
  ) async {
    emit(AthleteDataDeleting());
    await _athleteDataRepository.delete(event.entryModel.id);
    emit(AthleteDataDeleted());
    print('Delete Successful 2');
    _athleteDataSubscription?.cancel();
    //TODO - change this to get athlete data for a specific athlete
    _athleteDataSubscription =
        _athleteDataRepository.getDataEntries('yegeunator@gmail.com').listen(
              (entries) => add(
                UpdateAthleteData(entries),
              ),
            );

    // emit(UpdateAthleteData(event.entries));
  }
}
