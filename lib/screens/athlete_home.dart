import 'package:above_the_bar/bloc/athlete_profile/athlete_profile_bloc.dart';
import 'package:above_the_bar/bloc/program/program_bloc.dart';

import 'package:above_the_bar/widgets/athlete_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/athlete_data/athlete_data_bloc.dart';

class AthleteHome extends StatefulWidget {
  final String userEmail;

  const AthleteHome({super.key, required this.userEmail});

  static const routeName = '/athlete/home';

  @override
  State<AthleteHome> createState() => _AthleteHomeState();
}

class _AthleteHomeState extends State<AthleteHome> {
  late DateTime date = DateTime.now();
  TextEditingController _controller = TextEditingController();

  List<AthleteInputWidget> listDynamic = [];
  List<AthleteInputWidget> listCreateData = [];
  List<String> data = [];

  final List<AthleteInputWidget> _exerciseWidgets = [];

  void _addExerciseWidget() {
    setState(() {
      _exerciseWidgets
          .add(AthleteInputWidget(exerciseNum: _exerciseWidgets.length + 1));
    });
  }

  void _removeExerciseWidget(int index) {
    setState(() {
      _exerciseWidgets.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    String text = DateFormat('yyyy-MM-dd').format(date);
    _controller.text = '61';

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
              context
                  .read<AthleteProfileBloc>()
                  .add(LoadAthleteProfile(widget.userEmail));
              if (athleteState is AthleteProfileLoaded) {
                return BlocBuilder<ProgramBloc, ProgramState>(
                    builder: (context, programState) {
                  context.read<ProgramBloc>().add(LoadProgram(
                      athleteState.athleteProfile.programId,
                      athleteState.athleteProfile.coachEmail));
                  if (programState is ProgramLoaded) {
                    return Column(
                      children: [
                        Text(
                          'Exercise 1 ${programState.program[0].exercise}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
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
                'Something went wrong ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              );
            },
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  alignment: Alignment.topCenter,
                  child: Text("Program"),
                ),
              ),
            ],
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
                width: 90,
                margin: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'BW KG',
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(?:[1-4]?\d{1,2}|200|[0-9])$')),
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
              ),
              FloatingActionButton(
                onPressed: _addExerciseWidget,
                child: Icon(Icons.add),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<AthleteDataBloc, AthleteDataState>(
                builder: (context, state) {
                  if (state is AthleteDataLoading ||
                      state is AthleteDataLoaded) {
                    return OutlinedButton(
                        onPressed: () {
                          print(_exerciseWidgets.length);
                          print(_exerciseWidgets[0].controllerGetExText);
                          print(_exerciseWidgets[0].controllerGetSetsText);
                          print(_exerciseWidgets[0].controllerGetRepsText);
                          print(_exerciseWidgets[0].controllerGetLoadText);
                          // Input validation for the Exercises
                          // for (int i = 0; i < listCreateData.length; i++) {
                          //   context.read<AthleteDataBloc>().add(
                          //         CreateAthleteData(
                          //           AthleteDataEntryModel(
                          //             email: widget.userEmail,
                          //             date: DateTime.parse(text),
                          //             bw: int.parse(_controller.text),
                          //             exercise:
                          //                 listCreateData[i].controllerGetExText,
                          //             sets: int.parse(listCreateData[i]
                          //                 .controllerGetSetsText),
                          //             reps: int.parse(listCreateData[i]
                          //                 .controllerGetRepsText),
                          //             load: int.parse(listCreateData[i]
                          //                 .controllerGetLoadText),
                          //           ),
                          //         ),
                          //       );
                          // }
                          _refreshScreen(context, widget.userEmail);
                        },
                        child: Text("Submit Data"));
                  }
                  return Text(
                    'Something went wrong ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  );
                },
              ),
            ],
          ),
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
