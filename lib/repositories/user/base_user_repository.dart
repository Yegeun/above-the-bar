import 'package:above_the_bar/models/models.dart';

abstract class BaseUserRepository {
  Future<void> createUser(UserPublicModel user);

  Stream<UserPublicModel> getUser(String email);
}
