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
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(left: 50.0, top: 10.0),
                  child: Text("Program name 1"),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () {
                    Placeholder();
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text("SAVE"),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
