import 'package:above_the_bar/models/models.dart';

abstract class BaseAthleteProfileRepository {
  Future<void> updateProfile(AthleteProfileModel user);

  //update from dropdown
  Future<void> updateAthleteProfile(String email, String coachEmail,
      String programId, DateTime startDate, int week, int session);

  Future<void> deleteAthlete(String email);

  Stream<AthleteProfileModel> getProfile(String email);

  Stream<List<String>> getAthleteList();

  Future<void> updatePersonalBestProfile(
      String email, String exercise, int weight);

  Future<void> updateWeightProfile(
      String email,
      double weight,
      int snatch,
      int cleanAndJerk,
      int hangSnatch,
      int powerSnatch,
      int blockSnatch,
      int snatchDeadlift,
      int clean,
      int hangClean,
      int powerClean,
      int blockClean,
      int cleanDeadlift,
      int jerkFromRack,
      int powerJerk,
      int jerkFromBlock,
      int pushPress,
      int backSquat,
      int frontSquat,
      int strictPress,
      int strictRow,
      int trunkHold,
      int backHold,
      int sideHold);
}
