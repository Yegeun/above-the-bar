import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:above_the_bar/bloc/athlete_data/athlete_data_bloc.dart';
import 'package:above_the_bar/models/models.dart';

class AthleteOverview extends StatefulWidget {
  final AthleteModel athlete;

  const AthleteOverview({super.key, required this.athlete});

  static const routeName = 'coach/athlete-overview';

  @override
  State<AthleteOverview> createState() => _AthleteOverviewState();
}

class _AthleteOverviewState extends State<AthleteOverview> {
  String _selectedExercise = 'Snatch';

  TableRow buildExerciseRow(
      String exerciseName, List<AthleteDataEntryModel> athleteData) {
    List<dynamic> highestRecordedData =
        AthleteDataEntryModel.getHighestRecordedWeightAndReps(
            athleteData, exerciseName);

    return TableRow(
      children: [
        TableText(text: exerciseName),
        TableText(text: '${highestRecordedData[0]} kg'),
        TableText(text: '${highestRecordedData[1]}'),
        // TableCell(
        //   child: TextButton(
        //     onPressed: () {
        //       // Do something when the button is pressed
        //     },
        //     child: Text('Button'),
        //   ),
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    AthleteModel athlete = widget.athlete;

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
                  enable: true, format: 'point.x : point.y kg')),
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
                name: 'Weight',
                color: Colors.red,
                dashArray: [2],
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
                    "Name: ${athlete.name} | Email: ${athlete.email}",
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

          Row(
            children: [
              // Table with Athlete Data
              BlocBuilder<AthleteDataBloc, AthleteDataState>(
                builder: (context, state) {
                  // context
                  //     .read<AthleteDataBloc>()
                  //     .add(LoadAthleteData(athlete.email));

                  if (state is AthleteDataLoading) {
                    // _refreshScreen(context);
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
                          .add(LoadAthleteData(athlete.email));
                    }
                    print(
                        'AthleteData ${AthleteDataEntryModel.getHighestRecordedWeightAndReps(athleteData, "Clean and Jerk")}');
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Table(
                        columnWidths: const <int, TableColumnWidth>{
                          0: FixedColumnWidth(128),
                          1: FixedColumnWidth(90),
                          2: FixedColumnWidth(64),
                          // 3: FixedColumnWidth(64),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        border: TableBorder.all(),
                        children: <TableRow>[
                          TableRow(
                            children: [
                              TableText(text: 'Exercise'),
                              TableText(text: 'Weight'),
                              TableText(text: 'Reps'),
                              // TableText(text: 'Chart'),
                            ],
                          ),
                          buildExerciseRow('Snatch', athleteData),
                          buildExerciseRow('Clean and Jerk', athleteData),
                          buildExerciseRow('Hang Snatch', athleteData),
                          buildExerciseRow('Power Snatch', athleteData),
                          buildExerciseRow('Block Snatch', athleteData),
                          buildExerciseRow('Snatch Deadlift', athleteData),
                          buildExerciseRow('Clean', athleteData),
                          buildExerciseRow('Hang Clean', athleteData),
                          buildExerciseRow('Power Clean', athleteData),
                          buildExerciseRow('Block Clean', athleteData),
                          buildExerciseRow('Clean Deadlift', athleteData),
                          buildExerciseRow('Jerk From Rack', athleteData),
                          buildExerciseRow('Power Jerk', athleteData),
                          buildExerciseRow('Jerk From Block', athleteData),
                          buildExerciseRow('Push Press', athleteData),
                          buildExerciseRow('Back Squat', athleteData),
                          buildExerciseRow('Strict Press', athleteData),
                          buildExerciseRow('Strict Row', athleteData),
                          buildExerciseRow('Trunk Hold', athleteData),
                          buildExerciseRow('Back Hold', athleteData),
                          buildExerciseRow('Side Hold', athleteData),
                        ],
                      ),
                    );
                  } else {
                    print("Error");
                    return Center(
                      child: Text("Error"),
                    );
                  }
                },
              ),
              DropdownButton(
                  value: _selectedExercise,
                  items: ['Select Exercise', 'Snatch', 'Clean and Jerk']
                      .map((String items) {
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
                        .add(LoadAthleteData(athlete.email));

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
                            .add(LoadAthleteData(athlete.email));
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
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TableText extends StatelessWidget {
  final String text;

  const TableText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontFamily: 'SourceSansPro', fontSize: 17),
    );
  }
}
