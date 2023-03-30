import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AthleteModel extends Equatable {
  final String name;
  final String email;
  final String block;
  final DateTime startDate;

  const AthleteModel({
    required this.name,
    required this.email,
    required this.block,
    required this.startDate,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        block,
        startDate,
      ];

  static AthleteModel fromSnapshot(DocumentSnapshot snap) {
    AthleteModel athlete = AthleteModel(
      name: snap['name'],
      email: snap['email'],
      block: snap['block'],
      startDate: snap['startDate'].toDate(),
    );
    return athlete;
  }

  //To write in the firebase
  Map<String, Object> toDocument() {
    if (block.toString().isEmpty && startDate.toString().isEmpty) {
      return {
        'name': name,
        'email': email,
        'block': '',
        'startDate': DateTime.now(),
      };
    }
    return {
      'name': name,
      'email': email,
      'block': block,
      'startDate': startDate,
    };
  }

  AthleteModel copyWith({required String block}) {
    return AthleteModel(
      name: name,
      email: email,
      block: block,
      startDate: startDate,
    );
  }
}
