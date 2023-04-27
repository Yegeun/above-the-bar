import 'package:above_the_bar/screens/athlete_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:above_the_bar/bloc/athlete_profile/athlete_profile_bloc.dart';
import 'package:above_the_bar/models/models.dart';

import 'package:above_the_bar/widgets/athlete_profile_row.dart';

class AthleteProfile extends StatefulWidget {
  final String athleteEmail;

  const AthleteProfile({super.key, required this.athleteEmail});

  @override
  State<AthleteProfile> createState() => _AthleteProfileState();
}

class _AthleteProfileState extends State<AthleteProfile> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _snatchController = TextEditingController();
  final TextEditingController _cleanAndJerkController = TextEditingController();
  final TextEditingController _hangSnatchController = TextEditingController();
  final TextEditingController _powerSnatchController = TextEditingController();
  final TextEditingController _blockSnatchController = TextEditingController();
  final TextEditingController _snatchDeadliftController =
      TextEditingController();
  final TextEditingController _cleanController = TextEditingController();
  final TextEditingController _hangCleanController = TextEditingController();
  final TextEditingController _powerCleanController = TextEditingController();
  final TextEditingController _blockCleanController = TextEditingController();
  final TextEditingController _cleanDeadliftController =
      TextEditingController();
  final TextEditingController _jerkFromRackController = TextEditingController();
  final TextEditingController _powerJerkController = TextEditingController();
  final TextEditingController _jerkFromBlockController =
      TextEditingController();
  final TextEditingController _pushPressController = TextEditingController();
  final TextEditingController _backSquatController = TextEditingController();
  final TextEditingController _frontSquatController = TextEditingController();
  final TextEditingController _strictPressController = TextEditingController();
  final TextEditingController _strictRowController = TextEditingController();
  final TextEditingController _trunkHoldController = TextEditingController();
  final TextEditingController _backHoldController = TextEditingController();
  final TextEditingController _sideHoldController = TextEditingController();
  final TextEditingController _coachEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(widget.athleteEmail);
    setState(() {
      context
          .read<AthleteProfileBloc>()
          .add(LoadAthleteProfile(widget.athleteEmail));
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Athlete Profile"),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<AthleteProfileBloc, AthleteProfileState>(
          builder: (context, state) {
            if (state is AthleteProfileLoading) {
              return const CircularProgressIndicator();
            }
            if (state is AthleteProfileLoaded) {
              AthleteProfileModel athleteProfile = state.athleteProfile;
              _weightController.text = athleteProfile.weightClass.toString();
              _snatchController.text = athleteProfile.snatch.toString();
              _cleanAndJerkController.text =
                  athleteProfile.cleanAndJerk.toString();
              _hangSnatchController.text = athleteProfile.hangSnatch.toString();
              _powerSnatchController.text =
                  athleteProfile.powerSnatch.toString();
              _blockSnatchController.text =
                  athleteProfile.blockSnatch.toString();
              _snatchDeadliftController.text =
                  athleteProfile.snatchDeadlift.toString();
              _cleanController.text = athleteProfile.clean.toString();
              _hangCleanController.text = athleteProfile.hangClean.toString();
              _powerCleanController.text = athleteProfile.powerClean.toString();
              _blockCleanController.text = athleteProfile.blockClean.toString();
              _cleanDeadliftController.text =
                  athleteProfile.cleanDeadlift.toString();
              _jerkFromRackController.text =
                  athleteProfile.jerkFromRack.toString();
              _powerJerkController.text = athleteProfile.powerJerk.toString();
              _jerkFromBlockController.text =
                  athleteProfile.jerkFromBlock.toString();
              _pushPressController.text = athleteProfile.pushPress.toString();
              _backSquatController.text = athleteProfile.backSquat.toString();
              _frontSquatController.text = athleteProfile.frontSquat.toString();
              _strictPressController.text =
                  athleteProfile.strictPress.toString();
              _strictRowController.text = athleteProfile.strictRow.toString();
              _trunkHoldController.text = athleteProfile.trunkHold.toString();
              _backHoldController.text = athleteProfile.backHold.toString();
              _sideHoldController.text = athleteProfile.sideHold.toString();
              _coachEmailController.text = athleteProfile.coachEmail;
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 15.0),
                    Text(
                      "Profile Page",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Email:",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          athleteProfile.email,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ), //Email
                    AthleteProfileRow(
                      labelText: "Weight Class:",
                      controller: _weightController,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Coach Email:",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(
                          athleteProfile.coachEmail,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 300.0,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            AthleteProfileRow(
                              labelText: "Snatch",
                              controller: _snatchController,
                            ),
                            AthleteProfileRow(
                              labelText: "Clean and Jerk",
                              controller: _cleanAndJerkController,
                            ), //Clean and Jerk
                            AthleteProfileRow(
                              labelText: "Hang Snatch",
                              controller: _hangSnatchController,
                            ), //Hang Snatch
                            AthleteProfileRow(
                              labelText: "Power Snatch",
                              controller: _powerSnatchController,
                            ), //Power Snatch
                            AthleteProfileRow(
                              labelText: "Block Snatch",
                              controller: _blockSnatchController,
                            ), //Block Snatch
                            AthleteProfileRow(
                              labelText: "Snatch Deadlift",
                              controller: _snatchDeadliftController,
                            ), //Snatch Deadlift
                            AthleteProfileRow(
                              labelText: "Clean",
                              controller: _cleanController,
                            ), //Clean
                            AthleteProfileRow(
                              labelText: "Hang Clean",
                              controller: _hangCleanController,
                            ), //Hang Clean
                            AthleteProfileRow(
                              labelText: "Power Clean",
                              controller: _powerCleanController,
                            ), //Power Clean
                            AthleteProfileRow(
                              labelText: "Block Clean",
                              controller: _blockCleanController,
                            ), //Block Clean
                            AthleteProfileRow(
                              labelText: "Clean Deadlift",
                              controller: _cleanDeadliftController,
                            ), //Clean Deadlift
                            AthleteProfileRow(
                              labelText: "Jerk From Rack",
                              controller: _jerkFromRackController,
                            ), //Jerk From Rack
                            AthleteProfileRow(
                              labelText: "Power Jerk",
                              controller: _powerJerkController,
                            ), //Power Jerk
                            AthleteProfileRow(
                              labelText: "Jerk From Block",
                              controller: _jerkFromBlockController,
                            ), //Jerk From Block
                            AthleteProfileRow(
                              labelText: "Push Press",
                              controller: _pushPressController,
                            ), //Push Press
                            AthleteProfileRow(
                              labelText: "Back Squat",
                              controller: _backSquatController,
                            ), //Back Squat
                            AthleteProfileRow(
                              labelText: "Front Squat",
                              controller: _frontSquatController,
                            ), //Front Squat
                            AthleteProfileRow(
                              labelText: "Strict Press",
                              controller: _strictPressController,
                            ), //Strict Press
                            AthleteProfileRow(
                              labelText: "Strict Row",
                              controller: _strictRowController,
                            ), //Strict Row
                            AthleteProfileRow(
                              labelText: "Trunk Hold",
                              controller: _trunkHoldController,
                            ), //Trunk Hold
                            AthleteProfileRow(
                              labelText: "Back Hold",
                              controller: _backHoldController,
                            ), //Back Hold
                            AthleteProfileRow(
                              labelText: "Side Hold",
                              controller: _sideHoldController,
                            ), //Side Hold
                          ],
                        ),
                      ),
                    ), //Snatch
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              context.read<AthleteProfileBloc>().add(
                                    UpdateWeightsOnProfile(
                                      athleteProfile.email,
                                      double.parse(_weightController.text),
                                      int.parse(_snatchController.text),
                                      int.parse(_cleanAndJerkController.text),
                                      int.parse(_hangSnatchController.text),
                                      int.parse(_powerSnatchController.text),
                                      int.parse(_blockSnatchController.text),
                                      int.parse(_snatchDeadliftController.text),
                                      int.parse(_cleanController.text),
                                      int.parse(_hangCleanController.text),
                                      int.parse(_powerCleanController.text),
                                      int.parse(_blockCleanController.text),
                                      int.parse(_cleanDeadliftController.text),
                                      int.parse(_jerkFromRackController.text),
                                      int.parse(_powerJerkController.text),
                                      int.parse(_jerkFromBlockController.text),
                                      int.parse(_pushPressController.text),
                                      int.parse(_backSquatController.text),
                                      int.parse(_frontSquatController.text),
                                      int.parse(_strictPressController.text),
                                      int.parse(_strictRowController.text),
                                      int.parse(_trunkHoldController.text),
                                      int.parse(_backHoldController.text),
                                      int.parse(_sideHoldController.text),
                                    ),
                                  );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AthleteHome(
                                    userEmail: athleteProfile.email,
                                  ),
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Profile Updated Successfully'),
                              ));
                            },
                            child: Text('Update Profile')),
                      ],
                    ),
                  ],
                ),
              );
            }
            return Text('Data has not been loaded');
          },
        ),
      ),
    );
  }
}
