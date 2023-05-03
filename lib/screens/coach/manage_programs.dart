import 'package:above_the_bar/bloc/blocs.dart';
import 'package:above_the_bar/utilities/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/exercise_model.dart';

String _name = 'Program Name';

class ManagePrograms extends StatefulWidget {
  final List<String> manageProgramsList;

  const ManagePrograms({
    Key? key,
    required this.manageProgramsList,
  }) : super(key: key);

  @override
  State<ManagePrograms> createState() => _ManageProgramsState();
}

class _ManageProgramsState extends State<ManagePrograms> {
  void showSnack(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    Future.delayed(Duration(seconds: 2), () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    });
  }

  Future<void> _displayCopyDialog(BuildContext context, String name) async {
    final TextEditingController controllerName =
        TextEditingController(text: '$name 1');
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Copy Program'),
            content: TextField(
              onChanged: (value) {},
              controller: controllerName,
              decoration: InputDecoration(hintText: "Name"), // preload
            ),
            actions: <Widget>[
              TextButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('COPY'),
                onPressed: () {
                  _copyProgram(name, controllerName.text);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _displayCreateDialog(BuildContext context, List<String> list,
      List<String> exerciseList) async {
    final TextEditingController controllerProgramName =
        TextEditingController(text: 'Program Name');
    final TextEditingController controllerWeeks = TextEditingController();
    final TextEditingController controllerSession = TextEditingController();
    final TextEditingController controllerExercises = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create Program',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  onChanged: (value) {},
                  controller: controllerProgramName,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  onChanged: (value) {},
                  controller: controllerWeeks,
                  decoration: InputDecoration(
                    hintText: 'Number of Weeks',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^(?:1?\d|20|0)$'),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  onChanged: (value) {},
                  controller: controllerSession,
                  decoration: InputDecoration(
                    hintText: 'Number of Session',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^(?:1?\d|20|0)$'),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  onChanged: (value) {},
                  controller: controllerExercises,
                  decoration: InputDecoration(
                    hintText: 'Number of Exercises',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^(?:1?\d|20|0)$'),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text(
                        'CANCEL',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(width: 10.0),
                    ElevatedButton(
                      child: Text('CREATE'),
                      onPressed: () {
                        if (list.contains(
                            controllerProgramName.text.toLowerCase())) {
                          showSnack('Program already exists');
                          return;
                        } else {
                          List<String> _programList = [
                            controllerProgramName.text,
                            controllerWeeks.text,
                            controllerSession.text,
                            controllerExercises.text,
                          ];
                          _programList.add(widget.manageProgramsList[0]);
                          _programList.addAll(exerciseList);
                          Navigator.of(context).pop();
                          navigateToCreateProgram(_programList);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteProgram(String nameProg, List<String> listModel) async {
    // Delete the program from the database
    if (listModel.contains(nameProg)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cannot delete a program that is in use'),
        ),
      );
      return;
    } else {
      BlocProvider.of<ProgramListBloc>(context)
          .add(DeleteProgram(nameProg, widget.manageProgramsList[0]));
    }
  }

  Future<void> _copyProgram(String nameProg, String newNameProg) async {
    // Copy the program from the database
    BlocProvider.of<ProgramListBloc>(context)
        .add(CopyProgram(nameProg, newNameProg, widget.manageProgramsList[0]));
  }

  navigateToCreateProgram(List<String> diaCreateProgram) {
    Navigator.pushNamed(
      context,
      '/coach/create-program',
      arguments: diaCreateProgram,
    );
  }

  List<String> globalProgramList = [];
  List<Exercise> exerciseTemp = [];

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => context
        .read<ExerciseBloc>()
        .add(LoadExercises(widget.manageProgramsList[0])));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Programs"),
      ),
      body: Column(
        children: [
          BlocBuilder<ExerciseBloc, ExerciseState>(
            builder: (context, state) {
              if (state is ExerciseLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ExerciseLoaded) {
                exerciseTemp = state.exercises.toList();
                return Container();
              } else {
                return Text(
                  'Something went wrong ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                );
              }
            },
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.blue),
                    color: Colors.white,
                  ),
                  child: TextButton(
                    onPressed: () {
                      List<String> _exerciseList = [];
                      _exerciseList.clear();
                      _exerciseList.addAll(kExercises);
                      for (int i = 0; i < exerciseTemp.length; i++) {
                        _exerciseList.add(exerciseTemp[i].name);
                      }
                      _exerciseList.add('Empty');
                      _displayCreateDialog(
                          context, globalProgramList, _exerciseList);
                    },
                    child: Text(
                      'Create Program',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.orange),
                    color: Colors.white,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/coach/create-exercise',
                          arguments: widget.manageProgramsList[0]);
                    },
                    child: Text(
                      'Create Exercise',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              BlocBuilder<ProgramListBloc, ProgramListState>(
                builder: (context, state) {
                  context
                      .read<ProgramListBloc>()
                      .add(LoadProgramList(widget.manageProgramsList[0]));
                  if (state is ProgramListLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ProgramListLoaded) {
                    final List<String> programsList =
                        state.programList.toList();
                    globalProgramList = state.programList.toList();
                    return Flexible(
                      child: SizedBox(
                        height: 300,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: programsList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    'Name: ',
                                  ),
                                  Text(
                                    programsList[index],
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      List<String> _exerciseList = [];
                                      _exerciseList.clear();
                                      _exerciseList.addAll(kExercises);
                                      for (int i = 0;
                                          i < exerciseTemp.length;
                                          i++) {
                                        _exerciseList.add(exerciseTemp[i].name);
                                      }
                                      _exerciseList.add('Empty');
                                      List<String> programEditList = [
                                        programsList[index],
                                        widget.manageProgramsList[0],
                                      ];
                                      programEditList.addAll(_exerciseList);
                                      Navigator.pushNamed(
                                          context, '/coach/edit',
                                          arguments: programEditList);
                                    },
                                    icon: Icon(Icons.edit),
                                    tooltip: 'Edit Program',
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _name = programsList[index];
                                      if (kDebugMode) {
                                        print('Copy $_name');
                                      }
                                      _displayCopyDialog(context, _name);
                                    },
                                    icon: Icon(Icons.copy),
                                    tooltip: 'Copy Program',
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _deleteProgram(programsList[index],
                                          widget.manageProgramsList);
                                    },
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    tooltip: 'Delete Program',
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text('No Programs Found'),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
