import '/models/models.dart';

abstract class BaseProgramsRepository {
  Future<void> createNewProgram(ProgramModel program);

  Stream<List<ProgramModel>> getProgram();

  Stream<List<String>> getProgramList();

  Future<void> deleteProgram(String programName);
}
