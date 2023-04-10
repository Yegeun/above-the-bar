import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AthleteInputWidget extends StatelessWidget {
  final int exerciseNum;
  final String exerciseName;
  final int load;
  final int sets;
  final int reps;

  AthleteInputWidget(
      {required this.exerciseNum,
      required this.exerciseName,
      required this.load,
      required this.sets,
      required this.reps});

  void clear() {
    _controllerEx.clear();
    _controllerSets.clear();
    _controllerReps.clear();
    _controllerLoad.clear();
  }

  final TextEditingController _controllerEx = TextEditingController();
  final TextEditingController _controllerSets = TextEditingController();
  final TextEditingController _controllerReps = TextEditingController();
  final TextEditingController _controllerLoad = TextEditingController();

  String get controllerGetExText => _controllerEx.text;

  String get controllerGetSetsText => _controllerSets.text;

  String get controllerGetRepsText => _controllerReps.text;

  String get controllerGetLoadText => _controllerLoad.text;

  @override
  Widget build(BuildContext context) {
    _controllerEx.text = exerciseName;
    _controllerSets.text = sets.toString();
    _controllerReps.text = reps.toString();
    _controllerLoad.text = load.toString();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          margin: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _controllerEx,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Exercise' '${exerciseNum}'),
          ),
        ),
        Container(
          width: 100,
          margin: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _controllerLoad,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Load (KG)'),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                  RegExp(r'^(?:[1-4]?\d{1,2}|500|[0-9])$')),
            ],
          ),
        ),
        Container(
          width: 100,
          margin: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _controllerSets,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Sets'),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                  RegExp(r'^(?:1?[0-9]|20|[0-9])$')),
            ],
          ),
        ),
        Container(
          width: 100,
          margin: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _controllerReps,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Reps'),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                  RegExp(r'^(?:1?[0-9]|20|[0-9])$')),
            ],
          ),
        ),
      ],
    );
  }
}
