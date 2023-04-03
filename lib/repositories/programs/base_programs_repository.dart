import '/models/models.dart';

abstract class BaseProgramsRepository {
  Future<void> createNewProgram(ProgramModel program);

  Stream<List<ProgramModel>> getProgram(String athleteEmail, String coachEmail);

  Stream<List<String>> getProgramList();

  Future<void> deleteProgram(String programName);

  Future<void> copyProgram(String copyProgramName, String newCopyProgramName);
}
