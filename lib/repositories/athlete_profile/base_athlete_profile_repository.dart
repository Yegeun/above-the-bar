import 'package:above_the_bar/models/models.dart';

abstract class BaseAthleteProfileRepository {
  Future<void> updateProfile(AthleteProfileModel user);

  Future<void> deleteAthlete(String email);

  Stream<AthleteProfileModel> getProfile(String email);

  Stream<List<String>> getAthleteList();
}
