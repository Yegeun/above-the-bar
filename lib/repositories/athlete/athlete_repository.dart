import 'package:above_the_bar/models/athlete_model.dart';
import 'package:above_the_bar/repositories/athlete/base_athlete_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AthleteRepository extends BaseAthleteRepository {
  final FirebaseFirestore _firebaseFirestore;

  AthleteRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createNewAthlete(AthleteModel athlete) async {
    print('Athlete name ${athlete.name} ');
    await _firebaseFirestore
        .collection('coaches')
        .doc('stuart.martin')
        .collection('athletes')
        .doc(athlete.email)
        .set(athlete.toDocument());
  }

  @override
  Stream<List<AthleteModel>> getAthletes() {
    return _firebaseFirestore
        .collection('coaches')
        .doc('stuart.martin')
        .collection('athletes')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AthleteModel.fromSnapshot(doc))
          .toList();
    });
  }

  @override
  Future<void> deleteAthlete(AthleteModel athlete) async {
    await _firebaseFirestore
        .collection('coaches')
        .doc('stuart.martin') //TODO: Change to login user
        .collection('athletes')
        .doc(athlete.email)
        .delete();
  }
}
