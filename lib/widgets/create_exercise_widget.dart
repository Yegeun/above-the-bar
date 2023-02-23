import 'package:flutter/material.dart';

class CreateExerciseWidget extends StatelessWidget {
  CreateExerciseWidget(
      {required this.week, required this.session, required this.exerciseNum});

  final int week;
  final int session;
  final int exerciseNum;

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          margin: EdgeInsets.all(8.0),
          child: TextField(
            controller: controller1,
            decoration: InputDecoration(hintText: 'Exercise' '$exerciseNum'),
          ),
        ),
        Container(
          width: 100,
          margin: EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Sets'),
          ),
        ),
        Container(
          width: 100,
          margin: EdgeInsets.all(8.0),
          child: TextField(
            controller: controller1,
            decoration: InputDecoration(hintText: 'Reps'),
          ),
        ),
        Container(
          width: 100,
          margin: EdgeInsets.all(8.0),
          child: TextField(
            controller: controller1,
            decoration: InputDecoration(hintText: 'Intensity'),
          ),
        ),
        Container(
          width: 100,
          margin: EdgeInsets.all(8.0),
          child: TextField(
            controller: controller1,
            decoration: InputDecoration(hintText: 'Comments'),
          ),
        ),
      ],
    );
  }
}
