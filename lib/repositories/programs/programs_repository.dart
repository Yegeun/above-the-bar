import 'package:above_the_bar/models/programs_model.dart';
import 'package:above_the_bar/repositories/programs/base_programs_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProgramRepository extends BaseProgramsRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProgramRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createNewProgram(ProgramModel program, String coachEmail) async {
    await _firebaseFirestore
        .collection('coaches')
        .doc(coachEmail)
        .collection(program.programName) //Name of Program
        .doc(
            'w${program.week.toString()}s${program.session.toString()}e${program.exerciseNum.toString()}') // Name of the Document
        .set(program.toDocument());

    //appends it to a list of programs this should also get the last program and add 1 to it
    await _firebaseFirestore
        .collection('coaches')
        .doc(coachEmail)
        .collection('programList') //Name of Program
        .doc(program.programName) // Name of the Document
        .set({
      'programName': program.programName,
      'weeks': program.week,
      'sessions': program.session,
      'exercises': program.exerciseNum
    });
  }

  @override
  Stream<List<ProgramModel>> getProgram(athleteEmail, coachEmail) {
    return _firebaseFirestore
        .collection('coaches')
        .doc(coachEmail)
        .collection(athleteEmail) // otherwise known as the coach's program id
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ProgramModel.fromSnapshot(doc))
          .toList();
    });
  }

  @override
  Stream<List<String>> getProgramList(String coachEmail) {
    //write a for loop
    return _firebaseFirestore
        .collection('coaches')
        .doc(coachEmail)
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

  @override
  Future<void> deleteProgram(String documentId, String coachEmail) async {
    final instance = FirebaseFirestore.instance;
    final batch = instance.batch();
    var collection =
        instance.collection('coaches').doc(coachEmail).collection(documentId);
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();

    var collectionDoc = FirebaseFirestore.instance
        .collection('coaches')
        .doc(coachEmail)
        .collection('programList');
    await collectionDoc.doc(documentId).delete();
  }

  @override
  Future<void> copyProgram(String copyDocumentId, String newCopyDocumentId,
      String coachEmail) async {
    // Get a reference to the original collection
    CollectionReference originalCollection = FirebaseFirestore.instance
        .collection('coaches')
        .doc(coachEmail)
        .collection(copyDocumentId);

    // Get a reference to the new collection
    CollectionReference newCollection = FirebaseFirestore.instance
        .collection('coaches')
        .doc(coachEmail)
        .collection(newCopyDocumentId);

    // Get the documents from the original collection
    QuerySnapshot originalDocuments = await originalCollection.get();

    // Loop through the original documents and copy them to the new collection
    for (var doc in originalDocuments.docs) {
      // Get the data from the original document
      Object? data = doc.data();

      // Set the new document ID
      String newDocumentId =
          doc.id.replaceAll(copyDocumentId, newCopyDocumentId);

      // Add the document to the new collection
      await newCollection.doc(newDocumentId).set(data as Map<String, dynamic>);
    }

    //copy the program list
    var collectionDoc = FirebaseFirestore.instance
        .collection('coaches')
        .doc(coachEmail)
        .collection('programList');

    var originalDoc = await collectionDoc.doc(copyDocumentId).get();
    var originalData = originalDoc.data();

    var newDoc = collectionDoc.doc(newCopyDocumentId);
    await newDoc.set(originalData!);
  }
}
