import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateExerciseWidget extends StatelessWidget {
  CreateExerciseWidget(
      {required this.week, required this.session, required this.exerciseNum});

  final int week;
  final int session;
  final int exerciseNum;

  final TextEditingController _controllerEx = TextEditingController();
  String get controllerGetExText => _controllerEx.text;
  TextEditingController controllerSets = TextEditingController();
  String get controllerGetSetsText => controllerSets.text;
  TextEditingController controllerReps = TextEditingController();
  String get controllerGetRepsText => controllerReps.text;
  TextEditingController controllerInt = TextEditingController();
  String get controllerGetIntText => controllerInt.text;
  TextEditingController controllerComments = TextEditingController();
  String get controllerGetCommentsText => controllerComments.text;

  void dispose() {
    _controllerEx.dispose();
    controllerSets.dispose();
    controllerReps.dispose();
    controllerInt.dispose();
    controllerComments.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          margin: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _controllerEx,
            decoration: InputDecoration(hintText: 'Exercise' '$exerciseNum'),
          ),
        ),
        Container(
          width: 100,
          margin: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: controllerSets,
            decoration: InputDecoration(hintText: 'Sets'),
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
            decoration: InputDecoration(hintText: 'Reps'),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
          ),
        ),
        Container(
          width: 100,
          margin: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: controllerInt,
            decoration: InputDecoration(hintText: 'Intensity'),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
          ),
        ),
        Container(
          width: 100,
          margin: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: controllerComments,
            decoration: InputDecoration(hintText: 'Comments'),
          ),
        ),
      ],
    );
  }
}
