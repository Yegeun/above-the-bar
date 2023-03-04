import '/models/models.dart';

abstract class BaseAthletePersonalBestRepository {
  Future<void> createAthletePersonalBest(AthletePersonalBestModel pb);
  Stream<List<AthletePersonalBestModel>> getAthletePersonalBest(email);
}
