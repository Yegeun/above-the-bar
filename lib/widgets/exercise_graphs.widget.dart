import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:above_the_bar/models/athlete_data_entry_model.dart';

SfCartesianChart buildChart(String selectedExercise,
    List<AthleteDataEntryModel> athleteData) {
  String titleText;
  String seriesName;
  List<AthleteDataEntryModel> filteredData;

  switch (selectedExercise) {
    case 'Snatch':
      titleText = 'Snatch Progress';
      seriesName = 'Snatch';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Snatch");
      break;
    case 'Clean and Jerk':
      titleText = 'Clean and Jerk Progress';
      seriesName = 'Clean and Jerk';
      filteredData = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Clean and Jerk");
      break;
    case 'Hang Snatch':
      titleText = 'Hang Snatch Progress';
      seriesName = 'Hang Snatch';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(
              athleteData, "Hang Snatch");
      break;
    case 'Power Snatch':
      titleText = 'Power Snatch Progress';
      seriesName = 'Power Snatch';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(
              athleteData, "Power Snatch");
      break;
    case 'Snatch Deadlift':
      titleText = 'Snatch Deadlift Progress';
      seriesName = 'Snatch Deadlift';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(
              athleteData, "Snatch Deadlift");
      break;
    case 'Block Snatch':
      titleText = 'Block Snatch Progress';
      seriesName = 'Block Snatch';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(
              athleteData, "Block Snatch");
      break;
    case 'Clean':
      titleText = 'Clean Progress';
      seriesName = 'Clean';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Clean");
      break;
    case 'Hang Clean':
      titleText = 'Hang Clean Progress';
      seriesName = 'Hang Clean';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Hang Clean");
      break;
    case 'Power Clean':
      titleText = 'Power Clean Progress';
      seriesName = 'Power Clean';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(
              athleteData, "Power Clean");
      break;
    case 'Block Clean':
      titleText = 'Block Clean Progress';
      seriesName = 'Block Clean';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(
              athleteData, "Block Clean");
      break;
    case 'Clean Deadlift':
      titleText = 'Clean Deadlift Progress';
      seriesName = 'Clean Deadlift';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(
              athleteData, "Clean Deadlift");
      break;
    case 'Jerk from Rack':
      titleText = 'Jerk from Rack Progress';
      seriesName = 'Jerk from Rack';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(
              athleteData, "Jerk from Rack");
      break;
    case 'Power Jerk':
      titleText = 'Power Jerk Progress';
      seriesName = 'Power Jerk';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Power Jerk");
      break;
    case 'Jerk from Block':
      titleText = 'Jerk from Block Progress';
      seriesName = 'Jerk from Block';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(
              athleteData, "Jerk from Block");
      break;
    case 'Push Press':
      titleText = 'Push Press Progress';
      seriesName = 'Push Press';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Push Press");
      break;
    case 'Back Squat':
      titleText = 'Back Squat Progress';
      seriesName = 'Back Squat';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Back Squat");
      break;
    case 'Front Squat':
      titleText = 'Front Squat Progress';
      seriesName = 'Front Squat';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(
              athleteData, "Front Squat");
      break;
    case 'Strict Press':
      titleText = 'Strict Press Progress';
      seriesName = 'Strict Press';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(
              athleteData, "Strict Press");
      break;
    case 'Strict Row':
      titleText = 'Strict Row Progress';
      seriesName = 'Strict Row';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Strict Row");
      break;
    case 'Trunk Hold':
      titleText = 'Trunk Hold Progress';
      seriesName = 'Trunk Hold';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Trunk Hold");
      break;
    case 'Back Hold':
      titleText = 'Back Hold Progress';
      seriesName = 'Back Hold';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Back Hold");
      break;
    case 'Side Hold':
      titleText = 'Side Hold Progress';
      seriesName = 'Side Hold';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Side Hold");
      break;
    default:
      titleText = 'Athlete Progress';
      seriesName = 'Snatch';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Snatch");
      break;
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
        tooltipSettings:
        InteractiveTooltip(enable: true, format: 'point.x : point.y')),
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
    ],
  );
}
