import 'package:above_the_bar/repositories/create_new_exercise/base_create_new_exercise_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:above_the_bar/models/exercise_model.dart';

class CreateNewExerciseRepository extends BaseCreateNewExerciseRepository {
  final FirebaseFirestore _firebaseFirestore;

  CreateNewExerciseRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createNewExercise(Exercise name, String email) async {
    await _firebaseFirestore
        .collection('coaches')
        .doc(email)
        .collection('exercises')
        .doc(name.name)
        .set(name.toDocument());
  }

  @override
  Future<void> deleteExercise(Exercise name, String email) async {
    await _firebaseFirestore
        .collection('coaches')
        .doc(email)
        .collection('exercises')
        .doc(name.name)
        .delete();
  }
}
