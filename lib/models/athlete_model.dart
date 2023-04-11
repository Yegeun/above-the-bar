import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AthleteModel extends Equatable {
  final String name;
  final String email;
  final String programId;
  final DateTime startDate;

  const AthleteModel({
    required this.name,
    required this.email,
    required this.programId,
    required this.startDate,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        programId,
        startDate,
      ];

  static AthleteModel fromSnapshot(DocumentSnapshot snap) {
    AthleteModel athlete = AthleteModel(
      name: snap['name'],
      email: snap['email'],
      programId: snap['programId'],
      startDate: snap['startDate'].toDate(),
    );
    return athlete;
  }

  //To write in the firebase
  Map<String, Object> toDocument() {
    if (programId.toString().isEmpty && startDate.toString().isEmpty) {
      return {
        'name': name,
        'email': email,
        'programId': '',
        'startDate': DateTime.now(),
      };
    }
    return {
      'name': name,
      'email': email,
      'programId': programId,
      'startDate': startDate,
    };
  }

  AthleteModel copyWith({required String programId}) {
    return AthleteModel(
      name: name,
      email: email,
      programId: programId,
      startDate: startDate,
    );
  }
}
