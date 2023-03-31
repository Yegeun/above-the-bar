import 'package:flutter/material.dart';
import 'package:above_the_bar/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/blocs.dart';
import 'package:above_the_bar/widgets/create_exercise_widget.dart';

List<ProgramModel> _programModelList = [];

class CreateProgramScreen extends StatefulWidget {
  @override
  State<CreateProgramScreen> createState() => _CreateProgramScreenState();
}

class _CreateProgramScreenState extends State<CreateProgramScreen> {
  List<CreateExerciseWidget> listDynamic = [];
  List<CreateExerciseWidget> listCreateExercise = [];
  List<String> data = [];
  String programName = 'gpp1';

  TextEditingController controllerProgName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Widget> weekTitles = [];
    List<ProgramModel> programList = [];

    for (int i = 1; i <= 4; i++) {
      weekTitles.add(Text('W$i Session 1'));
    }
    final TransformationController _transformationController =
        TransformationController();
    WeekTextInputList weekTextInputList = WeekTextInputList(
      numWeeks: 2,
      sessionsPerWeek: 2,
      exercisesPerSession: 2,
      inputProgramName: programName,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Program"),
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

  WeekTextInputList({
    required this.numWeeks,
    required this.sessionsPerWeek,
    required this.exercisesPerSession,
    required this.inputProgramName,
  });

  @override
  _WeekTextInputListState createState() => _WeekTextInputListState();

  final _WeekTextInputListState _weekTextInputListState =
      _WeekTextInputListState();
}

class _WeekTextInputListState extends State<WeekTextInputList> {
  List<List<List<List<TextEditingController>>>> _controllers = [];
  List<List<List<List<String>>>> dropdownValueState = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> weekFields = [];
    final TransformationController _transformationController =
        TransformationController();

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
                Row(
                  children: [
                    SizedBox(width: 5),
                    Text('EX ${k + 1}'),
                    SizedBox(width: 3),
                    DropdownButton(
                        value: dropdownValueState[i][j][k][0],
                        items: ['Select Exercise', 'Snatch', 'Clean and Jerk']
                            .map((String items) {
                          return DropdownMenuItem<String>(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _controllers[i][j][k][0].text = newValue.toString();
                            dropdownValueState[i][j][k][0] =
                                newValue.toString();
                          });
                        }),
                    SizedBox(width: 10),
                    Container(
                      width: 100,
                      child: TextField(
                        controller: _controllers[i][j][k][1],
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Sets'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 100,
                      child: TextField(
                        controller: _controllers[i][j][k][2],
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Reps'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 100,
                      child: TextField(
                        controller: _controllers[i][j][k][3],
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Load'),
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
                SizedBox(height: 10),
                Row(
                  children: [
                    if (i == 0) SizedBox(height: 35),
                    if (i > 0)
                      IconButton(
                        icon: Icon(Icons.content_copy),
                        onPressed: () {
                          _copyWeek(i);
                        },
                      ),
                  ],
                ),
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
        Expanded(
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

  void _copyWeek(int weekIndex) {
    if (weekIndex > 0) {
      for (int j = 0; j < widget.sessionsPerWeek; j++) {
        for (int k = 0; k < widget.exercisesPerSession; k++) {
          setState(() {
            dropdownValueState[weekIndex][j][k][0] =
                dropdownValueState[weekIndex - 1][j][k][0];
          });
          _controllers[weekIndex][j][k][0].text =
              _controllers[weekIndex - 1][j][k][0].text;
          _controllers[weekIndex][j][k][1].text =
              _controllers[weekIndex - 1][j][k][1].text;
          _controllers[weekIndex][j][k][2].text =
              _controllers[weekIndex - 1][j][k][2].text;
          _controllers[weekIndex][j][k][3].text =
              _controllers[weekIndex - 1][j][k][3].text;
          _controllers[weekIndex][j][k][4].text =
              _controllers[weekIndex - 1][j][k][4].text;
        }
      }
    }
  }

  List<ProgramModel> handleSubmit(String handleSubmitProgramName) {
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
            if (exerciseName != 'Select Exercise' &&
                    (sets != '' || reps != '') ||
                intensity != '') {
              print('made it here');
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
