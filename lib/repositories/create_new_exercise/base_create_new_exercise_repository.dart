import 'package:above_the_bar/models/models.dart';

abstract class BaseCreateNewExerciseRepository {
  Future<void> createNewExercise(Exercise name, String email);

  Future<void> deleteExercise(Exercise name, String email);
}
