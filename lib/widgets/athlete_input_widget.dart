import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AthleteInputWidget extends StatefulWidget {
  final int exerciseNum;
  String exerciseName;
  int load;
  int sets;
  int reps;

  AthleteInputWidget({
    required this.exerciseNum,
    required this.exerciseName,
    required this.load,
    required this.sets,
    required this.reps,
  });

  @override
  _AthleteInputWidgetState createState() => _AthleteInputWidgetState();
}

class _AthleteInputWidgetState extends State<AthleteInputWidget> {
  @override
  Widget build(BuildContext context) {
    final controllerEx = TextEditingController(text: widget.exerciseName);
    final controllerSets = TextEditingController(text: widget.sets.toString());
    final controllerReps = TextEditingController(text: widget.reps.toString());
    final controllerLoad = TextEditingController(text: widget.load.toString());

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: TextFormField(
              controller: controllerEx,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Exercise ${widget.exerciseNum}',
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: TextFormField(
              controller: controllerLoad,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'W(KG)',
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                  RegExp(r'^(?:[1-4]?\d{1,2}|500|[0-9])$'),
                ),
              ],
              onChanged: (value) {
                // update the load
                widget.load = int.parse(value);
              },
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: TextFormField(
              controller: controllerSets,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Sets',
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                  RegExp(r'^(?:1?[0-9]|20|[0-9])$'),
                ),
              ],
              onChanged: (value) {
                // update the sets
                widget.sets = int.parse(value);
              },
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.all(1.0),
            child: TextFormField(
              controller: controllerReps,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Reps',
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                  RegExp(r'^(?:1?[0-9]|20|[0-9])$'),
                ),
              ],
              onChanged: (value) {
                // update the reps
                widget.reps = int.parse(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}
