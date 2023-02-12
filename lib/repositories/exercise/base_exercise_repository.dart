import '/models/models.dart';

abstract class BaseExerciseRepository {
  Stream<List<Exercise>> getAllExercises();
}
