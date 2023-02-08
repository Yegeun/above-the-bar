import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ManagePrograms extends StatefulWidget {
  @override
  State<ManagePrograms> createState() => _ManageProgramsState();
}

class _ManageProgramsState extends State<ManagePrograms> {
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
                child: Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/coach/create-program');
                    },
                    child: Text(
                      'Create Program',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/coach/create-exercise');
                    },
                    child: Text(
                      "Create Exercise",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text("Program name 1"),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () {
                    if (kDebugMode) {
                      print('Delete');
                    }
                  },
                  child: Text("Delete"),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () {
                    if (kDebugMode) {
                      print('Copy');
                    }
                  },
                  child: Text("Copy"),
                ),
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
          ),
        ],
      ),
    );
  }
}
