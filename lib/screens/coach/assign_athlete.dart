import 'package:flutter/material.dart';

class AssignAthlete extends StatefulWidget {
  @override
  State<AssignAthlete> createState() => _AssignAthleteState();
}

class _AssignAthleteState extends State<AssignAthlete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assign Athlete"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text("Athlete"),
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
