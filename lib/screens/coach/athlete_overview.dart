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
  String _selectedExercise = 'Select Exercise';

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
                    "Overview of: ${athlete.name} | Email: ${athlete.email}",
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
                          1: FixedColumnWidth(98),
                          2: FixedColumnWidth(64),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: <TableRow>[
                          TableRow(
                            children: [
                              TableText(text: 'Exercise'),
                              TableText(text: 'Weight'),
                              TableText(text: 'Reps'),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableText(text: 'Clean and Jerk'),
                              TableText(
                                  text:
                                      '${AthleteDataEntryModel.getHighestRecordedWeightAndReps(athleteData, "Clean and Jerk")[0]} kg'),
                              TableText(
                                  text:
                                      '${AthleteDataEntryModel.getHighestRecordedWeightAndReps(athleteData, "Clean and Jerk")[1]}'),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableText(text: 'Snatch'),
                              TableText(
                                  text:
                                      '${AthleteDataEntryModel.getHighestRecordedWeightAndReps(athleteData, "Snatch")[0]} kg'),
                              TableText(
                                  text:
                                      '${AthleteDataEntryModel.getHighestRecordedWeightAndReps(athleteData, "Snatch")[1]}'),
                            ],
                          ),
                          // TableRow(
                          //   children: [
                          //     TableText(text: 'Back Squat'),
                          //     TableText(
                          //         text:
                          //             '${AthleteDataEntryModel.getHighestRecordedWeightAndReps(athleteData, "Back Squat")[0]} kg'),
                          //     TableText(
                          //         text:
                          //             '${AthleteDataEntryModel.getHighestRecordedWeightAndReps(athleteData, "Back Squat")[1]}'),
                          //   ],
                          // ),
                          // TableRow(
                          //   children: [
                          //     TableText(text: 'Front Squat'),
                          //     TableText(
                          //         text:
                          //             '${AthleteDataEntryModel.getHighestRecordedWeightAndReps(athleteData, "Front Squat")[0]} kg'),
                          //     TableText(
                          //         text:
                          //             '${AthleteDataEntryModel.getHighestRecordedWeightAndReps(athleteData, "Front Squat")[1]}'),
                          //   ],
                          // ),
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
