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

  const AthleteDataEntryModel({
    required this.email,
    required this.date,
    required this.bw,
    required this.exercise,
    required this.sets,
    required this.reps,
    required this.load,
  });

  @override
  List<Object?> get props => [
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
}
