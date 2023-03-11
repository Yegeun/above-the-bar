import 'package:above_the_bar/simple_bloc_observer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

import 'package:above_the_bar/bloc/blocs.dart';
import 'package:above_the_bar/repositories/repositories.dart';

import 'package:above_the_bar/screens/screens.dart';

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
          create: (_) => AthleteBloc(
            athleteRepository: AthleteRepository(),
          )..add(LoadAthlete()),
        ),
        BlocProvider(
          create: (context) => AthleteDataBloc(
            athleteDataRepository: AthleteDataRepository(),
          )..add(LoadAthleteData("example@gmail.com")),
        ),
        BlocProvider(
          create: (_) => AthleteProgramDataBloc(
            athleteProgramDataRepository: AthleteProgramDataRepository(),
          )..add(LoadAthleteProgramData()),
        ),
        BlocProvider(
          create: (_) => ExerciseBloc(
            exerciseRepository: ExerciseRepository(),
          )..add(LoadExercises()),
        ),
        BlocProvider(
          create: (_) => CreateNewExerciseBloc(
            createNewExerciseRepository: CreateNewExerciseRepository(),
          ),
        ),
        BlocProvider(
          create: (_) => ProgramBloc(
            programRepository: ProgramRepository(),
          )..add(LoadProgram()),
        ),
        BlocProvider(
          create: (_) => ProgramListBloc(
            programListRepository: ProgramRepository(),
          )..add(LoadProgramList()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.light(),
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
          '/coach/create-program': (context) => CreateProgramScreen(),
          '/coach/create-exercise': (context) => CreateExercise(),
          '/coach/add-athlete': (context) => AddAthlete(),
          '/coach/assign-athlete': (context) => AssignAthlete(),
        },
      ),
    );
  }
}
