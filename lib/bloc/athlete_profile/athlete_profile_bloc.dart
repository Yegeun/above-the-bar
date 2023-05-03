import 'dart:async';

import 'package:above_the_bar/repositories/athlete_profile/athlete_profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:const_date_time/const_date_time.dart';

import 'package:equatable/equatable.dart';
import 'package:above_the_bar/models/athlete_profile_model.dart';

part 'athlete_profile_event.dart';

part 'athlete_profile_state.dart';

class AthleteProfileBloc
    extends Bloc<AthleteProfileEvent, AthleteProfileState> {
  final AthleteProfileRepository _athleteProfileRepository;
  StreamSubscription? _athleteProfileSubscription;

  AthleteProfileBloc(
      {required AthleteProfileRepository athleteProfileRepository})
      : _athleteProfileRepository = athleteProfileRepository,
        super(AthleteProfileLoaded()) {
    on<LoadAthleteProfile>(_onLoadAthleteProfile);
    on<UpdateAthleteProfile>(_onUpdateAthleteProfile);
    on<CreateAthleteProfile>(_onCreateAthleteProfile);
    on<UpdateCreateAthleteProfile>(_onUpdateCreateAthleteProfile);
    on<UpdatePersonalBestProfile>(_onUpdatePersonalBestProfile);
    on<UpdateWeightsOnProfile>(_onUpdateWeightsOnProfile);
  }

  void _onLoadAthleteProfile(
      LoadAthleteProfile event, Emitter<AthleteProfileState> emit) {
    _athleteProfileSubscription?.cancel();
    _athleteProfileSubscription =
        _athleteProfileRepository.getProfile(event.email).listen(
              (athleteProfile) => add(
                UpdateAthleteProfile(athleteProfile),
              ),
            );
  }

  void _onUpdateAthleteProfile(
      UpdateAthleteProfile event, Emitter<AthleteProfileState> emit) {
    emit(
      AthleteProfileLoaded(athleteProfile: event.athleteProfile),
    );
  }

  void _onCreateAthleteProfile(
      CreateAthleteProfile event, Emitter<AthleteProfileState> emit) async {
    var tempAthleteProfile = event.athleteProfile;
    _athleteProfileSubscription?.cancel();
    await _athleteProfileRepository.updateProfile(tempAthleteProfile);
    emit(AthleteProfileLoaded());
  }

  void _onUpdateCreateAthleteProfile(UpdateCreateAthleteProfile event,
      Emitter<AthleteProfileState> emit) async {
    _athleteProfileSubscription?.cancel();

    await _athleteProfileRepository.updateAthleteProfile(
        event.email,
        event.coachEmail,
        event.programId,
        event.startDate,
        event.week,
        event.session);
    emit(AthleteProfileCreateUpdated());
    emit(AthleteProfileLoaded());
  }

  void _onUpdatePersonalBestProfile(UpdatePersonalBestProfile event,
      Emitter<AthleteProfileState> emit) async {
    _athleteProfileSubscription?.cancel();

    await _athleteProfileRepository.updatePersonalBestProfile(
        event.email, event.exercise, event.weight);
    emit(AthleteProfilePersonalBestUpdated());
    emit(AthleteProfileLoaded());
  }

  void _onUpdateWeightsOnProfile(
      UpdateWeightsOnProfile event, Emitter<AthleteProfileState> emit) async {
    _athleteProfileSubscription?.cancel();

    await _athleteProfileRepository.updateWeightProfile(
        event.email,
        event.weightClass,
        event.snatch,
        event.cleanAndJerk,
        event.hangSnatch,
        event.powerSnatch,
        event.blockSnatch,
        event.snatchDeadlift,
        event.clean,
        event.hangClean,
        event.powerClean,
        event.blockClean,
        event.cleanDeadlift,
        event.jerkFromRack,
        event.powerJerk,
        event.jerkFromBlock,
        event.pushPress,
        event.backSquat,
        event.frontSquat,
        event.strictPress,
        event.strictRow,
        event.backHold,
        event.trunkHold,
        event.sideHold);
    emit(AthleteProfileWeightClassUpdated());
    emit(AthleteProfileLoaded());
  }
}
