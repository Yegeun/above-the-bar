import 'package:flutter/material.dart';

class AthleteHome extends StatefulWidget {
  @override
  State<AthleteHome> createState() => _AthleteHomeState();
}

class _AthleteHomeState extends State<AthleteHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Athlete Programming App"),
      ),
    );
  }
}
