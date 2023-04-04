import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProgramDetailsModel extends Equatable {
  final String programName;
  final int weeks;
  final int sessions;
  final int exercises;

  const ProgramDetailsModel({
    required this.programName,
    required this.weeks,
    required this.sessions,
    required this.exercises,
  });

  @override
  List<Object?> get props => [
        programName,
        weeks,
        sessions,
        exercises,
      ];

  static ProgramDetailsModel fromSnapshot(DocumentSnapshot snap) {
    ProgramDetailsModel programDetails = ProgramDetailsModel(
      programName: snap['programName'],
      weeks: snap['weeks'],
      sessions: snap['sessions'],
      exercises: snap['exercises'],
    );
    return programDetails;
  }
}
