import '/models/models.dart';

abstract class BaseProgramsRepository {
  Future<void> createNewProgram(Program program);
  Stream<List<Program>> getProgram();
}
