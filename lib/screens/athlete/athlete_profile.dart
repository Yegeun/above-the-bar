import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AthleteProfile extends StatefulWidget {
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
            children: [
              Expanded(
                flex: 1,
                child: Text("Profile"),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/athlete/edit');
                  },
                  child: Text("Athlete Profile"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
