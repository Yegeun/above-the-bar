import 'package:flutter/material.dart';

import 'package:above_the_bar/models/athlete_model.dart';

class AthleteOverview extends StatefulWidget {
  @override
  State<AthleteOverview> createState() => _AthleteOverviewState();
}

class _AthleteOverviewState extends State<AthleteOverview> {
  @override
  Widget build(BuildContext context) {
    //gets data from previous page
    final athlete = ModalRoute
        .of(context)!
        .settings
        .arguments as AthleteModel;

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
                  child: Text(
                      "Overview of ${athlete.name} email: ${athlete.email}"),
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
