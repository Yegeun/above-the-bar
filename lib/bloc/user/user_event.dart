part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUser extends UserEvent {}

class UpdateUser extends UserEvent {
  final UserPublicModel user;

  const UpdateUser(this.user);

  @override
  List<Object> get props => [user];
}

class CreateUser extends UserEvent {
  final UserPublicModel user;

  const CreateUser(this.user);

  @override
  List<Object> get props => [user];
}
