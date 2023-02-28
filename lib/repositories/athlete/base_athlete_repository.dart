import '/models/models.dart';

abstract class BaseAthleteRepository {
  Future<void> createNewAthlete(Athlete athlete);
  Stream<List<Athlete>> getAthletes();
}
