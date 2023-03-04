import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AthleteInputWidget extends StatelessWidget {
  final int exerciseNum;

  AthleteInputWidget({required this.exerciseNum});

  void dispose() {
    _controllerEx.dispose();
    controllerSets.dispose();
    controllerReps.dispose();
    controllerLoad.dispose();
  }

  final TextEditingController _controllerEx = TextEditingController();

  String get controllerGetExText => _controllerEx.text;
  TextEditingController controllerSets = TextEditingController();

  String get controllerGetSetsText => controllerSets.text;
  TextEditingController controllerReps = TextEditingController();

  String get controllerGetRepsText => controllerReps.text;
  TextEditingController controllerLoad = TextEditingController();

  String get controllerGetIntText => controllerLoad.text;

  @override
  Widget build(BuildContext context) {
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
            controller: controllerSets,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Load (KG)'),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
          ),
        ),
        Container(
          width: 100,
          margin: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: controllerReps,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Sets'),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
          ),
        ),
        Container(
          width: 100,
          margin: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: controllerLoad,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Reps'),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
          ),
        ),
      ],
    );
  }
}
