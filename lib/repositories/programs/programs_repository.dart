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
        .collection(program.programName) //Name of Program
        .doc(
            'w${program.week.toString()}s${program.session.toString()}e${program.exerciseNum.toString()}') // Name of the Document
        .set(program.toDocument());

    //appends it to a list of programs
    await _firebaseFirestore
        .collection('coaches')
        .doc('stuart.martin') //TODO: Change to login user
        .collection('programList') //Name of Program
        .doc(program.programName) // Name of the Document
        .set({'programName': program.programName});
  }

  @override
  Stream<List<ProgramModel>> getProgram() {
    return _firebaseFirestore
        .collection('coaches')
        .doc('stuart.martin')
        .collection('GPP1')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ProgramModel.fromSnapshot(doc))
          .toList();
    });
  }

  @override
  Stream<List<String>> getProgramList() {
    //write a for loop
    return _firebaseFirestore
        .collection('coaches')
        .doc('stuart.martin')
        .collection('programList')
        .snapshots()
        .map((snapshot) {
      List<String> programList = [];
      //return all document ids inside the collection
      for (var doc in snapshot.docs) {
        programList.add(doc.id);
      }
      return programList;
    });
  }
}
