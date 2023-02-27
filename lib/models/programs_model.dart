import 'package:equatable/equatable.dart';

class Program extends Equatable {
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

  const Program({
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
}
