import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:above_the_bar/models/athlete_data_entry_model.dart';

SfCartesianChart buildTwoLinesChart(String selectedExercise,
    String selectedExercise2, List<AthleteDataEntryModel> athleteData) {
  List<String> titleText = ['Snatch', 'Snatch'];
  String seriesName;
  String seriesName2;
  List<AthleteDataEntryModel> filteredData;
  List<AthleteDataEntryModel> filteredData2;

  switch (selectedExercise) {
    case 'Snatch':
      titleText[0] = 'Snatch Progress';
      seriesName = 'Snatch';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Snatch");
      break;
    case 'Clean and Jerk':
      titleText[0] = 'Clean and Jerk Progress';
      seriesName = 'Clean and Jerk';
      filteredData = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Clean and Jerk");
      break;
    case 'Hang Snatch':
      titleText[0] = 'Hang Snatch Progress';
      seriesName = 'Hang Snatch';
      filteredData = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Hang Snatch");
      break;
    case 'Power Snatch':
      titleText[0] = 'Power Snatch Progress';
      seriesName = 'Power Snatch';
      filteredData = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Power Snatch");
      break;
    case 'Snatch Deadlift':
      titleText[0] = 'Snatch Deadlift Progress';
      seriesName = 'Snatch Deadlift';
      filteredData = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Snatch Deadlift");
      break;
    case 'Block Snatch':
      titleText[0] = 'Block Snatch Progress';
      seriesName = 'Block Snatch';
      filteredData = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Block Snatch");
      break;
    case 'Clean':
      titleText[0] = 'Clean Progress';
      seriesName = 'Clean';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Clean");
      break;
    case 'Hang Clean':
      titleText[0] = 'Hang Clean Progress';
      seriesName = 'Hang Clean';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Hang Clean");
      break;
    case 'Power Clean':
      titleText[0] = 'Power Clean Progress';
      seriesName = 'Power Clean';
      filteredData = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Power Clean");
      break;
    case 'Block Clean':
      titleText[0] = 'Block Clean Progress';
      seriesName = 'Block Clean';
      filteredData = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Block Clean");
      break;
    case 'Clean Deadlift':
      titleText[0] = 'Clean Deadlift Progress';
      seriesName = 'Clean Deadlift';
      filteredData = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Clean Deadlift");
      break;
    case 'Jerk from Rack':
      titleText[0] = 'Jerk from Rack Progress';
      seriesName = 'Jerk from Rack';
      filteredData = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Jerk from Rack");
      break;
    case 'Power Jerk':
      titleText[0] = 'Power Jerk Progress';
      seriesName = 'Power Jerk';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Power Jerk");
      break;
    case 'Jerk from Block':
      titleText[0] = 'Jerk from Block Progress';
      seriesName = 'Jerk from Block';
      filteredData = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Jerk from Block");
      break;
    case 'Push Press':
      titleText[0] = 'Push Press Progress';
      seriesName = 'Push Press';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Push Press");
      break;
    case 'Back Squat':
      titleText[0] = 'Back Squat Progress';
      seriesName = 'Back Squat';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Back Squat");
      break;
    case 'Front Squat':
      titleText[0] = 'Front Squat Progress';
      seriesName = 'Front Squat';
      filteredData = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Front Squat");
      break;
    case 'Strict Press':
      titleText[0] = 'Strict Press Progress';
      seriesName = 'Strict Press';
      filteredData = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Strict Press");
      break;
    case 'Strict Row':
      titleText[0] = 'Strict Row Progress';
      seriesName = 'Strict Row';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Strict Row");
      break;
    case 'Trunk Hold':
      titleText[0] = 'Trunk Hold Progress';
      seriesName = 'Trunk Hold';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Trunk Hold");
      break;
    case 'Back Hold':
      titleText[0] = 'Back Hold Progress';
      seriesName = 'Back Hold';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Back Hold");
      break;
    case 'Side Hold':
      titleText[0] = 'Side Hold Progress';
      seriesName = 'Side Hold';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Side Hold");
      break;
    default:
      titleText[0] = 'Athlete Progress';
      seriesName = 'Snatch';
      filteredData =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Snatch");
      break;
  }

  switch (selectedExercise2) {
    case 'Snatch':
      titleText[1] = 'Snatch Progress';
      seriesName2 = 'Snatch';
      filteredData2 =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Snatch");
      break;
    case 'Clean and Jerk':
      titleText[1] = 'Clean and Jerk Progress';
      seriesName2 = 'Clean and Jerk';
      filteredData2 = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Clean and Jerk");
      break;
    case 'Hang Snatch':
      titleText[1] = 'Hang Snatch Progress';
      seriesName2 = 'Hang Snatch';
      filteredData2 = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Hang Snatch");
      break;
    case 'Power Snatch':
      titleText[1] = 'Power Snatch Progress';
      seriesName2 = 'Power Snatch';
      filteredData2 = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Power Snatch");
      break;
    case 'Snatch Deadlift':
      titleText[1] = 'Snatch Deadlift Progress';
      seriesName2 = 'Snatch Deadlift';
      filteredData2 = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Snatch Deadlift");
      break;
    case 'Block Snatch':
      titleText[1] = 'Block Snatch Progress';
      seriesName2 = 'Block Snatch';
      filteredData2 = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Block Snatch");
      break;
    case 'Clean':
      titleText[1] = 'Clean Progress';
      seriesName2 = 'Clean';
      filteredData2 =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Clean");
      break;
    case 'Hang Clean':
      titleText[1] = 'Hang Clean Progress';
      seriesName2 = 'Hang Clean';
      filteredData2 =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Hang Clean");
      break;
    case 'Power Clean':
      titleText[1] = 'Power Clean Progress';
      seriesName2 = 'Power Clean';
      filteredData2 = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Power Clean");
      break;
    case 'Block Clean':
      titleText[1] = 'Block Clean Progress';
      seriesName2 = 'Block Clean';
      filteredData2 = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Block Clean");
      break;
    case 'Clean Deadlift':
      titleText[1] = 'Clean Deadlift Progress';
      seriesName2 = 'Clean Deadlift';
      filteredData2 = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Clean Deadlift");
      break;
    case 'Jerk from Rack':
      titleText[1] = 'Jerk from Rack Progress';
      seriesName2 = 'Jerk from Rack';
      filteredData2 = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Jerk from Rack");
      break;
    case 'Power Jerk':
      titleText[1] = 'Power Jerk Progress';
      seriesName2 = 'Power Jerk';
      filteredData2 =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Power Jerk");
      break;
    case 'Jerk from Block':
      titleText[1] = 'Jerk from Block Progress';
      seriesName2 = 'Jerk from Block';
      filteredData2 = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Jerk from Block");
      break;
    case 'Push Press':
      titleText[1] = 'Push Press Progress';
      seriesName2 = 'Push Press';
      filteredData2 =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Push Press");
      break;
    case 'Back Squat':
      titleText[1] = 'Back Squat Progress';
      seriesName2 = 'Back Squat';
      filteredData2 =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Back Squat");
      break;
    case 'Front Squat':
      titleText[1] = 'Front Squat Progress';
      seriesName2 = 'Front Squat';
      filteredData2 = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Front Squat");
      break;
    case 'Strict Press':
      titleText[1] = 'Strict Press Progress';
      seriesName2 = 'Strict Press';
      filteredData2 = AthleteDataEntryModel.getFilteredExercises(
          athleteData, "Strict Press");
      break;
    case 'Strict Row':
      titleText[1] = 'Strict Row Progress';
      seriesName2 = 'Strict Row';
      filteredData2 =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Strict Row");
      break;
    case 'Trunk Hold':
      titleText[1] = 'Trunk Hold Progress';
      seriesName2 = 'Trunk Hold';
      filteredData2 =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Trunk Hold");
      break;
    case 'Back Hold':
      titleText[1] = 'Back Hold Progress';
      seriesName2 = 'Back Hold';
      filteredData2 =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Back Hold");
      break;
    case 'Side Hold':
      titleText[1] = 'Side Hold Progress';
      seriesName2 = 'Side Hold';
      filteredData2 =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Side Hold");
      break;
    default:
      titleText[1] = 'Athlete Progress';
      seriesName2 = 'Snatch';
      filteredData2 =
          AthleteDataEntryModel.getFilteredExercises(athleteData, "Snatch");
      break;
  }

  return SfCartesianChart(
    title: ChartTitle(text: '${titleText[0]} + ${titleText[1]}'),
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
        name: seriesName2,
        dataSource: filteredData2,
        xValueMapper: (AthleteDataEntryModel data1, _) => data1.date,
        yValueMapper: (AthleteDataEntryModel data1, _) => data1.load,
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
