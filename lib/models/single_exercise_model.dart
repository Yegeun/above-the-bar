import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SingleExercise extends Equatable {
  final String newName;

  const SingleExercise({
    required this.newName,
  });

  @override
  List<Object?> get props => [
        newName,
      ];

  //To write in the firebase
  Map<String, Object> toDocument() {
    return {
      'name': newName,
    };
  }
}

//To access this list of exercises, use the following code: Exercise.exercises
