import 'package:above_the_bar/models/models.dart';

abstract class BaseAthleteProfileRepository {
  Future<void> updateProfile(AthleteProfileModel user);

  //update from dropdown
  Future<void> updateAthleteProfile(
      String email,
      String blockId,
      DateTime startDate,
      int maxWeek,
      int maxSession,
      int maxExercise,
      int week,
      int session);

  Future<void> deleteAthlete(String email);

  Stream<AthleteProfileModel> getProfile(String email);

  Stream<List<String>> getAthleteList();
}
