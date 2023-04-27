import 'package:above_the_bar/models/athlete_program_data_model.dart';
import 'package:above_the_bar/repositories/athlete_program_data/base_athlete_program_data_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AthleteProgramDataRepository extends BaseAthleteProgramDataRepository {
  final FirebaseFirestore _firebaseFirestore;

  AthleteProgramDataRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createAthleteProgramData(programData) async {
    print('Athlete name ${programData.email} ');
    await _firebaseFirestore
        .collection('athletes')
        .doc(programData.email)
        .collection('program')
        .doc(programData.id)
        .set(programData.toDocument());
  }

  @override
  Stream<List<AthleteProgramDataModel>> getAthleteProgramData(email) {
    return _firebaseFirestore
        .collection('athletes')
        .doc(email)
        .collection('program')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AthleteProgramDataModel.fromSnapshot(doc))
          .toList();
    });
  }
}
