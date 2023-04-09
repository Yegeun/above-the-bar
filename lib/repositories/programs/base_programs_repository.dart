import '/models/models.dart';

abstract class BaseProgramsRepository {
  Future<void> createNewProgram(ProgramModel program, String coachEmail);

  Stream<List<ProgramModel>> getProgram(String athleteEmail, String coachEmail);

  Stream<List<String>> getProgramList(String coachEmail);

  Stream<ProgramDetailsModel> getProgramDetails(
      String coachEmail, String programId);

  Future<void> deleteProgram(String programName, String coachEmail);

  Future<void> copyProgram(
      String copyProgramName, String newCopyProgramName, String coachEmail);
}
