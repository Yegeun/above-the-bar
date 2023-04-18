import 'dart:ui';

import 'package:above_the_bar/models/exercise_model.dart';

List<Exercise> kExerciseList = [
  Exercise(
    name: 'Snatch',
  ),
  Exercise(
    name: 'Clean and Jerk',
  ),
  Exercise(
    name: 'Back Squat',
  ),
  Exercise(
    name: 'Total',
  ),
  Exercise(
    name: 'Power Snatch',
  ),
  Exercise(
    name: 'Hang Snatch',
  ),
  Exercise(
    name: 'Block Snatch',
  ),
  Exercise(
    name: 'Snatch Deadlift',
  ),
  Exercise(
    name: 'Clean',
  ),
  Exercise(
    name: 'Hang Clean',
  ),
  Exercise(
    name: 'Power Clean',
  ),
  Exercise(
    name: 'Block Clean',
  ),
  Exercise(
    name: 'Clean Deadlift',
  ),
  Exercise(
    name: 'Power Jerk',
  ),
  Exercise(
    name: 'Jerk from Rack',
  ),
  Exercise(
    name: 'Jerk from Block',
  ),
  Exercise(
    name: 'Clean Front Squat Jerk',
  ),
  Exercise(
    name: 'Push Press',
  ),
  Exercise(
    name: 'Back Squat',
  ),
  Exercise(
    name: 'Front Squat',
  ),
  Exercise(
    name: 'Strict Row',
  ),
  Exercise(
    name: 'Strict Press',
  ),
  Exercise(
    name: 'Trunk Hold',
  ),
  Exercise(
    name: 'Back Hold',
  ),
  Exercise(
    name: 'Side Hold',
  ),
];
List<String> kExercises = [
  'Select Exercise',
  'Snatch', // 0
  'Clean and Jerk', // 1
  'Hang Snatch', // 2
  'Power Snatch', // 3
  'Block Snatch', // 4
  'Clean', // 8
  'Hang Clean', // 9
  'Power Clean', // 10
  'Block Clean', // 11
  'Clean Deadlift', // 12
  'Jerk From Rack',
  'Jerk From Block',
  'Push Press',
  'Back Squat', // 6
  'Front Squat', //
  'Strict Press',
  'Strict Row',
  'Trunk Hold',
  'Back Hold',
  'Side Hold',
  'Empty', // 14
];

const kRepsSetsColour = Color(0xF0008080);
const kLoadColour = Color(0xF0DC0A87);
const kCommentsColour = Color(0xFFFFA500);
