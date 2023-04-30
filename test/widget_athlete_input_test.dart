import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:above_the_bar/widgets/athlete_input_widget.dart';

void main() {
  // test variables
  late int exerciseNum;
  late String exerciseName;
  late int load;
  late int sets;
  late int reps;

  // initialize variables
  setUp(() {
    exerciseNum = 1;
    exerciseName = "Squat";
    load = 150;
    sets = 3;
    reps = 10;
  });

  testWidgets('Test AthleteInputWidget', (WidgetTester tester) async {
    // build widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AthleteInputWidget(
          exerciseNum: exerciseNum,
          exerciseName: exerciseName,
          load: load,
          sets: sets,
          reps: reps,
        ),
      ),
    ));

    // get textformfields
    final exerciseNameField =
        find.widgetWithText(TextFormField, "Exercise $exerciseNum");
    final loadField = find.widgetWithText(TextFormField, "W(KG)");
    final setsField = find.widgetWithText(TextFormField, "Sets");
    final repsField = find.widgetWithText(TextFormField, "Reps");

    // verify initial values
    expect((tester.widget(exerciseNameField) as TextFormField).controller!.text,
        equals(exerciseName));
    expect((tester.widget(loadField) as TextFormField).controller!.text,
        equals(load.toString()));
    expect((tester.widget(setsField) as TextFormField).controller!.text,
        equals(sets.toString()));
    expect((tester.widget(repsField) as TextFormField).controller!.text,
        equals(reps.toString()));

    // change exercise name
    const newExerciseName = "Squat";
    await tester.enterText(exerciseNameField, newExerciseName);
    expect(exerciseName, equals(newExerciseName));

    // change load
    const newLoad = 150;
    await tester.enterText(loadField, newLoad.toString());
    expect(load, equals(newLoad));

    // change sets
    const newSets = 3;
    await tester.enterText(setsField, newSets.toString());
    expect(sets, equals(newSets));

    // change reps
    const newReps = 10;
    await tester.enterText(repsField, newReps.toString());
    expect(reps, equals(newReps));
  });
}
