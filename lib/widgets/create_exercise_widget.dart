import 'package:above_the_bar/bloc/blocs.dart';
import 'package:above_the_bar/models/exercise_model.dart';
import 'package:above_the_bar/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateExerciseWidget extends StatefulWidget {
  final int week;
  final int session;
  final int exerciseNum;

  CreateExerciseWidget(
      {required this.week, required this.session, required this.exerciseNum});

  @override
  _CreateExerciseWidgetState createState() => _CreateExerciseWidgetState();

  String getExerciseName() {
    return _CreateExerciseWidgetState().controllerGetExText;
  }

  String getSets() {
    return _CreateExerciseWidgetState().controllerGetSetsText;
  }

  String getReps() {
    return _CreateExerciseWidgetState().controllerGetRepsText;
  }

  String getInt() {
    return _CreateExerciseWidgetState().controllerGetIntText;
  }

  String getComments() {
    return _CreateExerciseWidgetState().controllerGetCommentsText;
  }

  void dispose() {
    _CreateExerciseWidgetState().dispose();
  }
}

class _CreateExerciseWidgetState extends State<CreateExerciseWidget> {
  final TextEditingController _controllerEx = TextEditingController();
  TextEditingController controllerSets = TextEditingController();
  TextEditingController controllerReps = TextEditingController();
  TextEditingController controllerInt = TextEditingController();
  TextEditingController controllerComments = TextEditingController();

  String get controllerGetExText => _controllerEx.text;

  String get controllerGetSetsText => controllerSets.text;

  String get controllerGetRepsText => controllerReps.text;

  String get controllerGetIntText => controllerInt.text;

  String get controllerGetCommentsText => controllerComments.text;

  void dispose() {
    _controllerEx.dispose();
    controllerSets.dispose();
    controllerReps.dispose();
    controllerInt.dispose();
    controllerComments.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<ExerciseBloc, ExerciseState>(
          //TODO this shoudl adpat for uassign and assign
          builder: (context, state) {
            if (state is ExerciseLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ExerciseLoaded) {
              //getting a name of list of exercieses and then converting them
              final List<Exercise> exerciseList = state.exercises;
              // convert exercise.name into a list of strings
              final List<String> exerciseNameList = exerciseList
                  .map((exercise) => exercise.name)
                  .toList(growable: false);
              final dropdownBloc = DropdownBloc<String>(exerciseNameList);
              late String selectedItem = dropdownBloc.items[0];
              return StreamBuilder<String>(
                stream: dropdownBloc.selectedItemStream,
                initialData: selectedItem,
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                    child: DropdownButton<String>(
                      value: snapshot.data,
                      onChanged: (item) {
                        setState(() {
                          selectedItem = item!;
                          _controllerEx.text = item;
                        });
                        dropdownBloc.setSelectedItem(item!);
                      },
                      items: dropdownBloc.items
                          .map<DropdownMenuItem<String>>((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('No Programs'),
              );
            }
          },
        ),
        // Container(
        //   width: 150,
        //   margin: EdgeInsets.all(8.0),
        //   child: TextFormField(
        //     controller: _controllerEx,
        //     decoration: InputDecoration(hintText: 'Exercise' '$exerciseNum'),
        //   ),
        // ),
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
