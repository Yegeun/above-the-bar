import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:above_the_bar/models/athlete_model.dart';
import 'package:above_the_bar/repositories/athlete/athlete_repository.dart';
import 'package:flutter/foundation.dart';

part 'athlete_event.dart';

part 'athlete_state.dart';

class AthleteBloc extends Bloc<AthleteEvent, AthleteState> {
  final AthleteRepository _athleteRepository;
  StreamSubscription? _athleteSubscription;

  AthleteBloc({required AthleteRepository athleteRepository})
      : _athleteRepository = athleteRepository,
        super(AthleteLoading()) {
    on<LoadAthlete>(_onLoadAthletes);
    on<UpdateAthletes>(_onUpdateAthletes);
    on<CreateAthlete>(_onCreateAthlete);
    on<DeleteAthlete>(_onDeleteAthlete);
  }

  void _onLoadAthletes(LoadAthlete event, Emitter<AthleteState> emit) {
    _athleteSubscription?.cancel();
    _athleteSubscription =
        _athleteRepository.getAthletes(event.coachEmail).listen(
              (athletes) => add(
                UpdateAthletes(athletes, event.coachEmail),
              ),
            );
  }

  void _onUpdateAthletes(
    UpdateAthletes event,
    Emitter<AthleteState> emit,
  ) {
    emit(
      AthleteLoaded(athletes: event.athletes, coachEmail: event.coachEmail),
    );
  }

  void _onCreateAthlete(
    CreateAthlete event,
    Emitter<AthleteState> emit,
  ) async {
    var tempAthlete = event.athlete;
    _athleteSubscription?.cancel();
    await _athleteRepository.createNewAthlete(tempAthlete, event.coachEmail);
    if (kDebugMode) {
      print(tempAthlete);
    }
    emit(AthleteLoaded());
  }

  void _onDeleteAthlete(
    DeleteAthlete event,
    Emitter<AthleteState> emit,
  ) async {
    emit(AthleteDeleting());
    await _athleteRepository.deleteAthlete(event.athlete, event.coachEmail);
    emit(AthleteDeleted());
    _athleteSubscription?.cancel();
    _athleteSubscription =
        _athleteRepository.getAthletes(event.coachEmail).listen(
              (athletes) => add(
                UpdateAthletes(athletes, event.coachEmail),
              ),
            );
  }
}
