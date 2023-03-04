import 'package:above_the_bar/widgets/athlete_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AthleteHome extends StatefulWidget {
  late DateTime date = DateTime.now();
  @override
  State<AthleteHome> createState() => _AthleteHomeState();
}

class _AthleteHomeState extends State<AthleteHome> {
  late DateTime date = DateTime.now();
  AthleteInputWidget ex1 = AthleteInputWidget(exerciseNum: 1);
  AthleteInputWidget ex2 = AthleteInputWidget(exerciseNum: 2);

  @override
  Widget build(BuildContext context) {
    String text = DateFormat('yyyy-MM-dd').format(date);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Athlete Programming App"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  alignment: Alignment.topCenter,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/athlete/history');
                    },
                    child: Text("History"),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  alignment: Alignment.topCenter,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/athlete/history');
                    },
                    child: Text("View Program"),
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
                  padding: EdgeInsets.only(top: 10.0),
                  alignment: Alignment.topCenter,
                  child: Text("Program"),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          // Add some space between the button and the text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Date:'),
              Container(
                width: 180,
                margin: EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () async {
                    date = (await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2024)))!;
                    setState(() {
                      text = DateFormat('yyyy-MM-dd').format(date);
                    });
                  },
                  child: Text(text),
                ),
              ),
            ],
          ),
          ex1,
          ex2,

          OutlinedButton(
              onPressed: () {
                print(ex1.controllerGetExText);
              },
              child: Text("Submit Data")),
        ],
      ),
    );
  }
}
