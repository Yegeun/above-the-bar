import 'dart:async';

import 'package:above_the_bar/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:above_the_bar/models/user_model.dart';
import 'package:above_the_bar/repositories/user/user_repository.dart';
import 'package:flutter/foundation.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  StreamSubscription? _userSubscription;

  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserLoading()) {
    on<LoadUser>(_onLoadUser);
    on<UpdateUser>(_onUpdateUser);
    on<CreateUser>(_onCreateUser);
  }

  void _onLoadUser(LoadUser event, Emitter<UserState> emit) {
    _userSubscription?.cancel();
    _userSubscription = _userRepository.getUser(event.email).listen(
          (user) => add(
            UpdateUser(user),
          ),
        );
  }

  void _onUpdateUser(UpdateUser event, Emitter<UserState> emit) {
    emit(
      UserLoaded(user: event.user),
    );
  }

  void _onCreateUser(CreateUser event, Emitter<UserState> emit) async {
    var tempUser = event.user;
    _userSubscription?.cancel();
    await _userRepository.createUser(tempUser);
    if (kDebugMode) {
      print(tempUser);
    }
    emit(UserLoaded());
  }
}
