import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class AthleteDataEntryModel extends Equatable {
  final String email;
  final DateTime date;
  final DateTime startDate;
  final double bw;
  final String exercise;
  final int sets;
  final int reps;
  final int load;
  final String id;
  final String block;

  const AthleteDataEntryModel({
    required this.email,
    required this.date,
    required this.startDate,
    required this.bw,
    required this.exercise,
    required this.sets,
    required this.reps,
    required this.load,
    required this.block,
    this.id = '',
  });

  @override
  List<Object?> get props => [
        id,
        email,
        date,
        startDate,
        bw,
        exercise,
        sets,
        reps,
        load,
        block,
      ];

  static AthleteDataEntryModel fromSnapshot(DocumentSnapshot snap) {
    AthleteDataEntryModel dataEntry = AthleteDataEntryModel(
      id: snap.id,
      email: snap['email'],
      date: snap['date'].toDate(),
      startDate: snap['startDate'].toDate(),
      bw: snap['bw'],
      exercise: snap['exercise'],
      sets: snap['sets'],
      reps: snap['reps'],
      load: snap['load'],
      block: snap['block'],
    );
    return dataEntry;
  }

  //To write in the firebase
  Map<String, Object> toDocument() {
    if (date.toString().isEmpty || bw.toString().isEmpty) {
      return {
        'email': email,
        'date': DateTime.now(),
        'startDate': startDate,
        'bw': 73.0,
        'exercise': exercise,
        'sets': sets,
        'reps': reps,
        'load': load,
        'block': block,
      };
    }
    return {
      'email': email,
      'date': date,
      'startDate': startDate,
      'bw': bw,
      'exercise': exercise,
      'sets': sets,
      'reps': reps,
      'load': load,
      'block': block,
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

      // Group entries by date
      final entryGroups = groupBy(filteredEntries, (entry) => entry.date);

      // Select the highest load entry for each date
      final result = entryGroups.values
          .map((entries) => entries.reduce((a, b) => a.load > b.load ? a : b))
          .toList();
      //then sort by date
      result.sort((a, b) => a.date.compareTo(b.date));

      return result;
    } catch (e) {
      return [];
    }
  }

  static List<AthleteDataEntryModel> getFilteredExercisesOfEveryExercise(
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
