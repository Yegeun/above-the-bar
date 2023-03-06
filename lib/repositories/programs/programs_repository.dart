import 'package:above_the_bar/models/programs_model.dart';
import 'package:above_the_bar/repositories/programs/base_programs_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProgramRepository extends BaseProgramsRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProgramRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createNewProgram(ProgramModel program) async {
    print('Program exercise ${program.exercise}');
    await _firebaseFirestore
        .collection('coaches')
        .doc('stuart.martin') //TODO: Change to login user
        .collection('programs')
        .doc('program name')
        .collection(program.programName) //Name of Program
        .doc(program.name) // Name of the Document
        .set(program.toDocument());
  }

  @override
  Stream<List<ProgramModel>> getProgram() {
    return _firebaseFirestore
        .collection('coaches')
        .doc('stuart.martin')
        .collection('programs')
        .doc('program name')
        .collection('GPP1')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ProgramModel.fromSnapshot(doc))
          .toList();
    });
  }
}
