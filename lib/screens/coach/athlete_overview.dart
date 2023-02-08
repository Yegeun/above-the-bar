import 'package:flutter/material.dart';

class AthleteOverview extends StatefulWidget {
  @override
  State<AthleteOverview> createState() => _AthleteOverviewState();
}

class _AthleteOverviewState extends State<AthleteOverview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Athlete Overview"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text("Athlete Overview"),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 20.0, top: 30.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                        'Athlete Current Best \n'
                        'Snatch 80 \n',
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text('Athlete Graphs'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
