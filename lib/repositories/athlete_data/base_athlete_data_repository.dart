import '/models/models.dart';

abstract class BaseAthleteDataRepository {
  Future<void> createAthleteDataEntry(AthleteDataEntryModel entry);

  Stream<List<AthleteDataEntryModel>> getDataEntries(email);

  Future<void> delete(String documentId, String email);
}
