import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:above_the_bar/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (context) {
      return const HomeScreen();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Home Screen'),
          Divider(),
        ],
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
