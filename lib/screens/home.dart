import 'package:above_the_bar/screens/coach_home.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Elite Programming App"),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(bottom: 50.0),
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/athlete/home');
                },
                child: Text("AthleteHomePage"),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(bottom: 50.0),
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/coach/home');
                },
                child: Text("Coach Homepage"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
