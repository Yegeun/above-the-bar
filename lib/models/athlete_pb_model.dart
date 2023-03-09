import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AthletePersonalBestModel extends Equatable {
  final String email;
  final int bw;
  final String exercise;
  final DateTime date;
  final int load;
  final int reps;

  const AthletePersonalBestModel({
    required this.email,
    required this.date,
    required this.bw,
    required this.exercise,
    required this.load,
    required this.reps,
  });

  @override
  List<Object?> get props => [
        email, //TODO Probably take this out
        date,
        bw,
        exercise,
        load,
        reps,
      ];

  static AthletePersonalBestModel fromSnapshot(DocumentSnapshot snap) {
    AthletePersonalBestModel personalBestEntry = AthletePersonalBestModel(
      email: snap['email'],
      date: snap['date'].toDate(),
      bw: snap['bw'],
      exercise: snap['exercise'],
      load: snap['load'],
      reps: snap['reps'],
    );
    return personalBestEntry;
  }

  //To write in the firebase
  Map<String, Object> toDocument() {
    if (date.toString().isEmpty || bw.toString().isEmpty) {
      return {
        'email': email, //TODO Probably take this out
        'date': DateTime.now(),
        'bw': 73,
        'exercise': exercise,
        'load': load,
        'reps': reps,
      };
    }
    return {
      'email': email, //TODO Probably take this out
      'date': date,
      'bw': bw,
      'exercise': exercise,
      'load': load,
      'reps': reps,
    };
  }
}