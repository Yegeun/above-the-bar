import 'package:flutter/material.dart';

class AthleteProgram extends StatefulWidget {
  @override
  State<AthleteProgram> createState() => _AthleteProgramState();
}

class _AthleteProgramState extends State<AthleteProgram> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Athlete Program"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text("Program"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
