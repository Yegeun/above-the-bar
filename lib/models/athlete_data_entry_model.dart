import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AthleteDataEntryModel extends Equatable {
  final String email;
  final DateTime date;
  final int bw;
  final String exercise;
  final int sets;
  final int reps;
  final int load;
  final String id;

  const AthleteDataEntryModel({
    required this.email,
    required this.date,
    required this.bw,
    required this.exercise,
    required this.sets,
    required this.reps,
    required this.load,
    this.id = '',
  });

  @override
  List<Object?> get props => [
        id,
        email, //TODO Probably take this out
        date,
        bw,
        exercise,
        sets,
        reps,
        load,
      ];

  static AthleteDataEntryModel fromSnapshot(DocumentSnapshot snap) {
    AthleteDataEntryModel dataEntry = AthleteDataEntryModel(
      id: snap.id,
      email: snap['email'],
      date: snap['date'].toDate(),
      bw: snap['bw'],
      exercise: snap['exercise'],
      sets: snap['sets'],
      reps: snap['reps'],
      load: snap['load'],
    );
    return dataEntry;
  }

  //To write in the firebase
  Map<String, Object> toDocument() {
    if (date.toString().isEmpty || bw.toString().isEmpty) {
      return {
        'email': email, //TODO Probably take this out
        'date': DateTime.now(),
        'bw': 73,
        'exercise': exercise,
        'sets': sets,
        'reps': reps,
        'load': load,
      };
    }
    return {
      'email': email, //TODO Probably take this out
      'date': date,
      'bw': bw,
      'exercise': exercise,
      'sets': sets,
      'reps': reps,
      'load': load,
    };
  }

  static List<int> getHighestRecordedWeightAndReps(
      List<AthleteDataEntryModel> dataEntries, String exerciseName) {
    try {
      final filteredEntries =
          dataEntries.where((entry) => entry.exercise == exerciseName).toList();
      final highestEntry =
          filteredEntries.reduce((a, b) => a.load > b.load ? a : b);
      return [
        highestEntry.load,
        highestEntry.reps
      ]; // you can what you want from highestEntry
    } catch (e) {
      return [0, 0];
    }
  }

  static List<AthleteDataEntryModel> getFilteredExercises(
      List<AthleteDataEntryModel> dataEntries, String exerciseName) {
    try {
      final filteredEntries =
          dataEntries.where((entry) => entry.exercise == exerciseName).toList();
      return [...filteredEntries]; // filtered entries
    } catch (e) {
      return [];
    }
  }
}
