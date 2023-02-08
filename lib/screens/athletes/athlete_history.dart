import 'package:flutter/material.dart';

class AthleteHistory extends StatefulWidget {
  @override
  State<AthleteHistory> createState() => _AthleteHistoryState();
}

class _AthleteHistoryState extends State<AthleteHistory> {
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
