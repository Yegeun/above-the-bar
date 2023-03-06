import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProgramModel extends Equatable {
  final String programName;
  final String name;
  final int week;
  final int session;
  final int exerciseNum;

  final String exercise;
  final int sets;
  final int reps;
  final int intensity;
  final String comments;

  const ProgramModel({
    required this.programName,
    required this.name,
    required this.week,
    required this.session,
    required this.exerciseNum,
    required this.exercise,
    required this.sets,
    required this.reps,
    required this.intensity,
    required this.comments,
  });

  @override
  List<Object?> get props => [
        programName,
        name,
        week,
        session,
        exerciseNum,
        exercise,
        sets,
        reps,
        intensity,
        comments,
      ];

  //To write in the firebase
  Map<String, Object> toDocument() {
    return {
      'programName': programName,
      'name': name,
      'week': week,
      'session': session,
      'exerciseNum': exerciseNum,
      'exercise': exercise,
      'sets': sets,
      'reps': reps,
      'intensity': intensity,
      'comments': comments,
    };
  }

  static ProgramModel fromSnapshot(DocumentSnapshot snap) {
    ProgramModel program = ProgramModel(
      programName: snap['programName'],
      name: snap['name'],
      week: snap['week'],
      session: snap['session'],
      exerciseNum: snap['exerciseNum'],
      exercise: snap['exercise'],
      sets: snap['sets'],
      reps: snap['reps'],
      intensity: snap['intensity'],
      comments: snap['comments'],
    );
    return program;
  }
}
