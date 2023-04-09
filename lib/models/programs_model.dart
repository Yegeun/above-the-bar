import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProgramModel extends Equatable {
  final String programName;
  final int week;
  final int session;
  final int exerciseNum;

  final String exercise;
  final int sets;
  final int reps;
  final int intensity;
  final String comments;

  final int maxWeek;
  final int maxSession;
  final int maxExercise;

  const ProgramModel({
    required this.programName,
    required this.week,
    required this.session,
    required this.exerciseNum,
    required this.exercise,
    required this.sets,
    required this.reps,
    required this.intensity,
    required this.comments,
    required this.maxWeek,
    required this.maxSession,
    required this.maxExercise,
  });

  @override
  List<Object?> get props =>
      [
        programName,
        week,
        session,
        exerciseNum,
        exercise,
        sets,
        reps,
        intensity,
        comments,
        maxWeek,
        maxSession,
        maxExercise,
      ];

  //To write in the firebase
  Map<String, Object> toDocument() {
    return {
      'programName': programName,
      'week': week,
      'session': session,
      'exerciseNum': exerciseNum,
      'exercise': exercise,
      'sets': sets,
      'reps': reps,
      'intensity': intensity,
      'comments': comments,
      'maxWeek': maxWeek,
      'maxSession': maxSession,
      'maxExercise': maxExercise,
    };
  }

  static ProgramModel fromSnapshot(DocumentSnapshot snap) {
    ProgramModel program = ProgramModel(
      programName: snap['programName'],
      week: snap['week'],
      session: snap['session'],
      exerciseNum: snap['exerciseNum'],
      exercise: snap['exercise'],
      sets: snap['sets'],
      reps: snap['reps'],
      intensity: snap['intensity'],
      comments: snap['comments'],
      maxWeek: snap['maxWeek'],
      maxSession: snap['maxSession'],
      maxExercise: snap['maxExercise'],
    );
    return program;
  }

  static List<List<List<ProgramModel>>> getWeeksSessionsExercises(
      List<ProgramModel> programs) {
    List<List<List<ProgramModel>>> weeksSessionsExercises = [];

    // Group programs by week
    Map<int, List<ProgramModel>> programsByWeek = groupProgramsByWeek(programs);

    // For each week, group programs by session
    programsByWeek.forEach((week, weekPrograms) {
      Map<int, List<ProgramModel>> programsBySession =
      groupProgramsBySession(weekPrograms);

      // Create list of sessions for this week
      List<List<ProgramModel>> weekSessions = [];

      // For each session, add list of programs to list of sessions
      programsBySession.forEach((session, sessionPrograms) {
        weekSessions.add(sessionPrograms);
      });

      // Add list of sessions to list of weeks
      weeksSessionsExercises.add(weekSessions);
    });

    return weeksSessionsExercises;
  }

  static Map<int, List<ProgramModel>> groupProgramsByWeek(
      List<ProgramModel> programs) {
    Map<int, List<ProgramModel>> programsByWeek = {};
    for (var program in programs) {
      if (programsByWeek.containsKey(program.week)) {
        programsByWeek[program.week]!.add(program);
      } else {
        programsByWeek[program.week] = [program];
      }
    }
    return programsByWeek;
  }

  static Map<int, List<ProgramModel>> groupProgramsBySession(
      List<ProgramModel> programs) {
    Map<int, List<ProgramModel>> programsBySession = {};
    for (var program in programs) {
      if (programsBySession.containsKey(program.session)) {
        programsBySession[program.session]!.add(program);
      } else {
        programsBySession[program.session] = [program];
      }
    }
    return programsBySession;
  }
}
