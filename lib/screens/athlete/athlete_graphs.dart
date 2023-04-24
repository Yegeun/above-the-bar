import 'package:above_the_bar/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:above_the_bar/widgets/exercise_graphs.widget.dart';

import 'package:above_the_bar/bloc/athlete_data/athlete_data_bloc.dart';
import 'package:above_the_bar/models/models.dart';

class AthleteGraphsScreen extends StatefulWidget {
  final String athleteEmail;

  const AthleteGraphsScreen({super.key, required this.athleteEmail});

  static const routeName = 'athlete/athlete-graph';

  @override
  State<AthleteGraphsScreen> createState() => _AthleteGraphsScreenState();
}

class _AthleteGraphsScreenState extends State<AthleteGraphsScreen> {
  String _selectedExercise = 'Snatch';

  @override
  Widget build(BuildContext context) {
    //gets data from previous page
    return Scaffold(
      appBar: AppBar(
        title: const Text("Athlete Overview"),
      ),
      body: Column(
        children: [
          //Athlete Overview Header Card
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.indigo, Colors.blue],
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    "Email : ${widget.athleteEmail}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          DropdownButton(
              value: _selectedExercise,
              items: kExercises.map((String items) {
                return DropdownMenuItem<String>(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedExercise = newValue.toString();
                });
              }),
          Expanded(
            child: BlocBuilder<AthleteDataBloc, AthleteDataState>(
              builder: (context, state) {
                context
                    .read<AthleteDataBloc>()
                    .add(LoadAthleteData(widget.athleteEmail));

                if (state is AthleteDataLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is AthleteDataLoaded) {
                  final List<AthleteDataEntryModel> athleteData =
                      state.entries.toList();
                  if (athleteData.isEmpty) {
                    context
                        .read<AthleteDataBloc>()
                        .add(LoadAthleteData(widget.athleteEmail));
                  }
                  print(
                      'AthleteData ${AthleteDataEntryModel.getHighestRecordedWeightAndReps(athleteData, "Clean and Jerk")}');
                  return buildChart(_selectedExercise, athleteData);
                } else {
                  print("Error");
                  return Center(
                    child: Text("Error"),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
