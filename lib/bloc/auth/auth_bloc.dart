import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../auth_service.dart';
import '../../models/user_model.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc({
    required AuthService authService,
  })  : _authService = authService,
        super(
          authService.currentUser.isNotEmpty
              ? AuthState.authenticated(authService.currentUser)
              : AuthState.unauthenticated(),
        ) {
    on<AuthUserChanged>(_onAuthUserChanged);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  Future<void> _onAuthUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) async {
    await emit.forEach(
      _authService.user,
      onData: (user) {
        if (user.isNotEmpty) {
          return AuthState.authenticated(user);
        } else {
          return const AuthState.unauthenticated();
        }
      },
    );
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    unawaited(_authService.logout());
  }
}
