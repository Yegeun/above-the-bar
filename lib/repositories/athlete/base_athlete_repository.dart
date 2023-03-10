import '/models/models.dart';

abstract class BaseAthleteRepository {
  Future<void> createNewAthlete(AthleteModel athlete);

  Future<void> deleteAthlete(AthleteModel athlete);

  Stream<List<AthleteModel>> getAthletes();
}
