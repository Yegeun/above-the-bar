import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../bloc/cupertino_picker/dropdown_bloc.dart';

class AthleteInputWidget extends StatefulWidget {
  final List<String> inputExercises;
  final int exerciseNum;
  String exerciseName;
  int load;
  int sets;
  int reps;

  AthleteInputWidget({
    super.key,
    required this.inputExercises,
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
    final controllerSets = TextEditingController(text: widget.sets.toString());
    final controllerReps = TextEditingController(text: widget.reps.toString());
    final controllerLoad = TextEditingController(text: widget.load.toString());

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 5,
          child: DropdownButton<String>(
            value: widget.exerciseName,
            onChanged: (item) {
              setState(() {
                widget.exerciseName = item!;
              });
              DropdownBloc<String>(widget.inputExercises)
                  .setSelectedItem(widget.exerciseName);
            },
            items: DropdownBloc<String>(widget.inputExercises)
                .items
                .map<DropdownMenuItem<String>>((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: TextFormField(
              controller: controllerLoad,
              keyboardType: TextInputType.number,
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
              validator: (value) {
                if (value!.isEmpty) {
                  throw Exception('Please enter a value');
                }
                return null;
              },
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: TextFormField(
              controller: controllerSets,
              keyboardType: TextInputType.number,
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
              validator: (value) {
                if (value!.isEmpty) {
                  throw Exception('Please enter a value');
                }
                return null;
              },
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.all(1.0),
            child: TextFormField(
              controller: controllerReps,
              keyboardType: TextInputType.number,
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
              validator: (value) {
                if (value!.isEmpty) {
                  throw Exception('Please enter a value');
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }
}
