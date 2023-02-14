import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/exercise_model.dart';
import '/repositories/exerciselist/base_exercise_repository.dart';

class ExerciseRepository extends BaseExerciseRepository {
  final FirebaseFirestore _firebaseFirestore;

  ExerciseRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Exercise>> getAllExercises() {
    return _firebaseFirestore
        .collection('exercises')
        //.doc //If you want to access a specific document
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Exercise.fromSnapshot(doc)).toList();
    });
  }
}
