import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:above_the_bar/screens/login_screen.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/user/user_bloc.dart';
import 'athlete_home.dart';
import 'coach_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (context) {
      final authStatus = context.select((AuthBloc bloc) => bloc.state.status);
      print(authStatus);
      if (authStatus == AuthStatus.unauthenticated) {
        return const LoginScreen();
      } else {
        return const HomeScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        if (userState is UserLoading) {
          return const CircularProgressIndicator();
        }
        if (userState is UserLoaded) {
          print(userState.user);
          if (userState.user.occupation == 'athlete') {
            Navigator.pushNamed(context, '/athlete/home',
                arguments: userState.user.email);
            return Container(); // Return an empty container so that nothing is displayed before navigating
          } else if (userState.user.occupation == 'coach') {
            Navigator.pushNamed(context, '/coach/home',
                arguments: userState.user.email);
            return Container(); // Return an empty container so that nothing is displayed before navigating
          } else {
            return Container();
          }
        }
        return Container(); // Return an empty
      },
    );
    return const HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.unauthenticated) {
            Navigator.push(context, LoginScreen.route());
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            String _email = context.read<AuthBloc>().state.user.email ?? '';
            context.read<UserBloc>().add(LoadUser(_email));
            if (userState is UserLoading) {
              return const CircularProgressIndicator();
            }
            if (userState is UserLoaded) {
              print(userState.user);
              if (userState.user.occupation == 'athlete') {
                return AthleteHome(userEmail: userState.user.email);
              } else if (userState.user.occupation == 'coach') {
                return CoachHome(userEmail: userState.user.email);
              } else {
                return Container();
              }
            }
            return Container(); // Return an empty
          },
        ),
      ),
    );
  }
}
