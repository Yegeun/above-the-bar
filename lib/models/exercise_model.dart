import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Exercise extends Equatable {
  final String name;

  const Exercise({
    required this.name,
  });

  @override
  List<Object?> get props => [
        name,
      ];

  static Exercise fromSnapshot(DocumentSnapshot snap) {
    Exercise exercise = Exercise(
      name: snap['name'],
    );
    return exercise;
  }

  static List<Exercise> exercises = [
    Exercise(
      name: 'Snatch',
    ),
    Exercise(
      name: 'Clean and Jerk',
    ),
    Exercise(
      name: 'Back Squat',
    ),
  ];
}
