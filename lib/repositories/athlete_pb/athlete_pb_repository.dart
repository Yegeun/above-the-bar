import 'package:above_the_bar/models/athlete_pb_model.dart';
import 'package:above_the_bar/repositories/athlete_pb/base_athlete_pb_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AthletePersonalBestRepository extends BaseAthletePersonalBestRepository {
  final FirebaseFirestore _firebaseFirestore;

  AthletePersonalBestRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createAthletePersonalBest(AthletePersonalBestModel pb) async {
    print('Athlete name ${pb.email} ');
    await _firebaseFirestore
        .collection('athletes')
        .doc(pb.email) //TODO change for the login
        .collection('data')
        .doc(pb.exercise)
        .set(pb.toDocument());
  }

  @override
  Stream<List<AthletePersonalBestModel>> getAthletePersonalBest(email) {
    return _firebaseFirestore
        .collection('athletes')
        .doc(email)
        .collection('data')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AthletePersonalBestModel.fromSnapshot(doc))
          .toList();
    });
  }
}
