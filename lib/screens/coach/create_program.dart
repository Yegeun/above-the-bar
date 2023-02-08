import 'package:flutter/material.dart';

class CreateProgram extends StatefulWidget {
  @override
  State<CreateProgram> createState() => _CreateProgramState();
}

class _CreateProgramState extends State<CreateProgram> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Program"),
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
