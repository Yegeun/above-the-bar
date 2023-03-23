import 'package:above_the_bar/models/models.dart';

abstract class BaseUserRepository {
  Future<void> createUser(UserModel user);
}
