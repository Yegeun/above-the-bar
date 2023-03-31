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
}