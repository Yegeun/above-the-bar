import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_service.dart';
import 'firebase_options.dart';
import 'dart:async';
import 'package:above_the_bar/bloc/blocs.dart';
import 'package:above_the_bar/repositories/repositories.dart';

import 'package:above_the_bar/screens/screens.dart';

import 'models/user_model.dart';

bool shouldUseFirestoreEmulator = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (shouldUseFirestoreEmulator) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }
  final authService = AuthService();
  final UserModel user = await authService.user.first;

  runApp(MyApp(
    authService: authService,
    user: user,
  ));
}

class MyApp extends StatelessWidget {
  final AuthService _authService;
  final UserModel user;

  const MyApp({
    super.key,
    required AuthService authService,
    this.user = UserModel.empty,
  }) : _authService = authService;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Above the Bar',
      theme: ThemeData.light(),
      home: RepositoryProvider.value(
        value: _authService,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(
                authService: _authService,
              )..add(AuthUserChanged(user)),
            ),
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
          child: AppView(),
        ),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Above the Bar',
      theme: ThemeData.light(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (_) => LoginScreen(),
            );
          case '/login':
            return MaterialPageRoute(
              builder: (_) => LoginScreen(),
            );
          case '/signup':
            return MaterialPageRoute(
              builder: (_) => SignupScreen(),
            );
          case '/athlete/home':
            return MaterialPageRoute(
              builder: (_) => AthleteHome(),
            );
          case '/athlete/history':
            return MaterialPageRoute(
              builder: (_) => AthleteHistory(),
            );
          case '/athlete/program-viewer':
            return MaterialPageRoute(
              builder: (_) => AthleteProgram(),
            );
          case '/athlete/profile':
            return MaterialPageRoute(
              builder: (_) => AthleteProfile(),
            );
          case '/coach/home':
            return MaterialPageRoute(
              builder: (_) => CoachHome(),
            );
          case '/coach/manage-programs':
            return MaterialPageRoute(
              builder: (_) => ManagePrograms(),
            );
          case '/coach/manage-exercises':
            return MaterialPageRoute(
              builder: (_) => ManageExercises(),
            );
          case '/coach/athlete-overview':
            return MaterialPageRoute(
              builder: (_) => AthleteOverview(),
            );
          case '/coach/profile':
            return MaterialPageRoute(
              builder: (_) => CoachProfile(),
            );
          case '/coach/edit':
            return MaterialPageRoute(
              builder: (_) => EditProgram(),
            );
          case '/coach/create-program':
            return MaterialPageRoute(
              builder: (_) => CreateProgramScreen(),
            );
          case '/coach/create-exercise':
            return MaterialPageRoute(
              builder: (_) => CreateExercise(),
            );
          case '/coach/add-athlete':
            return MaterialPageRoute(
              builder: (_) => AddAthlete(),
            );
          case '/coach/assign-athlete':
            return MaterialPageRoute(
              builder: (_) => AssignAthlete(),
            );
          default:
            return MaterialPageRoute(
              builder: (_) => LoginScreen(),
            );
        }
      },
    );
  }
}
