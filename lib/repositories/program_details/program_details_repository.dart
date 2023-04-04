import 'package:above_the_bar/models/program_details_model.dart';
import 'package:above_the_bar/repositories/program_details/base_program_details_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProgramDetailsRepository extends BaseProgramsDetailsRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProgramDetailsRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<ProgramDetailsModel> getProgramDetails(
      String coachEmail, String programId) {
    return _firebaseFirestore
        .collection('coaches')
        .doc(coachEmail)
        .collection('programList') //Name of Program
        .doc(programId) // Name of the Document
        //return the fields of the document
        .snapshots()
        .map((snapshot) {
      return ProgramDetailsModel.fromSnapshot(snapshot);
    });
  }
}
