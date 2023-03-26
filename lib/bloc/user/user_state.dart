part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
}

class UserLoaded extends UserState {
  final UserPublicModel user;

  const UserLoaded(
      {this.user = const UserPublicModel(email: 'empty', occupation: 'empty')});

  @override
  List<Object> get props => [user];
}

class UserUpdating extends UserState {
  final UserPublicModel user;

  const UserUpdating(
      {this.user = const UserPublicModel(email: 'empty', occupation: 'empty')});

  @override
  List<Object> get props => [user];
}
