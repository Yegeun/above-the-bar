import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:above_the_bar/bloc/athlete_data/athlete_data_bloc.dart';
import 'package:above_the_bar/models/models.dart';

class AthleteOverview extends StatefulWidget {
  final AthleteModel athlete;

  const AthleteOverview({super.key, required this.athlete});

  static const routeName = 'coach/athleteOverview';

  @override
  State<AthleteOverview> createState() => _AthleteOverviewState();
}

class _AthleteOverviewState extends State<AthleteOverview> {
  @override
  Widget build(BuildContext context) {
    AthleteModel athlete = widget.athlete;
    //gets data from previous page
    print(athlete.name);

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
              BlocBuilder<AthleteDataBloc, AthleteDataState>(
                builder: (context, state) {
                  print(athlete.email);
                  context
                      .read<AthleteDataBloc>()
                      .add(LoadAthleteData(athlete.email));

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
                          TableRow(
                            children: [
                              TableText(text: 'Back Squat'),
                              TableText(
                                  text:
                                      '${AthleteDataEntryModel.getHighestRecordedWeightAndReps(athleteData, "Back Squat")[0]} kg'),
                              TableText(
                                  text:
                                      '${AthleteDataEntryModel.getHighestRecordedWeightAndReps(athleteData, "Back Squat")[1]}'),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableText(text: 'Front Squat'),
                              TableText(
                                  text:
                                      '${AthleteDataEntryModel.getHighestRecordedWeightAndReps(athleteData, "Front Squat")[0]} kg'),
                              TableText(
                                  text:
                                      '${AthleteDataEntryModel.getHighestRecordedWeightAndReps(athleteData, "Front Squat")[1]}'),
                            ],
                          ),
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
              Expanded(
                child: BlocBuilder<AthleteDataBloc, AthleteDataState>(
                  builder: (context, state) {
                    context
                        .read<AthleteDataBloc>()
                        .add(LoadAthleteData('yegeunator@gmail.com'));

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
                        child: SfCartesianChart(
                            title: ChartTitle(text: 'Athlete Progress'),
                            legend: Legend(
                                isVisible: true, position: LegendPosition.top),
                            primaryXAxis: DateTimeAxis(),
                            primaryYAxis: NumericAxis(
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              labelFormat: '{value}kg',
                            ),
                            trackballBehavior: TrackballBehavior(
                                enable: true,
                                activationMode: ActivationMode.singleTap,
                                tooltipSettings: InteractiveTooltip(
                                    enable: true,
                                    format: 'point.x : point.y kg')),
                            series: <ChartSeries>[
                              // Renders line chart
                              LineSeries<AthleteDataEntryModel, DateTime>(
                                name: 'Clean and Jerk',
                                dataSource:
                                    AthleteDataEntryModel.getFilteredExercises(
                                        athleteData, "Clean and Jerk"),
                                xValueMapper: (AthleteDataEntryModel data, _) =>
                                    data.date,
                                yValueMapper: (AthleteDataEntryModel data, _) =>
                                    data.load,
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                    labelAlignment:
                                        ChartDataLabelAlignment.top),
                              ),
                              LineSeries<AthleteDataEntryModel, DateTime>(
                                  name: 'Weight',
                                  color: Colors.red,
                                  dashArray: [2],
                                  dataSource: AthleteDataEntryModel
                                      .getFilteredExercises(
                                          athleteData, "Clean and Jerk"),
                                  xValueMapper:
                                      (AthleteDataEntryModel data, _) =>
                                          data.date,
                                  yValueMapper:
                                      (AthleteDataEntryModel data, _) =>
                                          data.bw),
                            ]),
                      );
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
