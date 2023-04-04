import 'package:flutter/material.dart';
import 'package:above_the_bar/models/models.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/blocs.dart';
import 'package:above_the_bar/widgets/create_exercise_widget.dart';

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
                            labelText: 'Percentage'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(?:1?\d|500|\d)$'))
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
