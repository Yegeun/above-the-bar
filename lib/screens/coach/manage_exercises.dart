import 'package:flutter/material.dart';

class ManageExercises extends StatefulWidget {
  @override
  State<ManageExercises> createState() => _ManageExercisesState();
}

class _ManageExercisesState extends State<ManageExercises> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Programs"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text("Program name 1"),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/coach/edit');
                  },
                  child: Text("Edit Program"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
