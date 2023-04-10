import 'dart:ffi';

import 'package:above_the_bar/bloc/athlete_profile/athlete_profile_bloc.dart';
import 'package:above_the_bar/bloc/program/program_bloc.dart';

import 'package:above_the_bar/widgets/athlete_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/athlete_data/athlete_data_bloc.dart';
import '../models/athlete_data_entry_model.dart';
import '../models/programs_model.dart';

class AthleteHome extends StatefulWidget {
  final String userEmail;

  const AthleteHome({super.key, required this.userEmail});

  static const routeName = '/athlete/home';

  @override
  State<AthleteHome> createState() => _AthleteHomeState();
}

class _AthleteHomeState extends State<AthleteHome> {
  final TextEditingController _controller = TextEditingController();
  late DateTime date = DateTime.now();

  List<AthleteInputWidget> listDynamic = [];
  List<AthleteInputWidget> listCreateData = [];
  List<String> data = [];

  final List<AthleteInputWidget> _exerciseWidgets = [];

  void _addExerciseWidget() {
    setState(() {
      _exerciseWidgets.add(
        AthleteInputWidget(
            exerciseNum: _exerciseWidgets.length + 1,
            exerciseName: 'Select Exercise',
            load: 0,
            sets: 0,
            reps: 0),
      );
    });
  }

  void _removeExerciseWidget(int index) {
    setState(() {
      _exerciseWidgets.removeAt(index);
    });
  }

  List<Widget> _loadExercises(
      List<ProgramModel> athleteProgram, int currentWeek, int currentSession) {
    List<Widget> exerciseText = [];
    exerciseText.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Week $currentWeek Session $currentSession',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    ));
    List<ProgramModel> filteredList = athleteProgram
        .where((program) =>
            program.week == currentWeek && program.session == currentSession)
        .toList();

    for (int i = 0; i < filteredList.length; i++) {
      exerciseText.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Container(
              width: 150,
              child: Text(
                filteredList[i].exercise,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            Container(
              width: 50,
              child: Text(
                '${filteredList[i].sets.toString()} sets',
              ),
            ),
            Container(
                width: 50,
                child: Text('${filteredList[i].sets.toString()} reps')),
            Container(width: 50, child: Text('${filteredList[i].intensity} %')),
            Container(
                width: 100, child: Text(filteredList[i].comments.toString())),
            SizedBox(height: 30),
          ],
        ),
      );
    }
    return exerciseText;
  }

  @override
  Widget build(BuildContext context) {
    String text = DateFormat('yyyy-MM-dd').format(date);
    context
        .read<AthleteProfileBloc>()
        .add(LoadAthleteProfile(widget.userEmail));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Athlete Programming App"),
      ),
      body: Column(
        children: [
          Row(
            // Button
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  alignment: Alignment.topCenter,
                  child: IconButton(
                    icon: Icon(Icons.person),
                    onPressed: () {
                      Navigator.pushNamed(context, '/athlete/profile',
                          arguments: widget.userEmail);
                    },
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  alignment: Alignment.topCenter,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/athlete/history',
                          arguments: widget.userEmail);
                    },
                    icon: Icon(Icons.history),
                    label: Text(
                      "History",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          BlocBuilder<AthleteProfileBloc, AthleteProfileState>(
            builder: (context, athleteState) {
              if (athleteState is AthleteProfileLoaded) {
                BlocProvider.of<ProgramBloc>(context).add(LoadProgram(
                    athleteState.athleteProfile.programId,
                    athleteState.athleteProfile.coachEmail));

                Future.microtask(() {
                  _controller.text =
                      athleteState.athleteProfile.weightClass.toString();
                });

                return BlocBuilder<ProgramBloc, ProgramState>(
                    builder: (context, programState) {
                  if (programState is ProgramLoaded) {
                    return Column(
                      children: [
                        Column(
                            children: _loadExercises(
                          programState.program,
                          athleteState.athleteProfile.week,
                          athleteState.athleteProfile.session,
                        )),
                        SizedBox(height: 10),
                        //button for next session and previous session (if there is one)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    if (athleteState.athleteProfile.session ==
                                            1 &&
                                        athleteState.athleteProfile.week == 1) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'You are on the first session'),
                                          duration: Duration(milliseconds: 95),
                                        ),
                                      );
                                    } else {
                                      if (athleteState.athleteProfile.session ==
                                          1) {
                                        context.read<AthleteProfileBloc>().add(
                                              UpdateCreateAthleteProfile(
                                                  athleteState
                                                      .athleteProfile.email,
                                                  athleteState
                                                      .athleteProfile.programId,
                                                  athleteState
                                                      .athleteProfile.startDate,
                                                  athleteState
                                                          .athleteProfile.week -
                                                      1,
                                                  programState
                                                      .program[0].maxSession),
                                            );
                                      } else {
                                        context.read<AthleteProfileBloc>().add(
                                              UpdateCreateAthleteProfile(
                                                athleteState
                                                    .athleteProfile.email,
                                                athleteState
                                                    .athleteProfile.programId,
                                                athleteState
                                                    .athleteProfile.startDate,
                                                athleteState
                                                    .athleteProfile.week,
                                                athleteState.athleteProfile
                                                        .session -
                                                    1,
                                              ),
                                            );
                                      }
                                    }
                                    _loadExercises(
                                      programState.program,
                                      athleteState.athleteProfile.week,
                                      athleteState.athleteProfile.session,
                                    );
                                  });
                                },
                                child: Text('Previous Session')),
                            // Previous Session Button
                            SizedBox(width: 50),
                            OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    if (programState.program.length <
                                        programState.program[0].maxWeek *
                                            programState
                                                .program[0].maxSession) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content:
                                            Text('You are on the last session'),
                                        duration: Duration(milliseconds: 50),
                                      ));
                                    } else {
                                      // need to check if it is t
                                      if (athleteState.athleteProfile.session <
                                          programState.program[0].maxSession) {
                                        context.read<AthleteProfileBloc>().add(
                                            UpdateCreateAthleteProfile(
                                                athleteState
                                                    .athleteProfile.email,
                                                athleteState
                                                    .athleteProfile.programId,
                                                athleteState
                                                    .athleteProfile.startDate,
                                                athleteState
                                                    .athleteProfile.week,
                                                athleteState.athleteProfile
                                                        .session +
                                                    1));
                                      } else if (athleteState
                                              .athleteProfile.week <
                                          programState.program[0].maxWeek) {
                                        context.read<AthleteProfileBloc>().add(
                                            UpdateCreateAthleteProfile(
                                                athleteState
                                                    .athleteProfile.email,
                                                athleteState
                                                    .athleteProfile.programId,
                                                athleteState
                                                    .athleteProfile.startDate,
                                                athleteState
                                                        .athleteProfile.week +
                                                    1,
                                                1));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              'You are on the last session'),
                                        ));
                                      }
                                      _loadExercises(
                                        programState.program,
                                        athleteState.athleteProfile.week,
                                        athleteState.athleteProfile.session,
                                      );
                                    }
                                  });
                                },
                                child: Text('Next Session')),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          alignment: Alignment.topCenter,
                          child: TextButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/athlete/program-viewer',
                                  arguments: programState.program);
                            },
                            icon: Icon(Icons.view_list, color: Colors.white),
                            label: Text(
                              "View Program",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  return Container();
                });
              }
              return Text(
                'The Program has not been loaded',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              );
            },
          ),
          SizedBox(height: 10.0),
          // Add some space between the button and the text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Date:'),
              Container(
                width: 180,
                margin: EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () async {
                    date = (await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2024)))!;
                    setState(() {
                      text = DateFormat('yyyy-MM-dd').format(date);
                    });
                  },
                  child: Text(text),
                ),
              ),
              Container(
                width: 80,
                margin: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'BW KG',
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^[0-9]+.?[0-9]*')),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: _exerciseWidgets.length,
                  itemBuilder: (context, index) {
                    return Row(
                      // delete exercise
                      children: [
                        Expanded(child: _exerciseWidgets[index]),
                        IconButton(
                          onPressed: () => _removeExerciseWidget(index),
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    );
                  },
                ),
              ), // List of exercises
              FloatingActionButton(
                onPressed: _addExerciseWidget,
                child: Icon(Icons.add),
              ), //add exercise
            ],
          ),
          SizedBox(height: 7.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<AthleteDataBloc, AthleteDataState>(
                builder: (context, state) {
                  if (state is AthleteDataLoading ||
                      state is AthleteDataLoaded) {
                    return OutlinedButton(
                        onPressed: () {
                          for (int i = 0; i < _exerciseWidgets.length; i++) {
                            context.read<AthleteDataBloc>().add(
                                  CreateAthleteData(
                                    AthleteDataEntryModel(
                                      email: widget.userEmail,
                                      date: DateTime.parse(text),
                                      bw: double.parse(_controller.text),
                                      exercise: _exerciseWidgets[i]
                                          .controllerGetExText,
                                      sets: int.parse(_exerciseWidgets[i]
                                          .controllerGetSetsText),
                                      reps: int.parse(_exerciseWidgets[i]
                                          .controllerGetRepsText),
                                      load: int.parse(_exerciseWidgets[i]
                                          .controllerGetLoadText),
                                    ),
                                  ),
                                );
                          }
                          _refreshScreen(context, widget.userEmail);
                        },
                        child: Text("Submit Data"));
                  }
                  return Text(
                    'Athlete Data has not been loaded',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  );
                },
              ),
            ],
          ), // Submit Button
        ],
      ),
    );
  }
}

// Define a function to refresh the screen
void _refreshScreen(BuildContext context, String athleteEmailString) {
  // reset bloc to loading state
  context.read<AthleteDataBloc>().add(LoadAthleteData(athleteEmailString));

  // Clear any text fields

  // Push a new instance of the same screen onto the navigation stack
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => AthleteHome(
        userEmail: athleteEmailString,
      ),
    ),
  );
}
