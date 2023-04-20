import 'package:above_the_bar/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    SfCartesianChart _buildChart(
        String selectedExercise, List<AthleteDataEntryModel> athleteData) {
      String titleText;
      String seriesName;
      List<AthleteDataEntryModel> filteredData;
      if (selectedExercise == 'Snatch') {
        titleText = 'Snatch Progress';
        seriesName = 'Snatch';
        filteredData =
            AthleteDataEntryModel.getFilteredExercises(athleteData, "Snatch");
      } else if (selectedExercise == 'Clean and Jerk') {
        titleText = 'Clean and Jerk Progress';
        seriesName = 'Clean and Jerk';
        filteredData = AthleteDataEntryModel.getFilteredExercises(
            athleteData, "Clean and Jerk");
      } else {
        titleText = 'Athlete Progress';
        seriesName = 'Clean and Jerk';
        filteredData = AthleteDataEntryModel.getFilteredExercises(
            athleteData, "Clean and Jerk");
      }

      return SfCartesianChart(
          title: ChartTitle(text: titleText),
          legend: Legend(isVisible: true, position: LegendPosition.top),
          primaryXAxis: DateTimeAxis(),
          primaryYAxis: NumericAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            labelFormat: '{value}kg',
          ),
          trackballBehavior: TrackballBehavior(
              enable: true,
              activationMode: ActivationMode.singleTap,
              tooltipSettings: InteractiveTooltip(
                  enable: true, format: 'point.x : point.y')),
          series: <ChartSeries>[
            // Renders line chart
            LineSeries<AthleteDataEntryModel, DateTime>(
              name: seriesName,
              dataSource: filteredData,
              xValueMapper: (AthleteDataEntryModel data, _) => data.date,
              yValueMapper: (AthleteDataEntryModel data, _) => data.load,
              dataLabelSettings: DataLabelSettings(
                  isVisible: true, labelAlignment: ChartDataLabelAlignment.top),
            ),
            LineSeries<AthleteDataEntryModel, DateTime>(
                name: 'Body Weight (kg)',
                color: Colors.red,
                dashArray: [3],
                dataSource: AthleteDataEntryModel.getFilteredExercises(
                    athleteData, selectedExercise),
                xValueMapper: (AthleteDataEntryModel data, _) => data.date,
                yValueMapper: (AthleteDataEntryModel data, _) => data.bw),
          ]);
    }

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
                  return _buildChart('Snatch', athleteData);
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
