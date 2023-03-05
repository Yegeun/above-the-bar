import '/models/models.dart';

abstract class BaseAthleteRepository {
  Future<void> createNewAthlete(AthleteModel athlete);
  Stream<List<AthleteModel>> getAthletes();
}
