import 'package:flutter/material.dart';
import 'package:above_the_bar/models/models.dart';

class AthleteProgram extends StatefulWidget {
  final List<ProgramModel> program;

  const AthleteProgram({super.key, required this.program});

  @override
  State<AthleteProgram> createState() => _AthleteProgramState();
}

class _AthleteProgramState extends State<AthleteProgram> {
  @override
  Widget build(BuildContext context) {
    final viewProgram = ProgramModel.getWeeksSessionsExercises(widget.program);
    // Create a List of Lists to store the data in rows and columns
    List<Widget> weekFields = [];

    for (int i = 0; i < viewProgram.length; i++) {
      List<Widget> sessionFields = [];
      for (int j = 0; j < viewProgram[i].length; j++) {
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
        exerciseFields.add(
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                width: 150,
                child: Text('Exercise'),
              ),
              SizedBox(width: 10),
              Container(
                width: 100,
                child: Text('Sets'),
              ),
              SizedBox(width: 10),
              Container(
                width: 100,
                child: Text('Reps'),
              ),
              SizedBox(width: 10),
              Container(
                width: 100,
                child: Text('Intensity'),
              ),
              SizedBox(width: 10),
              Container(
                width: 100,
                child: Text('Comments'),
              ),
              SizedBox(width: 20),
            ],
          ),
        );
        for (int k = 0; k < viewProgram[i][j].length; k++) {
          exerciseFields.add(
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  width: 150,
                  child: Text(viewProgram[i][j][k].exercise.toString()),
                ),
                SizedBox(width: 10),
                Container(
                  width: 100,
                  child: Text(viewProgram[i][j][k].sets.toString()),
                ),
                SizedBox(width: 10),
                Container(
                  width: 100,
                  child: Text(viewProgram[i][j][k].reps.toString()),
                ),
                SizedBox(width: 10),
                Container(
                  width: 100,
                  child: Text(viewProgram[i][j][k].intensity.toString()),
                ),
                SizedBox(width: 10),
                Container(
                  width: 100,
                  child: Text(viewProgram[i][j][k].comments.toString()),
                ),
                SizedBox(width: 20),
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
                Text(
                  'Week ${i + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
            Column(
              children: sessionFields,
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Athlete Program"),
      ),
      body: Column(
        children: [
          Expanded(
            child: InteractiveViewer(
              minScale: 0.001,
              maxScale: 0.5,
              constrained: false,
              // transformationController: _transformationController,
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
                // FloatingActionButton(
                //   onPressed: () {
                //     _transformationController.value *=
                //         Matrix4.diagonal3Values(1.3, 1.3, 1);
                //   },
                //   heroTag: null,
                //   child: Icon(Icons.add),
                // ),
                SizedBox(width: 16.0),
                // FloatingActionButton(
                //   onPressed: () {
                //     _transformationController.value *=
                //         Matrix4.diagonal3Values(0.7, 0.7, 1);
                //   },
                //   heroTag: null,
                //   child: Icon(Icons.remove),
                // ),
                SizedBox(width: 16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
