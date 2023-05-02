import 'package:above_the_bar/bloc/blocs.dart';
import 'package:above_the_bar/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:above_the_bar/models/programs_model.dart';

List<ProgramModel> _programModelList = [];

class EditProgram extends StatefulWidget {
  // 0 = program name 1 = coach email
  final List<String> editProgramProgramName;

  const EditProgram({super.key, required this.editProgramProgramName});

  @override
  State<EditProgram> createState() => _EditProgramState();
}

class _EditProgramState extends State<EditProgram> {
  @override
  Widget build(BuildContext context) {
    context.read<ProgramBloc>().add(
          LoadProgram(widget.editProgramProgramName[1],
              widget.editProgramProgramName[0]),
        );

    context.read<ProgramDetailsBloc>().add(LoadProgramDetails(
        widget.editProgramProgramName[1], widget.editProgramProgramName[0]));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Program"),
      ),
      body: BlocBuilder<ProgramDetailsBloc, ProgramDetailsState>(
          builder: (context, state) {
        if (state is ProgramDetailsLoaded) {
          WeekTextInputListEdit weekTextInputListEdit = WeekTextInputListEdit(
              inputProgramName: state.programDetails.programName,
              weekCoachEmail: widget.editProgramProgramName[1],
              numWeeks: state.programDetails.weeks,
              sessionsPerWeek: state.programDetails.sessions,
              exercisesPerSession: state.programDetails.exercises);
          return weekTextInputListEdit;
        }
        return Container();
      }),
    );
  }
}

class WeekTextInputListEdit extends StatefulWidget {
  final int numWeeks;
  final int sessionsPerWeek;
  final int exercisesPerSession;
  final String inputProgramName;
  final String weekCoachEmail;

  WeekTextInputListEdit({
    required this.numWeeks,
    required this.sessionsPerWeek,
    required this.exercisesPerSession,
    required this.inputProgramName,
    required this.weekCoachEmail,
  });

  @override
  _WeekTextInputListEditState createState() => _WeekTextInputListEditState();
}

class _WeekTextInputListEditState extends State<WeekTextInputListEdit> {
  List<List<List<List<TextEditingController>>>> _controllers = [];
  List<List<List<List<String>>>> dropdownValueState = [];

  Future<void> _loadProgram() async {
    context.read<ProgramBloc>().add(
          LoadProgram(widget.inputProgramName, widget.weekCoachEmail),
        );
  }

  @override
  Widget build(BuildContext context) {
    Future<void> displayCopyDialog(BuildContext context) async {
      final TextEditingController controllerWeek = TextEditingController();
      final TextEditingController controllerCopyWeek = TextEditingController();
      final TextEditingController controllerSetsPM = TextEditingController();
      final TextEditingController controllerSets = TextEditingController();
      final TextEditingController controllerRepsPM = TextEditingController();
      final TextEditingController controllerReps = TextEditingController();
      final TextEditingController controllerIntensityPM =
          TextEditingController();
      final TextEditingController controllerIntensity = TextEditingController();
      void updateControllerText(
          String pm,
          TextEditingController currentController,
          TextEditingController setsController,
          TextEditingController copyController) {
        if (pm == '+') {
          copyController.text = (int.parse(currentController.text) +
                  int.parse(setsController.text))
              .toString();
        } else if (pm == '-') {
          final int current = int.parse(currentController.text);
          final int sets = int.parse(setsController.text);
          final int result = current - sets;
          copyController.text = (result < 0) ? '0' : result.toString();
        } else {
          copyController.text = currentController.text;
        }
      }

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
                children: [
                  Text(
                    'COPY Week',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField<int>(
                    value: controllerWeek.text.isEmpty
                        ? null
                        : int.parse(controllerWeek.text),
                    decoration: InputDecoration(
                      hintText: 'Copy',
                      border: OutlineInputBorder(),
                    ),
                    items: List.generate(widget.numWeeks, (index) => index + 1)
                        .map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value'),
                      );
                    }).toList(),
                    onChanged: (int? value) {
                      setState(() {
                        controllerWeek.text = value.toString();
                      });
                    },
                  ),
                  DropdownButtonFormField<int>(
                    value: controllerCopyWeek.text.isEmpty
                        ? null
                        : int.parse(controllerCopyWeek.text),
                    decoration: InputDecoration(
                      hintText: 'Copy To Week',
                      border: OutlineInputBorder(),
                    ),
                    items: List.generate(widget.numWeeks, (index) => index + 1)
                        .map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value'),
                      );
                    }).toList(),
                    onChanged: (int? value) {
                      setState(() {
                        controllerCopyWeek.text = value.toString();
                      });
                    },
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          'Sets',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Container(
                        width: 122.0,
                        padding: EdgeInsets.only(left: 10, right: 20.0),
                        child: DropdownButtonFormField<String>(
                          value: controllerSetsPM.text.isEmpty
                              ? null
                              : controllerSetsPM.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          hint: Text('+ or -'),
                          items: ['+', '-'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              controllerSetsPM.text = value.toString();
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 50,
                        child: TextField(
                          controller: controllerSets,
                          decoration: InputDecoration(
                            hintText: 'S',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          'Reps',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Container(
                        width: 122.0,
                        padding: EdgeInsets.only(left: 10, right: 20.0),
                        child: DropdownButtonFormField<String>(
                          value: controllerRepsPM.text.isEmpty
                              ? null
                              : controllerRepsPM.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          hint: Text('+ or -'),
                          items: ['+', '-'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              controllerRepsPM.text = value.toString();
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 50,
                        child: TextField(
                          controller: controllerReps,
                          decoration: InputDecoration(
                            hintText: 'R',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          'Intensity',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Container(
                        width: 122.0,
                        padding: EdgeInsets.only(left: 10, right: 20.0),
                        child: DropdownButtonFormField<String>(
                          value: controllerIntensityPM.text.isEmpty
                              ? null
                              : controllerIntensityPM.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          hint: Text('+ or -'),
                          items: ['+', '-'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              controllerIntensityPM.text = value.toString();
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 50,
                        child: TextField(
                          controller: controllerIntensity,
                          decoration: InputDecoration(
                            hintText: '%',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ],
                  ),
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
                        child: Text('COPY'),
                        onPressed: () {
                          int copyNum = int.parse(controllerCopyWeek.text) - 1;
                          int num = int.parse(controllerWeek.text) - 1;
                          print('copyNum: $copyNum num: $num');
                          for (int j = 0; j < widget.sessionsPerWeek; j++) {
                            for (int k = 0;
                                k < widget.exercisesPerSession;
                                k++) {
                              setState(() {
                                dropdownValueState[copyNum][j][k][0] =
                                    dropdownValueState[num][j][k][0];
                              });
                              _controllers[copyNum][j][k][0].text =
                                  _controllers[num][j][k][0].text;
                              updateControllerText(
                                  controllerSetsPM.text,
                                  _controllers[num][j][k][1],
                                  controllerSets,
                                  _controllers[copyNum][j][k][1]);
                              updateControllerText(
                                  controllerRepsPM.text,
                                  _controllers[num][j][k][2],
                                  controllerReps,
                                  _controllers[copyNum][j][k][2]);
                              updateControllerText(
                                  controllerIntensityPM.text,
                                  _controllers[num][j][k][3],
                                  controllerIntensity,
                                  _controllers[copyNum][j][k][3]);
                              _controllers[copyNum][j][k][4].text =
                                  _controllers[num][j][k][4].text;
                            }
                          }
                          Navigator.of(context).pop();
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

    List<Widget> weekFields = [];
    for (int i = 0; i < widget.numWeeks; i++) {
      List<List<List<TextEditingController>>> weekSessions = [];
      List<List<List<String>>> dropdownValueWeek = [];
      for (int j = 0; j < widget.sessionsPerWeek; j++) {
        List<List<TextEditingController>> sessionExercises = [];
        List<List<String>> dropdownValueSession = [];
        for (int k = 0; k < widget.exercisesPerSession; k++) {
          List<TextEditingController> exerciseFields = [];
          List<String> dropdownValueExercise = [];
          exerciseFields.add(TextEditingController()); // Exercise
          exerciseFields.add(TextEditingController()); // Sets
          exerciseFields.add(TextEditingController()); // Reps
          exerciseFields.add(TextEditingController()); // Load(KG)
          exerciseFields.add(TextEditingController()); // Comments
          sessionExercises.add(exerciseFields);
          dropdownValueExercise.add('Select Exercise');
          dropdownValueSession.add(dropdownValueExercise);
        }
        weekSessions.add(sessionExercises);
        dropdownValueWeek.add(dropdownValueSession);
      }
      _controllers.add(weekSessions);
      dropdownValueState.add(dropdownValueWeek);
    }
    final TransformationController _transformationController =
        TransformationController();
    Future.microtask(() {
      _loadProgram();
    });
    return BlocBuilder<ProgramBloc, ProgramState>(
      builder: (context, state) {
        if (state is ProgramLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProgramLoaded) {
          List<ProgramModel> vProgram = state.program;
          Future.delayed(Duration(milliseconds: 500), () {
            if (dropdownValueState[0][0][0][0] == 'Select Exercise') {
              setState(() {
                loadProgramDetails(vProgram);
              });
            }
          });
          for (int i = 0; i < widget.numWeeks; i++) {
            List<Widget> sessionFields = [];
            for (int j = 0; j < widget.sessionsPerWeek; j++) {
              List<Widget> exerciseFields = [];
              exerciseFields.add(
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: Text('Week ${i + 1} Session ${j + 1}'),
                    ),
                  ],
                ),
              );
              for (int k = 0; k < widget.exercisesPerSession; k++) {
                exerciseFields.add(
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 15)),
                      Row(
                        children: [
                          SizedBox(width: 5),
                          Text('EX ${k + 1}'),
                          SizedBox(width: 3),
                          DropdownButton<String>(
                            value: dropdownValueState[i][j][k][0],
                            onChanged: (item) {
                              setState(() {
                                dropdownValueState[i][j][k][0] = item!;
                                _controllers[i][j][k][0].text = item;
                              });
                              DropdownBloc<String>(kExercises).setSelectedItem(
                                  _controllers[i][j][k][0].text);
                            },
                            items: DropdownBloc<String>(kExercises)
                                .items
                                .map<DropdownMenuItem<String>>((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 100,
                            child: TextField(
                              controller: _controllers[i][j][k][1],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Sets',
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^(?:1?\d|20|\d)$'))
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 100,
                            child: TextField(
                              controller: _controllers[i][j][k][2],
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Reps'),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^(?:1?\d|20|\d)$'))
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 100,
                            child: TextField(
                              controller: _controllers[i][j][k][3],
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Intensity %'),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^(?:100|[1-9][0-9]?|0)$'))
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 100,
                            child: TextField(
                              controller: _controllers[i][j][k][4],
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Comments'),
                            ),
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ],
                  ),
                );
              }
              sessionFields.add(
                Column(
                  children: exerciseFields,
                ),
              );
            }
            weekFields.add(
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Week ${i + 1}'),
                    ],
                  ),
                  Column(
                    children: sessionFields,
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Name : ${widget.inputProgramName}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  IconButton(
                      tooltip: 'Copy Week x to Week y',
                      onPressed: () {
                        displayCopyDialog(context);
                      },
                      icon: Icon(Icons.copy)),
                  Tooltip(
                    message:
                        'If you don\'t have an exercise, select "Empty" and the exercise will be skipped',
                    child: IconButton(
                      icon: Icon(Icons.help_outline),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InteractiveViewer(
                    minScale: 0.001,
                    maxScale: 0.5,
                    constrained: false,
                    transformationController: _transformationController,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: weekFields,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        _transformationController.value *=
                            Matrix4.diagonal3Values(1.3, 1.3, 1);
                      },
                      heroTag: null,
                      child: Icon(Icons.add),
                    ),
                    SizedBox(width: 16.0),
                    FloatingActionButton(
                      onPressed: () {
                        _transformationController.value *=
                            Matrix4.diagonal3Values(0.7, 0.7, 1);
                      },
                      heroTag: null,
                      child: Icon(Icons.remove),
                    ),
                    SizedBox(width: 16.0),
                    FloatingActionButton(
                      onPressed: () {
                        handleSubmit(widget.inputProgramName);
                        Navigator.pop(context);
                      },
                      heroTag: null,
                      child: Icon(Icons.save),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  void loadProgramDetails(List<ProgramModel> programDetails) {
    int ex = 0; //exercise counter
    for (int i = 0; i < widget.numWeeks; i++) {
      for (int j = 0; j < widget.sessionsPerWeek; j++) {
        for (int k = 0; k < widget.exercisesPerSession; k++) {
          dropdownValueState[i][j][k][0] = programDetails[ex].exercise;
          _controllers[i][j][k][0].text = programDetails[ex].exercise;
          _controllers[i][j][k][1].text = programDetails[ex].sets.toString();
          _controllers[i][j][k][2].text = programDetails[ex].reps.toString();
          _controllers[i][j][k][3].text =
              programDetails[ex].intensity.toString();
          _controllers[i][j][k][4].text = programDetails[ex].comments;
          ex++;
        }
      }
    }
  }

  List<ProgramModel> handleSubmit(String handleSubmitProgramName) {
    _programModelList.clear();
    for (int i = 0; i < widget.numWeeks; i++) {
      for (int j = 0; j < widget.sessionsPerWeek; j++) {
        for (int k = 0; k < widget.exercisesPerSession; k++) {
          String exerciseName = _controllers[i][j][k][0].text;
          String sets = _controllers[i][j][k][1].text;
          String reps = _controllers[i][j][k][2].text;
          String intensity = _controllers[i][j][k][3].text;
          String comments = _controllers[i][j][k][4].text;
          setState(() {
            if (exerciseName != 'Select Exercise' &&
                    (sets != '' || reps != '') ||
                intensity != '') {
              //checker if the text boxes are filled in
            }
            _programModelList.add(ProgramModel(
              programName: handleSubmitProgramName.toLowerCase(),
              week: i + 1,
              session: j + 1,
              exerciseNum: k + 1,
              exercise: exerciseName,
              sets: int.parse(sets),
              reps: int.parse(reps),
              intensity: int.parse(intensity),
              comments: comments,
              maxWeek: widget.numWeeks,
              maxSession: widget.sessionsPerWeek,
              maxExercise: widget.exercisesPerSession,
            ));
          });
        }
      }
    }
    for (int i = 0; i < _programModelList.length; i++) {
      context.read<ProgramBloc>().add(
            CreateProgram(
              _programModelList[i],
              widget.weekCoachEmail,
            ),
          );
    }
    return _programModelList;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (var i = 0; i < _controllers.length; i++) {
      for (var j = 0; j < _controllers[i].length; j++) {
        for (var k = 0; k < _controllers[i][j].length; k++) {
          for (var l = 0; l < _controllers[i][j][k].length; l++) {
            _controllers[i][j][k][l].dispose();
          }
        }
      }
    }
    super.dispose();
  }
}
