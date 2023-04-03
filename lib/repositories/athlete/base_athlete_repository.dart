import '/models/models.dart';

abstract class BaseAthleteRepository {
  Future<void> createNewAthlete(AthleteModel athlete, String athleteCoachEmail);

  Future<void> deleteAthlete(AthleteModel athlete, String athleteCoachEmail);

  Stream<List<AthleteModel>> getAthletes(String athleteCoachEmail);
}
