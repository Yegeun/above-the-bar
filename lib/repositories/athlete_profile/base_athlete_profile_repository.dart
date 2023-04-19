import 'package:above_the_bar/models/models.dart';

abstract class BaseAthleteProfileRepository {
  Future<void> updateProfile(AthleteProfileModel user);

  //update from dropdown
  Future<void> updateAthleteProfile(String email, String programId,
      DateTime startDate, int week, int session);

  Future<void> deleteAthlete(String email);

  Stream<AthleteProfileModel> getProfile(String email);

  Stream<List<String>> getAthleteList();

  Future<void> updatePersonalBestProfile(
      String email, String exercise, int weight);
}
