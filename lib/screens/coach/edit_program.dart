import 'package:flutter/material.dart';

class EditProgram extends StatefulWidget {
  @override
  State<EditProgram> createState() => _EditProgramState();
}

class _EditProgramState extends State<EditProgram> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Program"),
      ),
      body: WeekTextInputListp(
        numWeeks: 4,
        sessionsPerWeek: 3,
        exercisesPerSession: 5,
      ),
    );
  }
}

class _WeekTextInputListStatep extends State<WeekTextInputListp> {
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
        }
      }
    }
  }

  void _deleteWeek(int weekIndex) {
    _controllers.removeAt(weekIndex);
    setState(
      () {
        // if (weekIndex >= 0 && weekIndex < _controllers.length) {
        //   _controllers.removeAt(weekIndex);
        //   for (int i = weekIndex; i < _controllers.length; i++) {
        //     for (int j = 0; j < widget.sessionsPerWeek; j++) {
        //       for (int k = 0; k < widget.exercisesPerSession; k++) {
        //         for (int l = 0; l < 2; l++) {
        //           _controllers[i][j][k][l].text = _controllers[i][j][k][l].text;
        //         }
        //       }
        //     }
        //   }
        // }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> weekFields = [];

    for (int i = 0; i < widget.numWeeks; i++) {
      List<Widget> sessionFields = [];
      for (int j = 0; j < widget.sessionsPerWeek; j++) {
        List<Widget> exerciseFields = [];
        exerciseFields.add(
          Row(
            children: [
              SizedBox(height: 5),
              Text('Week ${i + 1} Session ${j + 1}'),
              SizedBox(height: 5),
            ],
          ),
        );
      }
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    List<List<TextEditingController>> newSession = [];
                    for (int i = 0; i < widget.exercisesPerSession; i++) {
                      List<TextEditingController> exerciseFields = [];
                      exerciseFields.add(TextEditingController()); // Exercise
                      exerciseFields.add(TextEditingController()); // Sets
                      exerciseFields.add(TextEditingController()); // Reps
                      exerciseFields.add(TextEditingController()); // Load(KG)
                      exerciseFields.add(TextEditingController()); // Comments
                      newSession.add(exerciseFields);
                    }
                    _controllers[widget.numWeeks - 1]
                        .add(newSession); // Add session to last week
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    List<List<TextEditingController>> newSession = [];
                    for (int i = 0; i < widget.exercisesPerSession; i++) {
                      List<TextEditingController> exerciseFields = [];
                      exerciseFields.add(TextEditingController()); // Exercise
                      exerciseFields.add(TextEditingController()); // Sets
                      exerciseFields.add(TextEditingController()); // Reps
                      exerciseFields.add(TextEditingController()); // Load(KG)
                      exerciseFields.add(TextEditingController()); // Comments
                      newSession.add(exerciseFields);
                    }
                    List<List<List<TextEditingController>>> newWeek = [];
                    newWeek.add(newSession);
                    _controllers.add(newWeek); // Add week to end of list
                  });
                },
              ),
            ],
          ),
          ...weekFields,
        ],
      );
    }
    return Container();
  }
}

class WeekTextInputListp extends StatefulWidget {
  final int numWeeks;
  final int sessionsPerWeek;
  final int exercisesPerSession;

  const WeekTextInputListp({
    Key? key,
    required this.numWeeks,
    required this.sessionsPerWeek,
    required this.exercisesPerSession,
  }) : super(key: key);

  @override
  _WeekTextInputListStatep createState() => _WeekTextInputListStatep();
}
