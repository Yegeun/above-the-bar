part of 'auth_bloc.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final UserModel user;

  const AuthState._({required this.status, this.user = UserModel.empty});

  const AuthState.authenticated(UserModel user)
      : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}
