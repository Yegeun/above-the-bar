import 'package:above_the_bar/models/models.dart';
import 'package:above_the_bar/models/single_exercise_model.dart';

abstract class BaseCreateNewExerciseRepository {
  Future<void> createNewExercise(SingleExercise name);
}
