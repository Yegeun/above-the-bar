import '/models/models.dart';

abstract class BaseAthleteProgramDataRepository {
  Future<void> createAthleteProgramData(AthleteProgramDataModel programData);
  Stream<List<AthleteProgramDataModel>> getAthleteProgramData(email);
}
