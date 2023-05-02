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

  //To write in the firebase
  Map<String, Object> toDocument() {
    return {
      'name': name,
    };
  }
}
