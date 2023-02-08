import 'package:flutter/material.dart';

class AddAthlete extends StatefulWidget {
  @override
  State<AddAthlete> createState() => _AddAthleteState();
}

class _AddAthleteState extends State<AddAthlete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Athlete History"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text("History"),
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
