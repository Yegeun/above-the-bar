import 'package:above_the_bar/models/single_exercise_model.dart';
import 'package:above_the_bar/repositories/create_new_exercise/base_create_new_exercise_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateNewExerciseRepository extends BaseCreateNewExerciseRepository {
  final FirebaseFirestore _firebaseFirestore;

  CreateNewExerciseRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createNewExercise(SingleExercise name) async {
    print('It has got here ${name.newName}');
    await _firebaseFirestore
        .collection('exercises')
        .doc(name.newName)
        .set(name.toDocument());
  }
}
