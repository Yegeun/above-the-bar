import 'package:flutter/material.dart';
import 'package:above_the_bar/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/blocs.dart';
import 'package:above_the_bar/widgets/create_exercise_widget.dart';

class CreateProgramScreen extends StatefulWidget {
  @override
  State<CreateProgramScreen> createState() => _CreateProgramScreenState();
}

class _CreateProgramScreenState extends State<CreateProgramScreen> {
  List<CreateExerciseWidget> listDynamic = [];
  List<CreateExerciseWidget> listCreateExercise = [];
  List<String> data = [];

  bool _isVisible = false;

  int vExerciseNum = 1;
  int vSessionNum = 1;
  int vWeekNum = 1;

  Icon floatingIcon = Icon(Icons.add);

  TextEditingController controllerProgName = TextEditingController();

  CreateExerciseWidget one =
      CreateExerciseWidget(week: 1, session: 1, exerciseNum: 1);
  CreateExerciseWidget two =
      CreateExerciseWidget(week: 1, session: 1, exerciseNum: 2);

  @override
  Widget build(BuildContext context) {
    List<Widget> weekTitles = [];

    for (int i = 1; i <= 4; i++) {
      weekTitles.add(Text('W$i Session 1'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Program"),
      ),
      body: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(2.0),
        minScale: 0.2,
        maxScale: 1.0,
        constrained: false,
        child: Column(
          children: [
            WeekTextInputList(
              numWeeks: 4,
              sessionsPerWeek: 5,
              exercisesPerSession: 4,
            ),
            Column(
              children: [
                Center(
                  child: BlocBuilder<ProgramBloc, ProgramState>(
                    builder: (context, state) {
                      if (state is ProgramLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is ProgramLoaded) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              listCreateExercise.add(one);
                              listCreateExercise.add(two);
                              // make a list of each exercise populated
                              // then add each list insdie the exercise using []
                              for (int i = 0;
                                  i < listCreateExercise.length;
                                  i++) {
                                context.read<ProgramBloc>().add(
                                      CreateProgram(
                                        ProgramModel(
                                          programName: controllerProgName.text
                                              .toLowerCase(),
                                          week: listCreateExercise[i].week,
                                          session:
                                              listCreateExercise[i].session,
                                          exerciseNum:
                                              listCreateExercise[i].exerciseNum,
                                          exercise: listCreateExercise[i]
                                              .getExerciseName(),
                                          sets: int.parse(
                                              listCreateExercise[i].getSets()),
                                          reps: int.parse(
                                              listCreateExercise[i].getReps()),
                                          intensity: int.parse(
                                              listCreateExercise[i].getInt()),
                                          comments: listCreateExercise[i]
                                              .getComments(),
                                        ),
                                      ),
                                    );
                                listCreateExercise[i].dispose();
                              }

                              Navigator.pop(context);
                            },
                            child: Text('Submit'),
                          ),
                        );
                      }
                      return Text(
                        'Something went wrong ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      );
                    },
                  ),
                ),
                Container(
                  width: 150,
                  margin: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controllerProgName,
                    decoration: InputDecoration(hintText: 'Name of Program'),
                  ),
                ),
                Visibility(visible: _isVisible, child: one),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    child: Text(_isVisible ? 'Delete' : 'Add Exercise')),
                two,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WeekTextInputList extends StatefulWidget {
  final int numWeeks;
  final int sessionsPerWeek;
  final int exercisesPerSession;

  WeekTextInputList({
    required this.numWeeks,
    required this.sessionsPerWeek,
    required this.exercisesPerSession,
  });

  @override
  _WeekTextInputListState createState() => _WeekTextInputListState();
}

class _WeekTextInputListState extends State<WeekTextInputList> {
  List<List<List<List<TextEditingController>>>> _controllers = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.numWeeks; i++) {
      List<List<List<TextEditingController>>> weekSessions = [];
      for (int j = 0; j < widget.sessionsPerWeek; j++) {
        List<List<TextEditingController>> sessionExercises = [];
        for (int k = 0; k < widget.exercisesPerSession; k++) {
          List<TextEditingController> exerciseFields = [];
          exerciseFields.add(TextEditingController()); // Exercise
          exerciseFields.add(TextEditingController()); // Sets
          exerciseFields.add(TextEditingController()); // Reps
          exerciseFields.add(TextEditingController()); // Load(KG)
          exerciseFields.add(TextEditingController()); // Comments
          sessionExercises.add(exerciseFields);
        }
        weekSessions.add(sessionExercises);
      }
      _controllers.add(weekSessions);
    }
  }

  void _copyWeek(int weekIndex) {
    if (weekIndex > 0) {
      for (int j = 0; j < widget.sessionsPerWeek; j++) {
        for (int k = 0; k < widget.exercisesPerSession; k++) {
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

  void _deleteWeek(int weekIndex) {
    setState(() {
      _controllers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> weekFields = [];

    for (int i = 0; i < widget.numWeeks; i++) {
      List<Widget> sessionFields = [];
      for (int j = 0; j < widget.sessionsPerWeek; j++) {
        List<Widget> exerciseFields = [];
        for (int k = 0; k < widget.exercisesPerSession; k++) {
          exerciseFields.add(
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: TextField(
                        controller: _controllers[i][j][k][0],
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'W${i + 1} S${j + 1} Ex ${k + 1}'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 100,
                      child: TextField(
                        controller: _controllers[i][j][k][1],
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), labelText: 'Sets'),
                      ),
                    ),
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
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.content_copy),
                      onPressed: () {
                        _copyWeek(i);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteWeek(i);
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

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: weekFields,
    );
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
