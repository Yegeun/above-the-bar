import 'package:flutter/material.dart';
import 'package:above_the_bar/models/models.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utilities/constants.dart';
import '/bloc/blocs.dart';

List<ProgramModel> _programModelList = [];

class CreateProgramScreen extends StatefulWidget {
  final List<String> createProgramScreenProgramName;

  const CreateProgramScreen({
    Key? key,
    required this.createProgramScreenProgramName,
  }) : super(key: key);

  static const routeName = '/coach/create-program';

  @override
  State<CreateProgramScreen> createState() => _CreateProgramScreenState();
}

class _CreateProgramScreenState extends State<CreateProgramScreen> {
  @override
  Widget build(BuildContext context) {
    WeekTextInputList weekTextInputList = WeekTextInputList(
      inputProgramName: widget.createProgramScreenProgramName[0],
      numWeeks: int.parse(widget.createProgramScreenProgramName[1]),
      sessionsPerWeek: int.parse(widget.createProgramScreenProgramName[2]),
      exercisesPerSession: int.parse(widget.createProgramScreenProgramName[3]),
      weekCoachEmail: widget.createProgramScreenProgramName[4],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Program"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: weekTextInputList,
    );
  }
}

class WeekTextInputList extends StatefulWidget {
  final int numWeeks;
  final int sessionsPerWeek;
  final int exercisesPerSession;
  final String inputProgramName;
  final String weekCoachEmail;

  WeekTextInputList({
    required this.numWeeks,
    required this.sessionsPerWeek,
    required this.exercisesPerSession,
    required this.inputProgramName,
    required this.weekCoachEmail,
  });

  @override
  _WeekTextInputListState createState() => _WeekTextInputListState();
}

class _WeekTextInputListState extends State<WeekTextInputList> {
  List<List<List<List<TextEditingController>>>> _controllers = [];
  List<List<List<List<String>>>> dropdownValueState = [];

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
    final TransformationController transformationController =
        TransformationController();

    for (int i = 0; i < widget.numWeeks; i++) {
      List<Widget> sessionFields = [];
      for (int j = 0; j < widget.sessionsPerWeek; j++) {
        List<Widget> exerciseFields = [];
        exerciseFields.add(
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 1.0),
                child: Text('Week ${i + 1} Session ${j + 1}'),
              ),
            ],
          ),
        );
        for (int k = 0; k < widget.exercisesPerSession; k++) {
          exerciseFields.add(
            Column(
              children: [
                Padding(padding: const EdgeInsets.only(top: 7.5, bottom: 7.5)),
                Row(
                  children: [
                    SizedBox(width: 5),
                    //Where the data is being written
                    Text('EX ${k + 1}'),
                    SizedBox(width: 3),
                    DropdownButton<String>(
                      value: dropdownValueState[i][j][k][0],
                      onChanged: (item) {
                        setState(() {
                          dropdownValueState[i][j][k][0] = item!;
                          _controllers[i][j][k][0].text = item;
                        });
                        DropdownBloc<String>(kExercises)
                            .setSelectedItem(dropdownValueState[i][j][k][0]);
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
                            border: OutlineInputBorder(), labelText: 'Reps'),
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
                Text('Week ${i + 1}', style: TextStyle(fontSize: 19)),
                SizedBox(height: 10),
                // Row(
                //   children: [
                //     if (i == 0) SizedBox(height: 35),
                //     if (i > 0)
                //       IconButton(
                //         icon: Icon(Icons.content_copy),
                //         onPressed: () {
                //           _copyWeek(i);
                //         },
                //       ),
                //   ],
                // ),
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
              transformationController: transformationController,
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
                  transformationController.value *=
                      Matrix4.diagonal3Values(1.3, 1.3, 1);
                },
                heroTag: null,
                backgroundColor: Color(0xFF008080),
                child: Icon(Icons.zoom_in),
              ),
              SizedBox(width: 16.0),
              FloatingActionButton(
                onPressed: () {
                  transformationController.value *=
                      Matrix4.diagonal3Values(0.7, 0.7, 1);
                },
                heroTag: null,
                backgroundColor: Color(0xFF008080),
                child: Icon(Icons.zoom_out),
              ),
              SizedBox(width: 16.0),
              FloatingActionButton(
                onPressed: () {
                  handleSubmit(widget.inputProgramName, widget.numWeeks,
                      widget.sessionsPerWeek, widget.exercisesPerSession);
                  Navigator.pop(context);
                },
                heroTag: null,
                backgroundColor: Color(0xFF4285F4),
                child: Icon(Icons.save, color: Colors.white),
              )
            ],
          ),
        ),
      ],
    );
  }

  List<ProgramModel> handleSubmit(String handleSubmitProgramName, int maxWeeks,
      int maxSessions, int maxExercises) {
    _programModelList.clear();
    for (int i = 0; i < _controllers.length; i++) {
      for (int j = 0; j < _controllers[i].length; j++) {
        for (int k = 0; k < _controllers[i][j].length; k++) {
          String exerciseName = _controllers[i][j][k][0].text;
          String sets = _controllers[i][j][k][1].text;
          String reps = _controllers[i][j][k][2].text;
          String intensity = _controllers[i][j][k][3].text;
          String comments = _controllers[i][j][k][4].text;
          setState(() {
            if (exerciseName == 'Empty' && (sets != '' || reps != '') ||
                intensity != '') {}
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
              maxWeek: maxWeeks,
              maxSession: maxSessions,
              maxExercise: maxExercises,
            ));
          });
        }
      }
    }
    print('ProgramModelList: $_programModelList');
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
