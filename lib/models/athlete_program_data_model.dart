import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AthleteProgramDataModel extends Equatable {
  final String email;
  final String id; //ProgramName + StartDate
  final DateTime startDate;
  final String programName;

  const AthleteProgramDataModel({
    required this.email,
    required this.id,
    required this.startDate,
    required this.programName,
  });

  @override
  List<Object?> get props => [
        email, //TODO Probably take this out
        id,
        startDate,
        programName,
      ];

  static AthleteProgramDataModel fromSnapshot(DocumentSnapshot snap) {
    AthleteProgramDataModel athleteProgramData = AthleteProgramDataModel(
      email: snap['email'],
      id: snap['id'],
      startDate: snap['startDate'].toDate(),
      programName: snap['programName'],
    );
    return athleteProgramData;
  }

  //To write in the firebase
  Map<String, Object> toDocument() {
    return {
      'email': email, //TODO Probably take this out
      'startDate': startDate,
      'programName': programName,
    };
  }
}
