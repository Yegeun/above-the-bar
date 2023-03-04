import 'package:above_the_bar/models/athlete_data_entry_model.dart';
import 'package:above_the_bar/repositories/athlete_data/base_athlete_data_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AthleteDataRepository extends BaseAthleteDataRepository {
  final FirebaseFirestore _firebaseFirestore;

  AthleteDataRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createAthleteDataEntry(AthleteDataEntryModel entry) async {
    print('Athlete name ${entry.email} ');
    await _firebaseFirestore
        .collection('athletes')
        .doc(entry.email) //TODO change for the login
        .collection('data')
        .doc()
        .set(entry.toDocument());
  }

  @override
  Stream<List<AthleteDataEntryModel>> getDataEntries(email) {
    return _firebaseFirestore
        .collection('athletes')
        .doc(email)
        .collection('data')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AthleteDataEntryModel.fromSnapshot(doc))
          .toList();
    });
  }
}
