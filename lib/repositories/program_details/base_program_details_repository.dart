import '/models/models.dart';

abstract class BaseProgramsDetailsRepository {

  Stream<ProgramDetailsModel> getProgramDetails(String coachEmail,
      String programId);
}
