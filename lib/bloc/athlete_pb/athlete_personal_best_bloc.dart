import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:above_the_bar/models/athlete_pb_model.dart';
import 'package:above_the_bar/repositories/athlete_pb/athlete_pb_repository.dart';
import 'package:flutter/foundation.dart';

part 'athlete_personal_best_event.dart';

part 'athlete_personal_best_state.dart';

class AthletePersonalBestBloc
    extends Bloc<AthletePersonalBestEvent, AthletePersonalBestState> {
  final AthletePersonalBestRepository _athletePersonalBestRepository;
  StreamSubscription? _athletePersonalBestSubscription;

  AthletePersonalBestBloc(
      {required AthletePersonalBestRepository athletePersonalBestRepository})
      : _athletePersonalBestRepository = athletePersonalBestRepository,
        super(AthletePersonalBestLoading()) {
    on<LoadAthletePersonalBest>(_onLoadAthletePersonalBest);
    on<UpdateAthletePersonalBest>(_onUpdateAthletePersonalBest);
    on<CreateAthletePersonalBest>(_onCreateAthletePersonalBest);
  }

  void _onLoadAthletePersonalBest(
      LoadAthletePersonalBest event, Emitter<AthletePersonalBestState> emit) {
    _athletePersonalBestSubscription?.cancel();
    _athletePersonalBestSubscription = _athletePersonalBestRepository
        .getAthletePersonalBest('yegeunator@gmail.com')
        .listen(
          (pb) => add(
            UpdateAthletePersonalBest(pb),
          ),
        );
  }

  void _onUpdateAthletePersonalBest(
    UpdateAthletePersonalBest event,
    Emitter<AthletePersonalBestState> emit,
  ) {
    emit(
      AthletePersonalBestLoaded(pb: event.pb),
    );
  }

  void _onCreateAthletePersonalBest(
    CreateAthletePersonalBest event,
    Emitter<AthletePersonalBestState> emit,
  ) async {
    var tempData = event.entryModel;
    _athletePersonalBestSubscription?.cancel();
    await _athletePersonalBestRepository.createAthletePersonalBest(tempData);
    if (kDebugMode) {
      print(tempData);
    }
    emit(AthletePersonalBestLoaded());
  }
}
