import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:above_the_bar/screens/login_screen.dart';
import 'package:above_the_bar/auth_service.dart';

import '../bloc/auth/auth_bloc.dart';

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
    return const HomeView();
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.unauthenticated) {
            Navigator.push(context, LoginScreen.route());
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(context.read<AuthBloc>().state.user.email ?? ''),
            Divider(),
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutRequested());
              },
              child: Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Elite Programming App"),
//       ),
//       body: Row(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             flex: 1,
//             child: Container(
//               padding: EdgeInsets.only(bottom: 50.0),
//               alignment: Alignment.bottomCenter,
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/athlete/home');
//                 },
//                 child: Text("AthleteHomePage"),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Container(
//               padding: EdgeInsets.only(bottom: 50.0),
//               alignment: Alignment.bottomCenter,
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/coach/home');
//                 },
//                 child: Text("Coach Homepage"),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
