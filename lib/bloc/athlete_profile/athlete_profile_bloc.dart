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

    await _athleteProfileRepository.updateCoachProfile(
        event.email, event.blockId, event.startDate);
    emit(AthleteProfileCreateUpdated());
    emit(AthleteProfileLoaded());
  }
}
