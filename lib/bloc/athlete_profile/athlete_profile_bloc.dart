import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'athlete_profile_event.dart';

part 'athlete_profile_state.dart';

class AthleteProfileBloc
    extends Bloc<AthleteProfileEvent, AthleteProfileState> {
  AthleteProfileBloc() : super(AthleteProfileInitial()) {
    on<AthleteProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
