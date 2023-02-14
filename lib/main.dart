import 'package:above_the_bar/bloc/blocs.dart';
import 'package:above_the_bar/bloc/exerciselist/exercise_bloc.dart';
import 'package:above_the_bar/models/models.dart';
import 'package:above_the_bar/repositories/create_new_exercise/create_new_exercise_repository.dart';
import 'package:above_the_bar/repositories/exerciselist/exercise_repository.dart';
import 'package:above_the_bar/screens/athletes/athlete_history.dart';
import 'package:above_the_bar/screens/athletes/athlete_profile.dart';
import 'package:above_the_bar/screens/athletes/athlete_program.dart';
import 'package:above_the_bar/screens/coach/add_athlete.dart';
import 'package:above_the_bar/screens/coach/assign_athlete.dart';
import 'package:above_the_bar/screens/coach/athlete_overview.dart';
import 'package:above_the_bar/screens/coach/coach_profile.dart';
import 'package:above_the_bar/screens/coach/create_exercise.dart';
import 'package:above_the_bar/screens/coach/create_program.dart';
import 'package:above_the_bar/screens/coach/edit_program.dart';
import 'package:above_the_bar/screens/coach/manage_exercises.dart';
import 'package:above_the_bar/screens/coach/manage_programs.dart';
import 'package:above_the_bar/simple_bloc_observer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';
import 'screens/coach_home.dart';
import 'screens/home.dart';
import 'screens/athlete_home.dart';

bool shouldUseFirestoreEmulator = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (shouldUseFirestoreEmulator) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExerciseBloc(
            exerciseRepository: ExerciseRepository(),
          )..add(LoadExercises()),
        ),
        BlocProvider(
          create: (_) => CreateNewExerciseBloc(
            createNewExerciseRepository: CreateNewExerciseRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/athlete/home': (context) => AthleteHome(),
          '/athlete/history': (context) => AthleteHistory(),
          '/athlete/program-viewer': (context) => AthleteProgram(),
          '/athlete/profile': (context) => AthleteProfile(),
          '/coach/home': (context) => CoachHome(),
          '/coach/manage-programs': (context) => ManagePrograms(),
          '/coach/manage-exercises': (context) => ManageExercises(),
          '/coach/athlete-overview': (context) => AthleteOverview(),
          '/coach/profile': (context) => CoachProfile(),
          '/coach/edit': (context) => EditProgram(), // Edit through args
          '/coach/create-program': (context) => CreateProgram(),
          '/coach/create-exercise': (context) => CreateExercise(),
          '/coach/add-athlete': (context) => AddAthlete(),
          '/coach/assign-athlete': (context) => AssignAthlete(),
        },
      ),
    );
  }
}
