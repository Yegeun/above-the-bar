import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Program extends Equatable {
  final String name;

  const Program({
    required this.name,
  });

  @override
  List<Object?> get props => [
        name,
      ];

  //To write in the firebase
  Map<String, Object> toDocument() {
    return {
      'name': name,
      'name/exercise': name,
    };
  }
}
