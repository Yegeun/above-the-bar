import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AthleteProfile extends StatefulWidget {
  final String athleteEmail;

  const AthleteProfile({super.key, required this.athleteEmail});

  @override
  State<AthleteProfile> createState() => _AthleteProfileState();
}

class _AthleteProfileState extends State<AthleteProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Athlete Profile"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Profile",
                style: TextStyle(fontSize: 30.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
