import 'dart:async';

import 'package:above_the_bar/repositories/athlete_profile/athlete_profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'athlete_list_event.dart';

part 'athlete_list_state.dart';

class AthleteListBloc extends Bloc<AthleteListEvent, AthleteListState> {
  final AthleteProfileRepository _athleteListRepository;
  StreamSubscription? _athleteListSubscription;

  AthleteListBloc({required AthleteProfileRepository athleteListRepository})
      : _athleteListRepository = athleteListRepository,
        super(AthleteListLoading()) {
    // Changed to Loaded from Loading
    on<LoadAthleteList>(_onLoadAthleteList);
    on<UpdateAthleteList>(_onUpdateAthleteList);
    on<DeleteAthleteProfile>(_onDeleteAthleteProfile);
  }

  void _onLoadAthleteList(
      LoadAthleteList event, Emitter<AthleteListState> emit) {
    _athleteListSubscription?.cancel();
    _athleteListSubscription = _athleteListRepository.getAthleteList().listen(
          (athleteList) => add(
            UpdateAthleteList(athleteList),
          ),
        );
  }

  void _onUpdateAthleteList(
    UpdateAthleteList event,
    Emitter<AthleteListState> emit,
  ) {
    emit(
      AthleteListLoaded(athleteList: event.athleteList),
    );
  }

  void _onDeleteAthleteProfile(
    DeleteAthleteProfile event,
    Emitter<AthleteListState> emit,
  ) async {
    emit(AthleteListDeleting());
    await _athleteListRepository.deleteAthlete(event.athlete);
    emit(AthleteListDeleted());
    print('Delete Successful');
    _athleteListSubscription?.cancel();
    _athleteListSubscription = _athleteListRepository.getAthleteList().listen(
          (athleteList) => add(
            UpdateAthleteList(athleteList),
          ),
        );
    // emit(UpdateAthleteData(event.entries));
  }
}
