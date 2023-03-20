import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:above_the_bar/utilities/constants.dart';

class AthleteInputWidget extends StatelessWidget {
  final int exerciseNum;

  AthleteInputWidget({required this.exerciseNum});

  void clear() {
    _controllerEx.clear();
    controllerSets.clear();
    controllerReps.clear();
    controllerLoad.clear();
  }

  final TextEditingController _controllerEx = TextEditingController();
  TextEditingController controllerSets = TextEditingController();
  TextEditingController controllerReps = TextEditingController();
  TextEditingController controllerLoad = TextEditingController();

  String get controllerGetExText => _controllerEx.text;

  String get controllerGetSetsText => controllerSets.text;

  String get controllerGetRepsText => controllerReps.text;

  String get controllerGetLoadText => controllerLoad.text;

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
          width: 150,
          child: RawAutocomplete(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              } else {
                List<String> matches = <String>[];
                List<String> kExerciseListString = kExerciseList
                    .map((exercise) => exercise.name.toString())
                    .toList();
                matches.addAll(kExerciseListString);

                matches.retainWhere((s) {
                  return s
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
                return matches;
              }
            },
            onSelected: (String selection) {
              print('You just selected $selection');
            },
            fieldViewBuilder: (BuildContext context,
                TextEditingController textEditingController,
                FocusNode focusNode,
                VoidCallback onFieldSubmitted) {
              return TextField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                controller: textEditingController,
                focusNode: focusNode,
                //
                onSubmitted: (String value) {
                  _controllerEx.text = value;
                },
              );
            },
            optionsViewBuilder: (BuildContext context,
                void Function(String) onSelected, Iterable<String> options) {
              return Material(
                child: SizedBox(
                  height: 200,
                  child: SingleChildScrollView(
                    child: Column(
                      children: options.map((opt) {
                        return InkWell(
                            onTap: () {
                              onSelected(opt);
                            },
                            child: Container(
                                padding: EdgeInsets.only(right: 60),
                                child: Card(
                                    child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(10),
                                  child: Text(opt),
                                ))));
                      }).toList(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          width: 100,
          margin: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: controllerLoad,
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
            controller: controllerSets,
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
            controller: controllerReps,
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
