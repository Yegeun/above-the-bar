import 'package:above_the_bar/models/models.dart';

import 'base_athlete_profile_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AthleteProfileRepository implements BaseAthleteProfileRepository {
  final FirebaseFirestore _firebaseFirestore;

  AthleteProfileRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> updateProfile(AthleteProfileModel user) async {
    await _firebaseFirestore
        .collection('athletes')
        .doc(user.email)
        .set(user.toDocument());
  }

  @override
  Future<void> updateAthleteProfile(String email, String programId,
      DateTime startDate, int week, int session) async {
    await _firebaseFirestore.collection('athletes').doc(email).update({
      'programId': programId,
      'startDate': startDate,
      'week': week,
      'session': session
    });
  }

  @override
  Stream<AthleteProfileModel> getProfile(String email) {
    return _firebaseFirestore
        .collection('athletes')
        .doc(email)
        .snapshots()
        .map((docSnapshot) => AthleteProfileModel.fromSnapshot(docSnapshot));
  }

  @override
  Stream<List<String>> getAthleteList() {
    //write a for loop
    return _firebaseFirestore
        .collection('athletes')
        .snapshots()
        .map((snapshot) {
      List<String> athleteList = [];
      //return all document ids inside the collection
      for (var doc in snapshot.docs) {
        athleteList.add(doc.id);
      }
      return athleteList;
    });
  }

  @override
  Future<void> deleteAthlete(String email) async {
    await _firebaseFirestore.collection('athletes').doc(email).delete();
  }

  @override
  Future<void> updatePersonalBestProfile(
      String email, String exercise, int weight) async {
    await _firebaseFirestore.collection('athletes').doc(email).update({
      exercise: weight,
    });
  }

  @override
  Future<void> updateWeightProfile(
      String email,
      double weightCat,
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
      int sideHold) async {
    _firebaseFirestore.collection('athletes').doc(email).update({
      'weightClass': weightCat,
      'Snatch': snatch,
      'Clean and Jerk': cleanAndJerk,
      'Hang Snatch': hangSnatch,
      'Power Snatch': powerSnatch,
      'Block Snatch': blockSnatch,
      'Snatch Deadlift': snatchDeadlift,
      'Clean': clean,
      'Hang Clean': hangClean,
      'Power Clean': powerClean,
      'Block Clean': blockClean,
      'Clean Deadlift': cleanDeadlift,
      'Jerk from Rack': jerkFromRack,
      'Power Jerk': powerJerk,
      'Jerk from Block': jerkFromBlock,
      'Push Press': pushPress,
      'Back Squat': backSquat,
      'Front Squat': frontSquat,
      'Strict Press': strictPress,
      'Strict Row': strictRow,
      'Trunk Hold': trunkHold,
      'Back Hold': backHold,
      'Side Hold': sideHold,
    });
  }
}
